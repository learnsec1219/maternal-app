import 'package:flutter_test/flutter_test.dart';
import 'package:maternal/core/util/dates.dart';
import 'package:maternal/data/models.dart';
import 'package:maternal/domain/health_rules.dart';

import 'test_app.dart';

void main() {
  final c = loadContent();
  final today = DateTime(2026, 10, 6);

  group('PregnancyStatus', () {
    test('dates from the due date', () {
      final p = Profile(
        id: 'x',
        name: 'A',
        journey: Journey.pregnancy,
        due: addDays(today, 52),
      );
      final s = PregnancyStatus.of(p, today, c)!;
      expect(s.weeks, 32);
      expect(s.days, 4);
      expect(s.trimester, Trimester.third);
      expect(s.check, DueCheck.ok);
    });

    test('flags a due date too far away', () {
      final p = Profile(
        id: 'x',
        name: 'A',
        journey: Journey.pregnancy,
        due: addDays(today, 400),
      );
      expect(PregnancyStatus.of(p, today, c)!.check, DueCheck.future);
    });

    test('is null when not pregnant', () {
      expect(
        PregnancyStatus.of(
          Profile(id: 'x', name: 'A', journey: Journey.general),
          today,
          c,
        ),
        isNull,
      );
    });
  });

  group('CycleEstimate', () {
    List<DateTime> period(DateTime start, int len) => [
      for (var i = 0; i < len; i++) addDays(start, i),
    ];

    test('no data', () {
      expect(CycleEstimate.from([], today, c).status, CycleStatus.none);
    });

    test('averages recent cycles and estimates the next period', () {
      final s1 = addDays(today, -56), s2 = addDays(today, -28);
      final e = CycleEstimate.from(
        [...period(s1, 5), ...period(s2, 5)],
        today,
        c,
      );
      expect(e.status, CycleStatus.history);
      expect(e.cycleLength, 28);
      expect(e.periodLength, 5);
      expect(e.next, addDays(s2, 28));
      expect(e.ovulation!.isBefore(e.next!), isTrue);
      expect(e.fertileStart!.isBefore(e.fertileEnd!), isTrue);
    });

    test('marks a long-overdue period as stale', () {
      final e = CycleEstimate.from(period(addDays(today, -120), 4), today, c);
      expect(e.status, CycleStatus.stale);
    });
  });

  group('rangeOf', () {
    test('blood pressure above range', () {
      final o = Observation('x', today, ObsType.bp, 150, value2: 95);
      expect(rangeOf(o, c), RangeClass.above);
    });

    test('heart rate within range', () {
      expect(
        rangeOf(Observation('x', today, ObsType.hr, 80), c),
        RangeClass.within,
      );
    });

    test('glucose after a meal is not classified', () {
      final o = Observation(
        'x',
        today,
        ObsType.glu,
        9,
        ctx: GlucoseContext.after,
      );
      expect(rangeOf(o, c), RangeClass.unknown);
    });
  });

  group('calorieTarget', () {
    final p = Profile(
      id: 'x',
      name: 'A',
      journey: Journey.general,
      dob: DateTime(1993, 5, 14),
      height: 160,
    );

    test('needs date of birth, height and weight', () {
      expect(
        calorieTarget(
          Profile(id: 'y', name: 'B', journey: Journey.general),
          60,
          null,
          today,
          c,
        ),
        isNull,
      );
    });

    test('adds the trimester extra', () {
      final base = calorieTarget(p, 60, null, today, c)!;
      final third = calorieTarget(p, 60, Trimester.third, today, c)!;
      expect(third, greaterThan(base));
    });

    test('a clinician target wins', () {
      p.clinicianTarget = 2100;
      expect(calorieTarget(p, 60, Trimester.first, today, c), 2100);
    });
  });
}
