import '../../pregnancy/domain/gestation.dart';

enum ActivityLevel {
  low(1.2),
  light(1.375),
  moderate(1.55),
  high(1.725);

  const ActivityLevel(this.factor);
  final double factor;
}

/// Estimated daily energy need. This is an estimate for guidance only, never a
/// prescription; a clinician- or dietitian-set target always takes precedence.
abstract final class CalorieTarget {
  static const fallbackKcal = 2000;

  /// Additional kcal/day by trimester (Institute of Medicine estimates).
  static const _pregnancyExtra = {
    Trimester.first: 0,
    Trimester.second: 340,
    Trimester.third: 452,
  };

  static int estimate({
    required double? weightKg,
    required double? heightCm,
    required int? ageYears,
    required ActivityLevel activity,
    Trimester? trimester,
  }) {
    if (weightKg == null || heightCm == null || ageYears == null) {
      return fallbackKcal;
    }
    // Mifflin-St Jeor resting energy for women.
    final bmr = 10 * weightKg + 6.25 * heightCm - 5 * ageYears - 161;
    var total = bmr * activity.factor;
    if (trimester != null) total += _pregnancyExtra[trimester] ?? 0;
    return (total / 10).round() * 10;
  }
}
