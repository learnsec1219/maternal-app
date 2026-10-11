import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:clock/clock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'integration_config.dart';

enum VerifyError { notConfigured, sendFailed }

class VerifyException implements Exception {
  const VerifyException(this.error, [this.detail = '']);
  final VerifyError error;
  final String detail;

  @override
  String toString() => 'VerifyException($error, $detail)';
}

/// Sends and checks one-time email codes. The live one uses EmailJS (for
/// example through a Gmail account); tests use a fake.
abstract class VerificationService {
  Future<void> sendEmailCode(String email);
  bool checkEmailCode(String email, String code);
}

/// How long an email code can be used after it is sent.
const emailCodeLife = Duration(seconds: 90);

final verificationProvider = Provider<VerificationService>(
  (ref) => LiveVerification(ref.watch(integrationConfigProvider)),
);

class LiveVerification implements VerificationService {
  LiveVerification(this.config, {http.Client? client})
    : _http = client ?? http.Client();

  final IntegrationConfig config;
  final http.Client _http;

  static final _emailCodes = <String, (String, DateTime)>{};

  // ---- Email: a 6-digit code sent through EmailJS (e.g. a Gmail service).

  @override
  Future<void> sendEmailCode(String email) async {
    if (!config.hasEmail) {
      throw const VerifyException(VerifyError.notConfigured);
    }
    final code = (Random.secure().nextInt(900000) + 100000).toString();
    final expires = clock.now().add(emailCodeLife);
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
                    '${expires.minute.toString().padLeft(2, '0')}:'
                    '${expires.second.toString().padLeft(2, '0')}',
                'minutes': '1.5',
                'seconds': '${emailCodeLife.inSeconds}',
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
    if (sent == null || clock.now().isAfter(sent.$2)) return false;
    final ok = sent.$1 == code.trim();
    if (ok) _emailCodes.remove(email.toLowerCase());
    return ok;
  }
}
