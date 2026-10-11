import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'integration_config.dart';

enum VerifyError { notConfigured, sendFailed, cancelled }

class VerifyException implements Exception {
  const VerifyException(this.error, [this.detail = '']);
  final VerifyError error;
  final String detail;

  @override
  String toString() => 'VerifyException($error, $detail)';
}

/// Sends and checks one-time codes, and runs Google / Microsoft sign-in.
/// The live one uses EmailJS (email) and Firebase (SMS, Google); tests use a
/// fake.
abstract class VerificationService {
  Future<void> sendEmailCode(String email);
  bool checkEmailCode(String email, String code);

  Future<void> sendSmsCode(String phone);

  /// True when Android read the SMS by itself, so no code needs typing.
  bool get smsAutoVerified;
  Future<bool> checkSmsCode(String code);

  /// Returns the verified email address of the account picked.
  Future<String> signInWith(String provider);
}

final verificationProvider = Provider<VerificationService>(
  (ref) => LiveVerification(ref.watch(integrationConfigProvider)),
);

/// Malaysian numbers typed locally (012-345 6789) become +60123456789.
String toE164(String phone) {
  var p = phone.replaceAll(RegExp(r'[\s\-()]'), '');
  if (p.startsWith('00')) p = '+${p.substring(2)}';
  if (p.startsWith('0')) p = '+60${p.substring(1)}';
  if (!p.startsWith('+')) p = '+$p';
  return p;
}

class LiveVerification implements VerificationService {
  LiveVerification(this.config, {http.Client? client})
    : _http = client ?? http.Client();

  final IntegrationConfig config;
  final http.Client _http;

  static final _emailCodes = <String, (String, DateTime)>{};
  static String? _verificationId;
  static bool _autoVerified = false;

  // ---- Email: a 6-digit code sent through EmailJS (e.g. a Gmail service).

  @override
  Future<void> sendEmailCode(String email) async {
    if (!config.hasEmail) {
      throw const VerifyException(VerifyError.notConfigured);
    }
    final code = (Random.secure().nextInt(900000) + 100000).toString();
    final expires = DateTime.now().add(const Duration(minutes: 10));
    final privateKey = config[IntegrationKey.emailJsPrivateKey];
    final http.Response res;
    try {
      res = await _http
          .post(
            Uri.https('api.emailjs.com', '/api/v1.0/email/send'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'service_id': config[IntegrationKey.emailJsServiceId],
              'template_id': config[IntegrationKey.emailJsTemplateId],
              'user_id': config[IntegrationKey.emailJsPublicKey],
              if (privateKey.isNotEmpty) 'accessToken': privateKey,
              'template_params': {
                'to_email': email,
                'email': email,
                'passcode': code,
                'code': code,
                'app_name': 'Maternal',
                'time':
                    '${expires.hour.toString().padLeft(2, '0')}:'
                    '${expires.minute.toString().padLeft(2, '0')}',
              },
            }),
          )
          .timeout(const Duration(seconds: 30));
    } on Exception catch (e) {
      throw VerifyException(VerifyError.sendFailed, '$e');
    }
    if (res.statusCode != 200) {
      throw VerifyException(
        VerifyError.sendFailed,
        'EmailJS ${res.statusCode}: ${res.body}',
      );
    }
    _emailCodes[email.toLowerCase()] = (code, expires);
  }

  @override
  bool checkEmailCode(String email, String code) {
    final sent = _emailCodes[email.toLowerCase()];
    if (sent == null || DateTime.now().isAfter(sent.$2)) return false;
    final ok = sent.$1 == code.trim();
    if (ok) _emailCodes.remove(email.toLowerCase());
    return ok;
  }

  // ---- Firebase: SMS codes and Google / Microsoft sign-in.

  Future<FirebaseAuth> _auth() async {
    if (!config.hasFirebase) {
      throw const VerifyException(VerifyError.notConfigured);
    }
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: config[IntegrationKey.firebaseApiKey],
            appId: config[IntegrationKey.firebaseAppId],
            messagingSenderId: config[IntegrationKey.firebaseSenderId],
            projectId: config[IntegrationKey.firebaseProjectId],
          ),
        );
      }
    } on Exception catch (e) {
      throw VerifyException(VerifyError.sendFailed, '$e');
    }
    return FirebaseAuth.instance;
  }

  @override
  Future<void> sendSmsCode(String phone) async {
    final auth = await _auth();
    final done = Completer<void>();
    _verificationId = null;
    _autoVerified = false;
    await auth.verifyPhoneNumber(
      phoneNumber: toE164(phone),
      timeout: const Duration(seconds: 60),
      verificationCompleted: (cred) async {
        // Android read the SMS itself.
        try {
          await auth.signInWithCredential(cred);
          _autoVerified = true;
        } on FirebaseAuthException {
          _autoVerified = false;
        }
        if (!done.isCompleted) done.complete();
      },
      verificationFailed: (e) {
        if (!done.isCompleted) {
          done.completeError(
            VerifyException(VerifyError.sendFailed, e.message ?? e.code),
          );
        }
      },
      codeSent: (id, _) {
        _verificationId = id;
        if (!done.isCompleted) done.complete();
      },
      codeAutoRetrievalTimeout: (id) => _verificationId ??= id,
    );
    return done.future.timeout(
      const Duration(seconds: 90),
      onTimeout: () => throw const VerifyException(
        VerifyError.sendFailed,
        'No answer from Firebase.',
      ),
    );
  }

  @override
  bool get smsAutoVerified => _autoVerified;

  @override
  Future<bool> checkSmsCode(String code) async {
    if (_autoVerified) return true;
    final id = _verificationId;
    if (id == null) return false;
    final auth = await _auth();
    try {
      await auth.signInWithCredential(
        PhoneAuthProvider.credential(verificationId: id, smsCode: code.trim()),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code' ||
          e.code == 'session-expired') {
        return false;
      }
      throw VerifyException(VerifyError.sendFailed, e.message ?? e.code);
    }
  }

  @override
  Future<String> signInWith(String provider) async {
    final auth = await _auth();
    try {
      final result = await auth.signInWithProvider(
        provider == 'Microsoft'
            ? (OAuthProvider('microsoft.com')..addScope('email'))
            : (GoogleAuthProvider()..addScope('email')),
      );
      final email =
          result.user?.email ??
          result.additionalUserInfo?.profile?['email'] as String?;
      if (email == null) {
        throw const VerifyException(
          VerifyError.sendFailed,
          'The account has no email address.',
        );
      }
      return email.toLowerCase();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'web-context-canceled' || e.code == 'canceled') {
        throw const VerifyException(VerifyError.cancelled);
      }
      throw VerifyException(VerifyError.sendFailed, e.message ?? e.code);
    }
  }
}
