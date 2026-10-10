import '../core/content/clinical_content.dart';
import '../core/util/dates.dart';
import '../data/models.dart';

enum DueCheck { ok, future, past }

enum Trimester { first, second, third }

/// Pregnancy dating from the expected due date (280-day pregnancy).
class PregnancyStatus {
  PregnancyStatus._(
    this.due,
    this.gaDays,
    this.daysToDue,
    this.check,
    this.trimester,
    this.babies,
  );

  static PregnancyStatus? of(Profile p, DateTime today, ClinicalContent c) {
    final due = p.due;
    if (p.journey != Journey.pregnancy || due == null) return null;
    final length = c.dating['pregnancyLengthDays']!.toInt();
    final toDue = daysBetween(today, due);
    final ga = length - toDue;
    final check = toDue > length
        ? DueCheck.future
        : -toDue > c.dating['maxDaysPastDue']!.toInt()
        ? DueCheck.past
        : DueCheck.ok;
    final weeks = ga ~/ 7;
    final tri = weeks >= c.dating['thirdTrimesterStartWeek']!.toInt()
        ? Trimester.third
        : weeks >= c.dating['secondTrimesterStartWeek']!.toInt()
        ? Trimester.second
        : Trimester.first;
    return PregnancyStatus._(dateOnly(due), ga, toDue, check, tri, p.babies);
  }

  final DateTime due;
  final int gaDays, daysToDue, babies;
  final DueCheck check;
  final Trimester trimester;

  int get weeks => gaDays ~/ 7;
  int get days => gaDays % 7;
  double get progress => (gaDays / 280).clamp(0.0, 1.0);
  DateTime get lmp => addDays(due, -280);
}

DueCheck checkDueDate(DateTime due, DateTime today, ClinicalContent c) {
  final n = daysBetween(today, due);
  if (n > c.dating['pregnancyLengthDays']!.toInt()) return DueCheck.future;
  if (-n > c.dating['maxDaysPastDue']!.toInt()) return DueCheck.past;
  return DueCheck.ok;
}

int gaDaysFor(DateTime due, DateTime on) => 280 - daysBetween(on, due);

enum CycleStatus { none, defaults, history, stale }

/// Next-period, fertile-window and ovulation estimates from logged periods.
/// These are estimates only and are labelled as such everywhere they show.
class CycleEstimate {
  CycleEstimate._({
    required this.status,
    this.periods = const [],
    this.cycleLength = 0,
    this.periodLength = 0,
    this.irregular = false,
    this.lateDays = 0,
    this.next,
    this.ovulation,
    this.fertileStart,
    this.fertileEnd,
  });

  factory CycleEstimate.from(
    List<DateTime> flowDays,
    DateTime today,
    ClinicalContent c,
  ) {
    final cfg = c.cycle;
    final days = {for (final d in flowDays) dateOnly(d)}.toList()..sort();
    if (days.isEmpty) return CycleEstimate._(status: CycleStatus.none);
    final spans = <(DateTime, DateTime)>[];
    var s = days.first, e = days.first;
    for (final d in days.skip(1)) {
      if (daysBetween(e, d) <= cfg['maxGapWithinPeriodDays']!.toInt() + 1) {
        e = d;
      } else {
        spans.add((s, e));
        s = e = d;
      }
    }
    spans.add((s, e));
    var lengths = <int>[];
    for (var i = 1; i < spans.length; i++) {
      final l = daysBetween(spans[i - 1].$1, spans[i].$1);
      if (l >= cfg['minCycleLength']! && l <= cfg['maxCycleLength']!) {
        lengths.add(l);
      }
    }
    final keep = cfg['cyclesUsedForAverage']!.toInt();
    if (lengths.length > keep) lengths = lengths.sublist(lengths.length - keep);
    final used = lengths.isEmpty
        ? cfg['defaultCycleLength']!.toInt()
        : (lengths.reduce((a, b) => a + b) / lengths.length).round();
    final recent = spans.length > 6 ? spans.sublist(spans.length - 6) : spans;
    final plen =
        (recent.fold<int>(0, (a, x) => a + daysBetween(x.$1, x.$2) + 1) /
                recent.length)
            .round()
            .clamp(1, 60);
    final variation = lengths.length > 1
        ? lengths.reduce((a, b) => a > b ? a : b) -
              lengths.reduce((a, b) => a < b ? a : b)
        : 0;
    final next = addDays(spans.last.$1, used);
    final late = daysBetween(next, today).clamp(0, 100000);
    final irregular = variation > cfg['irregularVariationDays']!;
    if (late > used) {
      return CycleEstimate._(
        status: CycleStatus.stale,
        periods: spans,
        cycleLength: used,
        periodLength: plen,
        irregular: irregular,
        lateDays: late,
      );
    }
    final ov = addDays(next, -cfg['lutealPhaseDays']!.toInt());
    return CycleEstimate._(
      status: lengths.isEmpty ? CycleStatus.defaults : CycleStatus.history,
      periods: spans,
      cycleLength: used,
      periodLength: plen,
      irregular: irregular,
      lateDays: late,
      next: next,
      ovulation: ov,
      fertileStart: addDays(ov, -cfg['fertileDaysBeforeOvulation']!.toInt()),
      fertileEnd: addDays(ov, cfg['fertileDaysAfterOvulation']!.toInt()),
    );
  }

