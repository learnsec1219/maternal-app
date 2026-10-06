import '../../../core/util/dates.dart';

const int pregnancyLengthDays = 280;

enum Trimester { first, second, third }

/// Gestational age derived from an expected due date (EDD).
class Gestation {
  const Gestation._({
    required this.dueDate,
    required this.daysPregnant,
    required this.daysToDue,
  });

  /// Computes gestational age on [today] from a known due date.
  factory Gestation.fromDueDate(DateTime dueDate, {required DateTime today}) {
    final due = dateOnly(dueDate);
    final lmp = addDays(due, -pregnancyLengthDays);
    return Gestation._(
      dueDate: due,
      daysPregnant: daysBetween(lmp, today),
      daysToDue: daysBetween(today, due),
    );
  }

  /// Computes gestational age from the first day of the last menstrual period
  /// using Naegele's rule (LMP + 280 days).
  factory Gestation.fromLmp(DateTime lmp, {required DateTime today}) =>
      Gestation.fromDueDate(
        addDays(dateOnly(lmp), pregnancyLengthDays),
        today: today,
      );

  final DateTime dueDate;
  final int daysPregnant;
  final int daysToDue;

  int get _clampedDays => daysPregnant.clamp(0, 42 * 7);
  int get weeks => _clampedDays ~/ 7;
  int get days => _clampedDays % 7;

  /// Fraction of a 40-week pregnancy completed, from 0 to 1.
  double get progress => (_clampedDays / pregnancyLengthDays).clamp(0.0, 1.0);

  Trimester get trimester {
    if (weeks >= 27) return Trimester.third;
    if (weeks >= 13) return Trimester.second;
    return Trimester.first;
  }
}
