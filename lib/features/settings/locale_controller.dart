import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/storage/local_store.dart';

/// Languages offered in the switcher, in display order.
const supportedAppLocales = [
  Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
  Locale('en'),
  Locale('ms'),
];

final localeProvider = NotifierProvider<LocaleController, Locale>(
  LocaleController.new,
);

class LocaleController extends Notifier<Locale> {
  static const _key = 'settings.locale';

  @override
  Locale build() {
    final code = ref.read(localStoreProvider).readString(_key);
    return supportedAppLocales.firstWhere(
      (l) => l.languageCode == code,
      orElse: () => const Locale('en'),
    );
  }

  void set(Locale locale) {
    state = locale;
    ref.read(localStoreProvider).writeString(_key, locale.languageCode);
  }
}
