import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'integration_config.dart';

/// The details Google shares with the basic sign-in: name, email and photo.
class GoogleProfile {
  const GoogleProfile({required this.email, this.name, this.photoUrl});

  final String email;
  final String? name, photoUrl;
}

enum GoogleAuthError { notConfigured, failed }

class GoogleAuthException implements Exception {
  const GoogleAuthException(this.error, [this.detail = '']);
  final GoogleAuthError error;
  final String detail;

  @override
  String toString() => detail.isEmpty ? error.name : detail;
}

abstract class GoogleAuth {
  /// Shows Google's account picker. Null when the person closes it.
  Future<GoogleProfile?> signIn();

  /// Forgets the Google account on this phone, so the picker shows next time.
  Future<void> signOut();
}

/// Google sign-in through Android's Credential Manager. Needs the Web client
/// ID of a Google Cloud project that also has an Android client for this
/// app's package name and signing key (see docs/integrations-setup.md).
class RealGoogleAuth implements GoogleAuth {
  RealGoogleAuth(this.clientId);

  final String clientId;

  // The plugin can be initialised once per app run.
  static Future<void>? _init;

  Future<void> _ready() =>
      _init ??= GoogleSignIn.instance.initialize(serverClientId: clientId);

  @override
  Future<GoogleProfile?> signIn() async {
    if (clientId.isEmpty) {
      throw const GoogleAuthException(GoogleAuthError.notConfigured);
    }
    try {
      await _ready();
      final a = await GoogleSignIn.instance.authenticate();
      return GoogleProfile(
        email: a.email,
        name: a.displayName,
        photoUrl: a.photoUrl,
      );
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled ||
          e.code == GoogleSignInExceptionCode.interrupted) {
        return null;
      }
      throw GoogleAuthException(
        GoogleAuthError.failed,
        e.description ?? e.code.name,
      );
    }
  }

  @override
  Future<void> signOut() async {
    if (_init == null) return;
    try {
      await GoogleSignIn.instance.signOut();
    } on Object {
      // Signing out of the app still works if Google can't be reached.
    }
  }
}

final googleAuthProvider = Provider<GoogleAuth>(
  (ref) => RealGoogleAuth(
    ref.watch(integrationConfigProvider)[IntegrationKey.googleClientId],
  ),
);