  final CycleStatus status;
  final List<(DateTime, DateTime)> periods;
  final int cycleLength, periodLength, lateDays;
  final bool irregular;
  final DateTime? next, ovulation, fertileStart, fertileEnd;
}

bool hasFlow(Flow f) => f == Flow.light || f == Flow.medium || f == Flow.heavy;

enum RangeClass { within, above, below, unknown }

RangeClass _cls(ClinicalContent c, String key, double v) {
  final r = c.ranges[key];
  if (r == null) return RangeClass.unknown;
  if (r.low != null && v < r.low!) return RangeClass.below;
  if (r.high != null && v > r.high!) return RangeClass.above;
  return RangeClass.within;
}

/// Whether a reading is inside the care team's typical range. Not a diagnosis.
RangeClass rangeOf(Observation o, ClinicalContent c) {
  switch (o.type) {
    case ObsType.bp:
      final a = _cls(c, 'systolic', o.value);
      final b = o.value2 == null
          ? RangeClass.unknown
          : _cls(c, 'diastolic', o.value2!);
      if (a == RangeClass.above || b == RangeClass.above) {
        return RangeClass.above;
      }
      if (a == RangeClass.below || b == RangeClass.below) {
        return RangeClass.below;
      }
      return RangeClass.within;
    case ObsType.hr:
      return _cls(c, 'heart_rate', o.value);
    case ObsType.glu:
      return o.ctx == GlucoseContext.fasting
          ? _cls(c, 'glucose_fasting', o.value)
          : RangeClass.unknown;
    case ObsType.temp:
      return _cls(c, 'temperature', o.value);
    case ObsType.spo2:
      return _cls(c, 'spo2', o.value);
    default:
      return RangeClass.unknown;
  }
}

/// Estimated daily kcal (Mifflin-St Jeor x activity, plus trimester extra).
/// An estimate, never a prescription; a clinician's target wins.
int? calorieTarget(
  Profile p,
  double? weight,
  Trimester? tri,
  DateTime today,
  ClinicalContent c,
) {
  if (p.clinicianTarget != null) return p.clinicianTarget;
  final dob = p.dob, h = p.height;
  if (dob == null || h == null || weight == null) return null;
  var age = today.year - dob.year;
  if (today.isBefore(DateTime(today.year, dob.month, dob.day))) age--;
  final rest = 10 * weight + 6.25 * h - 5 * age - 161;
  final f = c.activityFactors[p.activity.name] ?? 1.375;
  final extra = tri == null
      ? 0
      : c.pregnancyExtraKcal['${tri.index + 1}']?.toInt() ?? 0;
  return (rest * f).round() + extra;
}
