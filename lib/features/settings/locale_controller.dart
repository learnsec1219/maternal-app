import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/storage/local_store.dart';

/// A language offered in the switcher.
class AppLanguage {
  const AppLanguage(this.locale, {required this.short, required this.native});

  final Locale locale;

  /// Label inside the switcher's circle.
  final String short;

  /// The language's name in that language, for screen readers.
  final String native;
}

/// Languages in switcher order.
const appLanguages = [
  AppLanguage(
    Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hant',
      countryCode: 'TW',
    ),
    short: '中文',
    native: '繁體中文',
  ),
  AppLanguage(Locale('en'), short: 'EN', native: 'English'),
  AppLanguage(Locale('ms'), short: 'BM', native: 'Bahasa Melayu'),
  AppLanguage(Locale('ta'), short: 'தமிழ்', native: 'தமிழ்'),
];

final supportedAppLocales = [for (final l in appLanguages) l.locale];

AppLanguage languageFor(Locale locale) => appLanguages.firstWhere(
  (l) => l.locale.languageCode == locale.languageCode,
  orElse: () => appLanguages[1],
);

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
