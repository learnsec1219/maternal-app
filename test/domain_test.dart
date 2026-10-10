import 'package:flutter_test/flutter_test.dart';
import 'package:maternal/features/calories/domain/calorie_target.dart';
import 'package:maternal/features/calories/domain/food_entry.dart';
import 'package:maternal/features/cycle/domain/cycle_predictor.dart';
import 'package:maternal/features/cycle/domain/period_entry.dart';
import 'package:maternal/features/health_log/domain/health_log.dart';
import 'package:maternal/features/pregnancy/domain/gestation.dart';

PeriodEntry period(DateTime start, [int days = 5]) => PeriodEntry(
  id: start.toIso8601String(),
  start: start,
  end: start.add(Duration(days: days - 1)),
);

void main() {
  group('Gestation', () {
    final today = DateTime(2026, 10, 6);

    test('32+4 weeks when 52 days remain to the due date', () {
      final g = Gestation.fromDueDate(DateTime(2026, 11, 27), today: today);
      expect((g.weeks, g.days), (32, 4));
      expect(g.daysToDue, 52);
      expect(g.trimester, Trimester.third);
    });

    test('LMP and due date give the same result', () {
      final fromLmp = Gestation.fromLmp(DateTime(2026, 7, 1), today: today);
      final fromEdd = Gestation.fromDueDate(DateTime(2027, 4, 7), today: today);
      expect(fromLmp.dueDate, DateTime(2027, 4, 7));
      expect((fromLmp.weeks, fromLmp.days), (fromEdd.weeks, fromEdd.days));
      expect((fromLmp.weeks, fromLmp.days), (13, 6));
    });

    test('trimester boundaries at 13 and 27 weeks', () {
      Gestation at(int weeks) => Gestation.fromDueDate(
        today.add(Duration(days: 280 - weeks * 7)),
        today: today,
      );
      expect(at(12).trimester, Trimester.first);
      expect(at(13).trimester, Trimester.second);
      expect(at(26).trimester, Trimester.second);
      expect(at(27).trimester, Trimester.third);
    });

    test('progress is clamped past the due date', () {
      final g = Gestation.fromDueDate(DateTime(2026, 9, 30), today: today);
      expect(g.daysToDue, -6);
      expect(g.progress, 1.0);
    });
  });

  group('CyclePredictor', () {
    test('defaults without history', () {
      final f = CyclePredictor.forecast(const []);
      expect(f.hasEnoughHistory, isFalse);
      expect(f.nextPeriodStart, isNull);
    });

    test('regular 28-day cycles predict next period and fertile window', () {
      final f = CyclePredictor.forecast([
        period(DateTime(2026, 7, 1)),
        period(DateTime(2026, 7, 29)),
        period(DateTime(2026, 8, 26), 4),
      ]);
      expect(f.averageCycleLength, 28);
      expect(f.averagePeriodLength, 5);
      expect(f.isIrregular, isFalse);
      expect(f.nextPeriodStart, DateTime(2026, 9, 23));
      expect(f.ovulationDay, DateTime(2026, 9, 9));
      expect(f.fertileStart, DateTime(2026, 9, 4));
      expect(f.fertileEnd, DateTime(2026, 9, 10));
      expect(f.isPredictedPeriod(DateTime(2026, 9, 27)), isTrue);
      expect(f.isPredictedPeriod(DateTime(2026, 9, 28)), isFalse);
    });

    test('flags irregular cycles', () {
      final f = CyclePredictor.forecast([
        period(DateTime(2026, 5, 1)),
        period(DateTime(2026, 5, 23)), // 22 days
        period(DateTime(2026, 6, 27)), // 35 days
      ]);
      expect(f.isIrregular, isTrue);
    });

    test('ignores implausible gaps', () {
      final f = CyclePredictor.forecast([
        period(DateTime(2025, 1, 1)),
        period(DateTime(2026, 1, 1)), // a year apart
      ]);
      expect(f.hasEnoughHistory, isFalse);
      expect(f.averageCycleLength, CyclePredictor.defaultCycleLength);
    });
  });

  group('CalorieTarget', () {
    test('falls back without profile data', () {
      expect(
        CalorieTarget.estimate(
          weightKg: null,
          heightCm: 160,
          ageYears: 30,
          activity: ActivityLevel.light,
        ),
        CalorieTarget.fallbackKcal,
      );
    });

    test('adds trimester allowance', () {
      int est([Trimester? t]) => CalorieTarget.estimate(
        weightKg: 60,
        heightCm: 160,
        ageYears: 30,
        activity: ActivityLevel.low,
        trimester: t,
      );
      // BMR = 600 + 1000 - 150 - 161 = 1289; x1.2 = 1546.8
      expect(est(), 1550);
      expect(est(Trimester.second), 1890);
      expect(est(Trimester.third), 2000);
    });
  });

  test('blood pressure status uses diastolic too', () {
    HealthLogEntry bp(double s, double d) => HealthLogEntry(
      id: 'x',
      metric: HealthMetric.bloodPressure,
      time: DateTime(2026),
      value: s,
      secondary: d,
    );
    expect(bp(118, 76).status, RangeStatus.normal);
    expect(bp(125, 95).status, RangeStatus.high);
    expect(bp(145, 80).status, RangeStatus.high);
    expect(bp(118, 76).displayValue, '118/76');
  });

  test('day totals sum calories and macros', () {
    final t = DayTotals.of([
      FoodEntry(
        id: '1',
        date: DateTime(2026),
        meal: Meal.lunch,
        name: 'Rice',
        kcal: 300,
        carbsG: 60,
      ),
      FoodEntry(
        id: '2',
        date: DateTime(2026),
        meal: Meal.lunch,
        name: 'Egg',
        kcal: 80,
        proteinG: 6,
        fatG: 5,
      ),
    ]);
    expect((t.kcal, t.proteinG, t.carbsG, t.fatG), (380, 6.0, 60.0, 5.0));
  });
}
