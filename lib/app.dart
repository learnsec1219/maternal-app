import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/settings/locale_controller.dart';
import 'features/shell/app_shell.dart';
import 'l10n/app_localizations.dart';

class MaternalApp extends ConsumerWidget {
  const MaternalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp(
    title: 'Maternal',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light(),
    locale: ref.watch(localeProvider),
    supportedLocales: supportedAppLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: const AppShell(),
  );
}
