import 'dart:math' as math;

import '../../../core/util/dates.dart';
import 'period_entry.dart';

/// Cycle statistics and estimated predictions from logged periods.
///
/// All predictions are estimates and must be labelled as such in the UI.
class CycleForecast {
  const CycleForecast({
    required this.averageCycleLength,
    required this.averagePeriodLength,
    required this.isIrregular,
    required this.hasEnoughHistory,
    this.nextPeriodStart,
    this.ovulationDay,
    this.fertileStart,
    this.fertileEnd,
  });

  final int averageCycleLength;
  final int averagePeriodLength;

  /// True when recent cycle lengths vary by more than [CyclePredictor.irregularSpreadDays].
  final bool isIrregular;

  /// True once at least two periods are logged, so a cycle length is known.
  final bool hasEnoughHistory;

  final DateTime? nextPeriodStart;
  final DateTime? ovulationDay;
  final DateTime? fertileStart;
  final DateTime? fertileEnd;

  bool isPredictedPeriod(DateTime day) {
    final start = nextPeriodStart;
    if (start == null) return false;
    final offset = daysBetween(start, day);
    return offset >= 0 && offset < averagePeriodLength;
  }

  bool isFertile(DateTime day) {
    final s = fertileStart, e = fertileEnd;
    if (s == null || e == null) return false;
    return daysBetween(s, day) >= 0 && daysBetween(day, e) >= 0;
  }

  bool isOvulation(DateTime day) =>
      ovulationDay != null && isSameDay(ovulationDay!, day);
}

abstract final class CyclePredictor {
  static const defaultCycleLength = 28;
  static const defaultPeriodLength = 5;
  static const lutealPhaseDays = 14;
  static const irregularSpreadDays = 8;

  /// Only the most recent cycles are averaged, so older history fades out.
  static const cyclesToAverage = 6;

  static CycleForecast forecast(List<PeriodEntry> periods) {
    if (periods.isEmpty) {
      return const CycleForecast(
        averageCycleLength: defaultCycleLength,
        averagePeriodLength: defaultPeriodLength,
        isIrregular: false,
        hasEnoughHistory: false,
      );
    }
    final sorted = [...periods]..sort((a, b) => a.start.compareTo(b.start));

    final cycleLengths = <int>[];
    for (var i = 1; i < sorted.length; i++) {
      final len = daysBetween(sorted[i - 1].start, sorted[i].start);
      // Ignore implausible gaps (duplicate entries or long breaks such as pregnancy).
      if (len >= 15 && len <= 90) cycleLengths.add(len);
    }
    final recent = cycleLengths.length > cyclesToAverage
        ? cycleLengths.sublist(cycleLengths.length - cyclesToAverage)
        : cycleLengths;

    final avgCycle = recent.isEmpty
        ? defaultCycleLength
        : (recent.reduce((a, b) => a + b) / recent.length).round();
    final isIrregular =
        recent.length >= 2 &&
        recent.reduce(math.max) - recent.reduce(math.min) >=
            irregularSpreadDays;

    final durations = sorted
        .where((p) => p.end != null)
        .map((p) => daysBetween(p.start, p.end!) + 1)
        .where((d) => d > 0 && d <= 14)
        .toList();
    final avgPeriod = durations.isEmpty
        ? defaultPeriodLength
        : (durations.reduce((a, b) => a + b) / durations.length).round();

    final next = addDays(sorted.last.start, avgCycle);
    final ovulation = addDays(next, -lutealPhaseDays);
    return CycleForecast(
      averageCycleLength: avgCycle,
      averagePeriodLength: avgPeriod,
      isIrregular: isIrregular,
      hasEnoughHistory: recent.isNotEmpty,
      nextPeriodStart: next,
      ovulationDay: ovulation,
      fertileStart: addDays(ovulation, -5),
      fertileEnd: addDays(ovulation, 1),
    );
  }
}
