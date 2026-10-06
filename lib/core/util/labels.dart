import '../../features/calories/domain/calorie_target.dart';
import '../../features/calories/domain/food_entry.dart';
import '../../features/cycle/domain/period_entry.dart';
import '../../features/health_log/domain/health_log.dart';
import '../../features/health_log/domain/symptoms.dart';
import '../../features/pregnancy/domain/gestation.dart';
import '../../l10n/app_localizations.dart';

/// Localized names for domain enums, kept in one place so the domain layer
/// stays free of UI strings.
extension DomainLabels on AppLocalizations {
  String metric(HealthMetric m) => switch (m) {
    HealthMetric.weight => metricWeight,
    HealthMetric.bloodPressure => metricBloodPressure,
    HealthMetric.heartRate => metricHeartRate,
    HealthMetric.glucose => metricGlucose,
    HealthMetric.temperature => metricTemperature,
    HealthMetric.spo2 => metricSpo2,
    HealthMetric.sleep => metricSleep,
    HealthMetric.water => metricWater,
    HealthMetric.fetalMovement => metricFetalMovement,
    HealthMetric.symptom => metricSymptom,
  };

  String rangeStatus(RangeStatus s) => switch (s) {
    RangeStatus.low => statusLow,
    RangeStatus.normal => statusNormal,
    RangeStatus.high => statusHigh,
  };

  String symptom(SymptomKind s) => switch (s) {
    SymptomKind.nausea => sym_nausea,
    SymptomKind.fatigue => sym_fatigue,
    SymptomKind.backPain => sym_backPain,
    SymptomKind.heartburn => sym_heartburn,
    SymptomKind.cramps => sym_cramps,
    SymptomKind.headache => sym_headache,
    SymptomKind.reducedMovements => sym_reducedMovements,
    SymptomKind.bleeding => sym_bleeding,
    SymptomKind.severeHeadacheVision => sym_severeHeadacheVision,
    SymptomKind.suddenSwelling => sym_suddenSwelling,
    SymptomKind.severeAbdominalPain => sym_severeAbdominalPain,
    SymptomKind.fluidLeak => sym_fluidLeak,
    SymptomKind.feverUnwell => sym_feverUnwell,
  };

  /// Predefined guidance for warning symptoms; null for common symptoms.
  String? symptomAction(SymptomKind s) => switch (s) {
    SymptomKind.reducedMovements => act_reducedMovements,
    SymptomKind.bleeding => act_bleeding,
    SymptomKind.severeHeadacheVision => act_severeHeadacheVision,
    SymptomKind.suddenSwelling => act_suddenSwelling,
    SymptomKind.severeAbdominalPain => act_severeAbdominalPain,
    SymptomKind.fluidLeak => act_fluidLeak,
    SymptomKind.feverUnwell => act_feverUnwell,
    _ => null,
  };

  String flowLabel(FlowLevel f) => switch (f) {
    FlowLevel.spotting => flow_spotting,
    FlowLevel.light => flow_light,
    FlowLevel.medium => flow_medium,
    FlowLevel.heavy => flow_heavy,
  };

  String meal(Meal m) => switch (m) {
    Meal.breakfast => meal_breakfast,
    Meal.lunch => meal_lunch,
    Meal.dinner => meal_dinner,
    Meal.snack => meal_snack,
    Meal.drink => meal_drink,
  };

  String activity(ActivityLevel a) => switch (a) {
    ActivityLevel.low => act_low,
    ActivityLevel.light => act_light,
    ActivityLevel.moderate => act_moderate,
    ActivityLevel.high => act_high,
  };

  String trimester(Trimester t) => switch (t) {
    Trimester.first => trimesterFirst,
    Trimester.second => trimesterSecond,
    Trimester.third => trimesterThird,
  };
}
