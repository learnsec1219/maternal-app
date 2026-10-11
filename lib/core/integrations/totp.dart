import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/local_store.dart';

const _alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';

/// RFC 4648 base32 without padding, as authenticator apps expect.
String base32Encode(List<int> bytes) {
  final out = StringBuffer();
  var buffer = 0, bits = 0;
  for (final b in bytes) {
    buffer = (buffer << 8) | b;
    bits += 8;
    while (bits >= 5) {
      out.write(_alphabet[(buffer >> (bits - 5)) & 31]);
      bits -= 5;
    }
  }
  if (bits > 0) out.write(_alphabet[(buffer << (5 - bits)) & 31]);
  return out.toString();
}

Uint8List base32Decode(String text) {
  final clean = text.toUpperCase().replaceAll(RegExp(r'[\s=-]'), '');
  final out = <int>[];
  var buffer = 0, bits = 0;
  for (final ch in clean.split('')) {
    final v = _alphabet.indexOf(ch);
    if (v < 0) throw FormatException('Not base32: $ch');
    buffer = (buffer << 5) | v;
    bits += 5;
    if (bits >= 8) {
      out.add((buffer >> (bits - 8)) & 0xff);
      bits -= 8;
    }
  }
  return Uint8List.fromList(out);
}

/// Time-based one-time codes (RFC 6238: SHA-1, 6 digits, 30 seconds), the
/// kind Google Authenticator, Microsoft Authenticator and Authy show.
abstract final class Totp {
  static const digits = 6, period = 30;

  /// A new random 160-bit secret in base32.
  static String newSecret([Random? random]) {
    final r = random ?? Random.secure();
    return base32Encode([for (var i = 0; i < 20; i++) r.nextInt(256)]);
  }

  static String codeAt(String secret, DateTime time) {
    final counter = time.millisecondsSinceEpoch ~/ 1000 ~/ period;
    final msg = ByteData(8)..setInt64(0, counter);
    final hash = Hmac(
      sha1,
      base32Decode(secret),
    ).convert(msg.buffer.asUint8List()).bytes;
    final offset = hash.last & 0x0f;
    final bin =
        ((hash[offset] & 0x7f) << 24) |
        (hash[offset + 1] << 16) |
        (hash[offset + 2] << 8) |
        hash[offset + 3];
    return (bin % 1000000).toString().padLeft(digits, '0');
  }

  /// Accepts the current code and the one before or after it, to allow for
  /// a phone clock that is a little off.
  static bool verify(String secret, String code, DateTime now) {
    final c = code.replaceAll(RegExp(r'\s'), '');
    if (c.length != digits) return false;
    for (final step in const [-1, 0, 1]) {
      if (codeAt(secret, now.add(Duration(seconds: step * period))) == c) {
        return true;
      }
    }
    return false;
  }

  /// The link authenticator apps read from a QR code or open directly.
  static Uri uri({
    required String secret,
    required String account,
    String issuer = 'Maternal',
  }) => Uri(
    scheme: 'otpauth',
    host: 'totp',
    path: '/$issuer:$account',
    queryParameters: {
      'secret': secret,
      'issuer': issuer,
      'digits': '$digits',
      'period': '$period',
    },
  );
}

/// Authenticator secrets by profile id, kept on this phone.
final totpStoreProvider = NotifierProvider<TotpStore, Map<String, String>>(
  TotpStore.new,
);

class TotpStore extends Notifier<Map<String, String>> {
  static const _key = 'auth.totpSecrets';

  @override
  Map<String, String> build() =>
      (ref.read(localStoreProvider).readMap(_key) ?? const {})
          .cast<String, String>();

  bool has(String personId) => state.containsKey(personId);

  Future<void> enable(String personId, String secret) async {
    state = {...state, personId: secret};
    await ref.read(localStoreProvider).writeJson(_key, state);
  }

  Future<void> disable(String personId) async {
    state = {...state}..remove(personId);
    await ref.read(localStoreProvider).writeJson(_key, state);
  }
}
