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

  /// Language code used to pick clinical content text.
  String get lang => Localizations.localeOf(this).languageCode;

  /// 14 Oct 2026
  String formatDate(DateTime d) => DateFormat.yMMMd(intlLocale).format(d);

  /// 14 October 2026
  String formatLongDate(DateTime d) => DateFormat.yMMMMd(intlLocale).format(d);

  /// 14 Oct
  String formatShortDate(DateTime d) => DateFormat.MMMd(intlLocale).format(d);

  /// October 14
  String formatDayMonth(DateTime d) => DateFormat.MMMMd(intlLocale).format(d);

  /// Wednesday, 14 October
  String formatWeekdayDate(DateTime d) =>
      DateFormat.MMMMEEEEd(intlLocale).format(d);

  /// October 2026
  String formatMonth(DateTime d) => DateFormat.yMMMM(intlLocale).format(d);

  String formatTime(DateTime d) => DateFormat.jm(intlLocale).format(d);

  /// 14 Oct, 9:30 AM
  String formatDateTime(DateTime d) =>
      '${formatShortDate(d)}, ${formatTime(d)}';

  String formatNumber(num n, [int decimals = 0]) {
    final f = NumberFormat.decimalPattern(intlLocale)
      ..minimumFractionDigits = decimals
      ..maximumFractionDigits = decimals;
    return f.format(n);
  }

  /// RM 1,050
  String formatMoney(double v) => 'RM ${formatNumber(v, v % 1 == 0 ? 0 : 2)}';
}

/// mm:ss for counters and timers.
String formatDuration(Duration d) {
  final s = d.inSeconds < 0 ? 0 : d.inSeconds;
  return '${(s ~/ 60).toString().padLeft(2, '0')}:${(s % 60).toString().padLeft(2, '0')}';
}
