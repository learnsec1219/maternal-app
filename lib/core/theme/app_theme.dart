import 'package:flutter/material.dart';

/// App colors for one brightness. Mirrors the web demo's palette so the
/// phone build looks the same; read it with `context.pal`.
@immutable
class Palette extends ThemeExtension<Palette> {
  const Palette({
    required this.background,
    required this.card,
    required this.ink,
    required this.muted,
    required this.line,
    required this.rose,
    required this.onRose,
    required this.roseSoft,
    required this.roseTint,
    required this.peach,
    required this.sand,
    required this.sage,
    required this.lavender,
    required this.sky,
    required this.butter,
    required this.good,
    required this.goodSoft,
    required this.warn,
    required this.warnSoft,
    required this.alert,
    required this.alertSoft,
    required this.period,
    required this.periodSoft,
    required this.fertile,
    required this.fertileSoft,
    required this.pending,
    required this.pendingSoft,
    required this.symptom,
  });

  final Color background, card, ink, muted, line;
  final Color rose, onRose, roseSoft, roseTint;
  final Color peach, sand, sage, lavender, sky, butter;
  final Color good, goodSoft, warn, warnSoft, alert, alertSoft;
  final Color period, periodSoft, fertile, fertileSoft;
  final Color pending, pendingSoft, symptom;

  static const light = Palette(
    background: Color(0xFFFBF6F5),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF3E2C2E),
    muted: Color(0xFF7A6668),
    line: Color(0xFFEDE2E0),
    rose: Color(0xFFA4636C),
    onRose: Color(0xFFFFFFFF),
    roseSoft: Color(0xFFF4E3E2),
    roseTint: Color(0xFFEFD3CF),
    peach: Color(0xFFF8E3D6),
    sand: Color(0xFFEFE6D8),
    sage: Color(0xFFDDEBE4),
    lavender: Color(0xFFE8E2F1),
    sky: Color(0xFFDFE8F4),
    butter: Color(0xFFFBF0CF),
    good: Color(0xFF2E7A60),
    goodSoft: Color(0xFFDDF0E7),
    warn: Color(0xFF8F5A10),
    warnSoft: Color(0xFFFBEBD3),
    alert: Color(0xFFB03A35),
    alertSoft: Color(0xFFF9E1DE),
    period: Color(0xFFC2475A),
    periodSoft: Color(0xFFF6D9DD),
    fertile: Color(0xFF2F7D75),
    fertileSoft: Color(0xFFD9EEEB),
    pending: Color(0xFF7A5C00),
    pendingSoft: Color(0xFFFCEDA8),
    symptom: Color(0xFFE3B505),
  );

  static const dark = Palette(
    background: Color(0xFF181314),
    card: Color(0xFF241C1D),
    ink: Color(0xFFF3E9E8),
    muted: Color(0xFFB7A5A6),
    line: Color(0xFF3A2F30),
    rose: Color(0xFFE0A3AA),
    onRose: Color(0xFF231A1B),
    roseSoft: Color(0xFF3D2A2C),
    roseTint: Color(0xFF4A3033),
    peach: Color(0xFF3F2E25),
    sand: Color(0xFF39322A),
    sage: Color(0xFF243530),
    lavender: Color(0xFF2F2A3A),
    sky: Color(0xFF26303D),
    butter: Color(0xFF3A341F),
    good: Color(0xFF8ED9BC),
    goodSoft: Color(0xFF1E352C),
    warn: Color(0xFFF0C27A),
    warnSoft: Color(0xFF3A2D18),
    alert: Color(0xFFF2A39C),
    alertSoft: Color(0xFF3D2322),
    period: Color(0xFFF08A9A),
    periodSoft: Color(0xFF4A2A30),
    fertile: Color(0xFF8FD3CB),
    fertileSoft: Color(0xFF1F3936),
    pending: Color(0xFFF2D46B),
    pendingSoft: Color(0xFF3B3314),
    symptom: Color(0xFFF2D046),
  );

  @override
  Palette copyWith() => this;

  @override
  Palette lerp(ThemeExtension<Palette>? other, double t) =>
      t < 0.5 || other is! Palette ? this : other;
}

extension PaletteContext on BuildContext {
  Palette get pal => Theme.of(this).extension<Palette>() ?? Palette.light;
}

abstract final class AppTheme {
  static ThemeData light() => _build(Palette.light, Brightness.light);
  static ThemeData dark() => _build(Palette.dark, Brightness.dark);

  static ThemeData _build(Palette p, Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: p.rose,
      brightness: brightness,
      primary: p.rose,
      onPrimary: p.onRose,
      surface: p.card,
      onSurface: p.ink,
      error: p.alert,
      secondaryContainer: p.roseSoft,
      onSecondaryContainer: p.ink,
    );
    final base = ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      brightness: brightness,
    );
    OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: c, width: w),
    );
    return base.copyWith(
      extensions: [p],
      scaffoldBackgroundColor: p.background,
      canvasColor: p.background,
      dividerColor: p.line,
      appBarTheme: AppBarTheme(
        backgroundColor: p.background,
        foregroundColor: p.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: 16,
        titleTextStyle: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: p.ink,
        ),
      ),
      cardTheme: CardThemeData(
        color: p.card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: p.line),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: p.card,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: p.line,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: p.card,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: p.ink,
        contentTextStyle: TextStyle(color: p.background, fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.card,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        hintStyle: TextStyle(color: p.muted),
        border: border(p.line),
        enabledBorder: border(p.line),
        focusedBorder: border(p.rose, 2),
        errorBorder: border(p.alert),
        focusedErrorBorder: border(p.alert, 2),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: p.rose,
          foregroundColor: p.onRose,
          disabledBackgroundColor: p.rose.withValues(alpha: 0.4),
          disabledForegroundColor: p.onRose,
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: p.ink,
          minimumSize: const Size(64, 48),
          side: BorderSide(color: p.line),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: p.rose,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? p.rose : null,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? p.onRose : null,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? p.rose : null,
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: p.rose,
        thumbColor: p.rose,
        inactiveTrackColor: p.line,
      ),
      textTheme: base.textTheme.apply(bodyColor: p.ink, displayColor: p.ink),
      iconTheme: IconThemeData(color: p.ink),
    );
  }
}

/// Fixed light colors for surfaces that stay light in both themes, such as
/// the language bubble.
abstract final class AppColors {
  static const rose = Color(0xFFA4636C);
  static const roseDeep = Color(0xFF874C55);
  static const roseSoft = Color(0xFFF4E3E2);
  static const ink = Color(0xFF3E2C2E);
  static const muted = Color(0xFF7A6668);
  static const line = Color(0xFFEDE2E0);
  static const predicted = Color(0xFFEFD3CF);
}
