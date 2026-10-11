import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/local_store.dart';

/// Keys for the outside services the app can use. Each value comes from the
/// build (`--dart-define`, filled from GitHub secrets in CI) and can be
/// overridden on the phone in Profile > Connections, so a tester can try a
/// service without a new build.
enum IntegrationKey {
  geminiApiKey('GEMINI_API_KEY', String.fromEnvironment('GEMINI_API_KEY')),
  geminiModel(
    'GEMINI_MODEL',
    String.fromEnvironment('GEMINI_MODEL', defaultValue: 'gemini-flash-latest'),
  ),
  emailJsServiceId(
    'EMAILJS_SERVICE_ID',
    String.fromEnvironment('EMAILJS_SERVICE_ID'),
  ),
  emailJsTemplateId(
    'EMAILJS_TEMPLATE_ID',
    String.fromEnvironment('EMAILJS_TEMPLATE_ID'),
  ),
  emailJsPublicKey(
    'EMAILJS_PUBLIC_KEY',
    String.fromEnvironment('EMAILJS_PUBLIC_KEY'),
  ),
  emailJsPrivateKey(
    'EMAILJS_PRIVATE_KEY',
    String.fromEnvironment('EMAILJS_PRIVATE_KEY'),
  ),
  googleClientId(
    'GOOGLE_SERVER_CLIENT_ID',
    String.fromEnvironment('GOOGLE_SERVER_CLIENT_ID'),
  );

  const IntegrationKey(this.envName, this.buildValue);

  /// The GitHub secret / `--dart-define` name.
  final String envName;
  final String buildValue;

  /// Hidden like a password on the Connections page.
  bool get secret => switch (this) {
    geminiApiKey || emailJsPrivateKey => true,
    _ => false,
  };
}

/// The values in force: a value saved on the phone wins over the build's.
class IntegrationConfig {
  const IntegrationConfig(this._values);

  final Map<IntegrationKey, String> _values;

  String operator [](IntegrationKey k) => _values[k] ?? '';

  bool _all(List<IntegrationKey> keys) => keys.every((k) => this[k].isNotEmpty);

  bool get hasGemini => _all([IntegrationKey.geminiApiKey]);

  bool get hasEmail => _all([
    IntegrationKey.emailJsServiceId,
    IntegrationKey.emailJsTemplateId,
    IntegrationKey.emailJsPublicKey,
  ]);

  bool get hasGoogle => _all([IntegrationKey.googleClientId]);
}

final integrationConfigProvider =
    NotifierProvider<IntegrationController, IntegrationConfig>(
      IntegrationController.new,
    );

class IntegrationController extends Notifier<IntegrationConfig> {
  static String _key(IntegrationKey k) => 'integration.${k.envName}';

  @override
  IntegrationConfig build() {
    final store = ref.read(localStoreProvider);
    return IntegrationConfig({
      for (final k in IntegrationKey.values)
        k: (store.readString(_key(k)) ?? '').trim().isNotEmpty
            ? store.readString(_key(k))!.trim()
            : k.buildValue,
    });
  }

  /// Saves a phone-side value. An empty value goes back to the build's value.
  Future<void> set(IntegrationKey k, String value) async {
    await ref.read(localStoreProvider).writeString(_key(k), value.trim());
    ref.invalidateSelf();
  }

  /// True when this value was typed on the phone, not built in.
  bool isLocal(IntegrationKey k) =>
      (ref.read(localStoreProvider).readString(_key(k)) ?? '')
          .trim()
          .isNotEmpty;
}
