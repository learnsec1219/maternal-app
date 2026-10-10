import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/content/clinical_content.dart';
import '../../core/util/clock.dart';
import '../../core/util/dates.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../../data/models.dart';
import '../../data/session.dart';
import '../../domain/health_rules.dart';
import '../../l10n/app_localizations.dart';

/// Which bottom tab the patient sees: home, calendar, calories, profile.
final patientTabProvider = NotifierProvider<IndexController, int>(
  IndexController.new,
);

/// Which bottom tab the doctor sees: dashboard, patients, appointments, profile.
final doctorTabProvider = NotifierProvider<IndexController, int>(
  IndexController.new,
);

class IndexController extends Notifier<int> {
  @override
  int build() => 0;
  void set(int i) => state = i;
}

/// Calendar state shared with the period form: the month shown, the tab, and
/// the day that just got a period logged (it is circled once).
class CalendarUi {
  const CalendarUi({required this.month, this.cycleTab = false, this.ringDay});
  final DateTime month;
  final bool cycleTab;
  final DateTime? ringDay;
}

final calendarUiProvider = NotifierProvider<CalendarUiController, CalendarUi>(
  CalendarUiController.new,
);

class CalendarUiController extends Notifier<CalendarUi> {
  @override
  CalendarUi build() {
    final t = ref.read(todayProvider);
    return CalendarUi(month: DateTime(t.year, t.month));
  }

  void showMonth(DateTime m) => state = CalendarUi(
    month: DateTime(m.year, m.month),
    cycleTab: state.cycleTab,
    ringDay: state.ringDay,
  );

  void setCycleTab(bool cycle) => state = CalendarUi(
    month: state.month,
    cycleTab: cycle,
    ringDay: state.ringDay,
  );

  /// After saving a period day: jump to its month and circle it.
  void circle(DateTime day) => state = CalendarUi(
    month: DateTime(day.year, day.month),
    cycleTab: true,
    ringDay: dateOnly(day),
  );

  void clearRing() =>
      state = CalendarUi(month: state.month, cycleTab: state.cycleTab);
}

/// The signed-in patient's own records.
class Mine {
  Mine(this.data, this.me);
  final DemoData data;
  final Profile me;

  List<T> of<T extends Object>(List<T> list) => data.of(list, me.id);
}

Mine mineOf(WidgetRef ref) {
  final data = ref.watch(demoStoreProvider);
  final me = ref.watch(meProvider)!;
  return Mine(data, me);
}

class Dose {
  Dose(this.med, this.slot, this.taken);
  final Medication med;
  final String slot;
  final bool taken;
}

List<Dose> dosesFor(Mine m, DateTime today) {
  final out = <Dose>[
    for (final med in m.of(m.data.meds))
      for (final slot in med.times)
        Dose(
          med,
          slot,
          m.data.intakes.any(
            (i) =>
                i.personId == med.personId &&
                i.medId == med.id &&
                i.slot == slot &&
                isSameDay(i.date, today),
          ),
        ),
  ];
  out.sort((a, b) => a.slot.compareTo(b.slot));
  return out;
}

List<DateTime> flowDaysOf(Mine m) => [
  for (final x in m.of(m.data.periods))
    if (hasFlow(x.flow)) x.date,
];

/// Reminders shown on Home and the reminders page.
List<(Tone, String)> remindersFor(
  BuildContext context,
  Mine m,
  DateTime today,
  DateTime now,
  ClinicalContent c,
) {
  final l = context.l10n, out = <(Tone, String)>[];
  for (final a in m.of(m.data.appointments)) {
    final d = daysBetween(today, a.at);
    if (d == 0 && a.at.isAfter(now)) {
      out.add((
        Tone.info,
        l.reminderAppointmentToday(a.purpose, context.formatTime(a.at)),
      ));
    } else if (d == 1) {
      out.add((
        Tone.info,
        l.reminderAppointmentTomorrow(a.purpose, context.formatTime(a.at)),
      ));
    }
  }
  final p = m.me;
  if ((p.journey == Journey.pregnancy || p.journey == Journey.postpartum) &&
      !m
          .of(m.data.obs)
          .any((o) => o.type == ObsType.bp && isSameDay(o.at, today))) {
    out.add((Tone.info, l.reminderLogBloodPressure));
  }
  final pr = PregnancyStatus.of(p, today, c);
  if (pr != null && pr.check == DueCheck.ok) {
    final given = {
      for (final v in m.of(m.data.vaccines))
        if (!v.date.isBefore(pr.lmp)) v.key,
    };
    for (final v in c.vaccines) {
      if (!v.postpartum &&
          v.startWeek > 0 &&
          !given.contains(v.key) &&
          pr.weeks >= v.startWeek &&
          pr.weeks <= v.endWeek) {
        out.add((Tone.warn, l.reminderVaccineDue(v.name.of(context.lang))));
      }
    }
  }
  final pending = dosesFor(m, today).where((d) => !d.taken).length;
  if (pending > 0) out.add((Tone.info, l.reminderMedication(pending)));
  return out;
}

