import 'package:flutter/material.dart';

/// Brand palette: soft neutrals, white cards and a muted grey-pink accent.
abstract final class AppColors {
  static const rose = Color(0xFFB07A8C);
  static const roseDeep = Color(0xFF8E5A6D);
  static const roseSoft = Color(0xFFF6E8ED);
  static const background = Color(0xFFFAF7F8);
  static const ink = Color(0xFF2E2A2C);
  static const muted = Color(0xFF6F6669);
  static const line = Color(0xFFEDE5E8);

  static const period = Color(0xFFC75B7A);
  static const predicted = Color(0xFFEBC3D0);
  static const fertile = Color(0xFFCFE3F2);
  static const ovulation = Color(0xFF4F86B5);

  static const safe = Color(0xFF1F6E5C);
  static const safeBg = Color(0xFFDDF2EC);
  static const warn = Color(0xFFB45309);
  static const warnBg = Color(0xFFFCEEDC);
  static const danger = Color(0xFFB3261E);
  static const dangerBg = Color(0xFFFBE7E4);
}

abstract final class AppTheme {
  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.rose,
      primary: AppColors.rose,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: AppColors.ink,
      error: AppColors.danger,
    );
    final base = ThemeData(colorScheme: scheme, useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.line),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.line),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
      ),
    );
  }
}
