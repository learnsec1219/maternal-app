import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// Locale name understood by `package:intl` date formatting.
  String get intlLocale {
    final locale = Localizations.localeOf(this);
    return locale.languageCode == 'zh' ? 'zh_TW' : locale.languageCode;
  }

  String formatDate(DateTime d) => DateFormat.yMMMd(intlLocale).format(d);
  String formatShortDate(DateTime d) => DateFormat.MMMd(intlLocale).format(d);
  String formatTime(DateTime d) => DateFormat.jm(intlLocale).format(d);
}