enum VaxState { due, pending, given }

class VaxItem {
  VaxItem({
    required this.key,
    required this.name,
    required this.state,
    this.schedule,
    this.offer,
    this.given,
  });
  final String key, name;
  final VaxState state;
  final VaccineSchedule? schedule;
  final VaccineOffer? offer;
  final VaccineRecord? given;
}

/// One list: pregnancy schedule, clinic offers, then anything else recorded.
List<VaxItem> vaxItemsFor(
  Mine m,
  DateTime today,
  ClinicalContent c,
  String lang,
) {
  final p = m.me;
  final pr = PregnancyStatus.of(p, today, c);
  final w = pr != null && pr.check == DueCheck.ok ? pr.weeks : null;
  final since = p.due == null ? null : addDays(p.due!, -280);
  final recs = m.of(m.data.vaccines);
  final preg =
      p.journey == Journey.pregnancy || p.journey == Journey.postpartum;
  VaccineRecord? latest(String key, bool thisPreg) {
    final r =
        recs
            .where(
              (x) =>
                  x.key == key &&
                  (!thisPreg || since == null || !x.date.isBefore(since)),
            )
            .toList()
          ..sort((a, b) => b.date.compareTo(a.date));
    return r.isEmpty ? null : r.first;
  }

  VaccineOffer? offerFor(String key) {
    for (final o in m.data.offers) {
      if (o.key == key) return o;
    }
    return null;
  }

  final items = <VaxItem>[], used = <String>{};
  if (preg) {
    for (final v in c.vaccines) {
      final g = latest(v.key, true);
      final st = g != null
          ? VaxState.given
          : v.postpartum
          ? (p.journey == Journey.postpartum ? VaxState.due : VaxState.pending)
          : (w != null && w >= v.startWeek && w <= v.endWeek)
          ? VaxState.due
          : VaxState.pending;
      items.add(
        VaxItem(
          key: v.key,
          name: v.name.of(lang),
          state: st,
          schedule: v,
          offer: offerFor(v.key),
          given: g,
        ),
      );
      used.add(v.key);
    }
  }
  for (final o in m.data.offers) {
    final k = o.key ?? 'offer:${o.id}';
    if (!used.add(k)) continue;
    final g = latest(k, false);
    items.add(
      VaxItem(
        key: k,
        name: o.name,
        state: g == null ? VaxState.pending : VaxState.given,
        offer: o,
        given: g,
      ),
    );
  }
  for (final r in recs) {
    final k = r.key ?? 'name:${r.name.toLowerCase()}';
    if (!used.add(k)) continue;
    items.add(VaxItem(key: k, name: r.name, state: VaxState.given, given: r));
  }
  items.sort((a, b) => a.state.index.compareTo(b.state.index));
  return items;
}

/// Allowed ranges when typing a reading (lower, upper[, diastolic lower, upper]).
const obsLimits = <ObsType, List<double>>{
  ObsType.bp: [50, 260, 30, 160],
  ObsType.hr: [30, 220],
  ObsType.glu: [1, 35],
  ObsType.temp: [34, 42],
  ObsType.weight: [25, 250],
  ObsType.spo2: [70, 100],
  ObsType.water: [0, 6000],
  ObsType.sleep: [0, 24],
  ObsType.steps: [0, 100000],
  ObsType.mood: [1, 5],
};

/// Round letter avatar.
class Avatar extends StatelessWidget {
  const Avatar(this.name, {super.key, this.size = 40});
  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    final p = Theme.of(context).colorScheme;
    final ch = name.isEmpty ? '?' : String.fromCharCode(name.runes.first);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: p.primary, shape: BoxShape.circle),
      child: Text(
        ch.toUpperCase(),
        style: TextStyle(
          fontSize: size * 0.42,
          fontWeight: FontWeight.w700,
          color: p.onPrimary,
        ),
      ),
    );
  }
}

String journeyLabel(AppLocalizations l, Journey j) => switch (j) {
  Journey.pregnancy => l.journeyPregnancy,
  Journey.postpartum => l.journeyPostpartum,
  Journey.general => l.journeyGeneral,
};

/// Push a page with the standard transition.
Future<T?> pushPage<T>(BuildContext context, Widget page) =>
    Navigator.of(context).push<T>(MaterialPageRoute(builder: (_) => page));
