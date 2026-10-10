import 'package:flutter/material.dart' hide Flow;

import '../../data/models.dart';
import '../../domain/health_rules.dart';
import '../../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'l10n.dart';

/// Localized names for domain enums, kept in one place so the domain layer
/// stays free of UI strings.
extension DomainLabels on AppLocalizations {
  String obs(ObsType t) => switch (t) {
    ObsType.bp => obsBloodPressure,
    ObsType.hr => obsHeartRate,
    ObsType.glu => obsBloodGlucose,
    ObsType.temp => obsTemperature,
    ObsType.weight => obsWeight,
    ObsType.spo2 => obsSpo2,
    ObsType.water => obsWater,
    ObsType.sleep => obsSleep,
    ObsType.steps => obsActivity,
    ObsType.mood => obsMood,
  };

  String journey(Journey j) => switch (j) {
    Journey.pregnancy => journeyPregnancy,
    Journey.postpartum => journeyPostpartum,
    Journey.general => journeyGeneral,
  };

  String trimester(Trimester t) => switch (t) {
    Trimester.first => trimesterFirst,
    Trimester.second => trimesterSecond,
    Trimester.third => trimesterThird,
  };

  String flow(Flow f) => switch (f) {
    Flow.none => flowNone,
    Flow.spotting => flowSpotting,
    Flow.light => flowLight,
    Flow.medium => flowMedium,
    Flow.heavy => flowHeavy,
  };

  String meal(Meal m) => switch (m) {
    Meal.breakfast => mealBreakfast,
    Meal.lunch => mealLunch,
    Meal.dinner => mealDinner,
    Meal.snack => mealSnacks,
    Meal.drink => mealDrinks,
  };

  String mood(int v) => [
    moodVeryLow,
    moodLow,
    moodOkay,
    moodGood,
    moodGreat,
  ][(v - 1).clamp(0, 4)];

  String severity(int v) =>
      [painMild, painModerate, painSevere][(v - 1).clamp(0, 2)];

  String glucoseCtx(GlucoseContext c) => switch (c) {
    GlucoseContext.fasting => glucoseFasting,
    GlucoseContext.after => glucoseAfterMeal,
    GlucoseContext.random => glucoseRandom,
  };

  String activity(ActivityLevel a) => switch (a) {
    ActivityLevel.sedentary => activitySedentary,
    ActivityLevel.light => activityLight,
    ActivityLevel.moderate => activityModerate,
    ActivityLevel.active => activityActive,
  };

  String docCategory(DocCategory c) => switch (c) {
    DocCategory.bloodTest => docBloodTest,
    DocCategory.ultrasound => docUltrasound,
    DocCategory.hospital => docHospital,
    DocCategory.prescription => docPrescription,
    DocCategory.vaccination => docVaccination,
    DocCategory.other => docOther,
  };

  String babyCount(int n) => switch (n) {
    1 => babiesSingle,
    2 => babiesTwins,
    3 => babiesTriplets,
    _ => babiesMore,
  };

  String gaText(int days) => gaWeeksDays(days ~/ 7, days % 7);
}

/// Unit, icon and tint for each kind of reading.
class ObsStyle {
  const ObsStyle(this.unit, this.icon, this.tint, {this.decimals = 0});
  final String unit;
  final IconData icon;
  final Color Function(Palette p) tint;
  final int decimals;
}

ObsStyle obsStyle(ObsType t) => switch (t) {
  ObsType.bp => ObsStyle(
    'mmHg',
    Icons.favorite_border_rounded,
    (p) => p.roseSoft,
  ),
  ObsType.hr => ObsStyle(
    'bpm',
    Icons.monitor_heart_outlined,
    (p) => p.roseSoft,
  ),
  ObsType.glu => ObsStyle(
    'mmol/L',
    Icons.water_drop_outlined,
    (p) => p.peach,
    decimals: 1,
  ),
  ObsType.temp => ObsStyle(
    '°C',
    Icons.thermostat_rounded,
    (p) => p.sand,
    decimals: 1,
  ),
  ObsType.weight => ObsStyle(
    'kg',
    Icons.monitor_weight_outlined,
    (p) => p.sage,
    decimals: 1,
  ),
  ObsType.spo2 => ObsStyle('%', Icons.air_rounded, (p) => p.sky),
  ObsType.water => ObsStyle('ml', Icons.local_drink_outlined, (p) => p.sky),
  ObsType.sleep => ObsStyle(
    'h',
    Icons.bedtime_outlined,
    (p) => p.lavender,
    decimals: 1,
  ),
  ObsType.steps => ObsStyle(
    'steps',
    Icons.directions_walk_rounded,
    (p) => p.sage,
  ),
  ObsType.mood => ObsStyle('', Icons.star_outline_rounded, (p) => p.lavender),
};

/// A reading as text, e.g. "118/76 mmHg" or "Fasting · 4.9 mmol/L".
String obsValue(BuildContext context, Observation o) {
  final l = context.l10n;
  final st = obsStyle(o.type);
  if (o.type == ObsType.bp) {
    return '${context.formatNumber(o.value)}/${context.formatNumber(o.value2 ?? 0)} mmHg';
  }
  if (o.type == ObsType.mood) return l.mood(o.value.round());
  final unit = switch (o.type) {
    ObsType.hr => l.unitBpm,
    ObsType.sleep => l.unitHours,
    ObsType.steps => l.unitSteps,
    _ => st.unit,
  };
  final pre = o.type == ObsType.glu && o.ctx != null
      ? '${l.glucoseCtx(o.ctx!)} · '
      : '';
  return '$pre${context.formatNumber(o.value, st.decimals)} $unit';
}

/// "In range" / "Above range" / "Below range" pill, or nothing.
Widget rangePill(BuildContext context, RangeClass r) {
  final l = context.l10n, p = context.pal;
  return switch (r) {
    RangeClass.within => Pill(
      l.rangeWithin,
      icon: '✓',
      background: p.goodSoft,
      foreground: p.good,
    ),
    RangeClass.above => Pill(
      l.rangeAbove,
      icon: '↑',
      background: p.alertSoft,
      foreground: p.alert,
    ),
    RangeClass.below => Pill(
      l.rangeBelow,
      icon: '↓',
      background: p.warnSoft,
      foreground: p.warn,
    ),
    RangeClass.unknown => const SizedBox.shrink(),
  };
}
