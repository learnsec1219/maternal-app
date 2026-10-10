import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'data/session.dart';
import 'features/settings/locale_controller.dart';
import 'features/shell/root_gate.dart';
import 'l10n/app_localizations.dart';

class MaternalApp extends ConsumerWidget {
  const MaternalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp(
    title: 'Maternal Care',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    themeMode: ref.watch(appearanceProvider).themeMode,
    locale: ref.watch(localeProvider),
    supportedLocales: supportedAppLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    // Large system font sizes still scale text, but only up to 1.3x so
    // layouts stay readable on small phones.
    builder: (context, child) => MediaQuery.withClampedTextScaling(
      minScaleFactor: 0.85,
      maxScaleFactor: 1.3,
      child: child!,
    ),
    home: const RootGate(),
  );
}
