import 'package:flutter/material.dart' hide Flow;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/content/clinical_content.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/clock.dart';
import '../../core/util/dates.dart';
import '../../core/util/l10n.dart';
import '../../core/util/labels.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../../data/models.dart';
import '../../domain/health_rules.dart';
import '../patient/patient_data.dart';
import '../records/care_pages.dart';
import '../records/health_pages.dart';
import '../records/pregnancy_pages.dart';
import '../settings/language_switcher.dart';
import 'brush_circle.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final m = mineOf(ref);
    final ui = ref.watch(calendarUiProvider);
    final preg = m.me.journey == Journey.pregnancy;
    final showTimeline = preg && !ui.cycleTab;
    return Column(
      children: [
        TabTitleBar(title: l.navCalendar),
        if (preg)
          UnderlineTabs(
            labels: [l.tabPregnancyTimeline, l.tabCycle],
            index: ui.cycleTab ? 1 : 0,
            onChanged: (i) =>
                ref.read(calendarUiProvider.notifier).setCycleTab(i == 1),
          ),
        Expanded(
          child: ListView(
            key: const Key('calendar-list'),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: showTimeline ? [const _Timeline()] : [const _CycleView()],
          ),
        ),
      ],
    );
  }
}

/// Title row used by the main tabs (no back arrow), with the language switch.
class TabTitleBar extends StatelessWidget {
  const TabTitleBar({super.key, required this.title, this.showLanguage = true});
  final String title;
  final bool showLanguage;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 10, 10, 6),
    child: Row(
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        if (showLanguage) const LanguageSwitcher(),
      ],
    ),
  );
}

/// Equal-width text tabs with an underline; long labels wrap.
class UnderlineTabs extends StatelessWidget {
  const UnderlineTabs({
    super.key,
    required this.labels,
    required this.index,
    required this.onChanged,
  });
  final List<String> labels;
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: p.line)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < labels.length; i++)
              Expanded(
                child: Semantics(
                  selected: i == index,
                  button: true,
                  child: InkWell(
                    key: Key('tab-$i'),
                    onTap: () => onChanged(i),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: i == index ? p.rose : Colors.transparent,
                            width: 2.5,
                          ),
                        ),
                      ),
                      child: Text(
                        labels[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: i == index ? p.rose : p.muted,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CycleView extends ConsumerWidget {
  const _CycleView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final c = ref.watch(contentProvider);
    final today = ref.watch(todayProvider);
    final ui = ref.watch(calendarUiProvider);
    final preg = m.me.journey == Journey.pregnancy;
    final periods = m.of(m.data.periods);
    final e = CycleEstimate.from(flowDaysOf(m), today, c);

    final out = <Widget>[];
    if (preg) {
      out.add(InfoBanner(l.cyclePausedInPregnancy));
    } else if (e.status == CycleStatus.none) {
      out.add(InfoBanner(l.cycleNoData));
    } else if (e.status == CycleStatus.stale) {
      out.add(InfoBanner(l.cycleStale, tone: Tone.warn));
    } else {
      out.add(_CycleCard(e: e, today: today));
    }
    if (!preg) {
      out.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TonalButton(
            l.cycleLogToday,
            key: const Key('cycle-log-period'),
            onPressed: () => pushPage(context, const PeriodPage()),
          ),
        ),
      );
    }

    int key(DateTime d) => dateOnly(d).millisecondsSinceEpoch;
    final period = {
      for (final x in periods)
        if (hasFlow(x.flow)) key(x.date),
    };
    final spot = {
      for (final x in periods)
        if (x.flow == Flow.spotting) key(x.date),
    };
    final appt = {for (final a in m.of(m.data.appointments)) key(a.at)};
    final logged = {for (final o in m.of(m.data.obs)) key(o.at)};
    final symd = {for (final s in m.of(m.data.symptoms)) key(s.at)};
    final medd = {for (final i in m.of(m.data.intakes)) key(i.date)};
    // Predicted periods and fertile windows for the coming months. They move
    // whenever a newly recorded period differs from the prediction.
    final predicted = <int>{}, fertile = <int>{};
    if (!preg) {
      for (final u in e.upcoming) {
        for (var d = u.start; !d.isAfter(u.end); d = addDays(d, 1)) {
          if (!d.isBefore(today)) predicted.add(key(d));
        }
        for (
          var d = u.fertileStart;
          !d.isAfter(u.fertileEnd);
          d = addDays(d, 1)
        ) {
          if (!d.isBefore(today)) fertile.add(key(d));
        }
      }
      predicted.removeAll(period);
      fertile
        ..removeAll(period)
        ..removeAll(predicted);
    }

    final month = ui.month;
    final lead = DateTime(month.year, month.month).weekday % 7; // Sunday first
    final count = DateTime(month.year, month.month + 1, 0).day;
    final wd = [
      for (var i = 0; i < 7; i++)
        DateFormat.EEEEE(context.intlLocale).format(DateTime(2024, 1, 7 + i)),
    ];
    final isThisMonth = month.year == today.year && month.month == today.month;
    final ctrl = ref.read(calendarUiProvider.notifier);

    out.add(
      AppCard(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  key: const Key('cal-prev'),
                  tooltip: l.actionPreviousMonth,
                  onPressed: () =>
                      ctrl.showMonth(DateTime(month.year, month.month - 1)),
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                Expanded(
                  child: Text(
                    context.formatMonth(month),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                IconButton(
                  key: const Key('cal-next'),
                  tooltip: l.actionNextMonth,
                  onPressed: () =>
                      ctrl.showMonth(DateTime(month.year, month.month + 1)),
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
            LayoutBuilder(
              builder: (context, box) {
                final cell = box.maxWidth / 7;
                final circle = (cell - 6).clamp(24.0, 34.0);
                final cells = <Widget>[
                  for (final w in wd)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          w,
                          style: TextStyle(fontSize: 12, color: p.muted),
                        ),
                      ),
                    ),
                  for (var i = 0; i < lead; i++) const SizedBox(),
                  for (var d = 1; d <= count; d++)
                    Builder(
                      builder: (context) {
                        final day = DateTime(month.year, month.month, d);
                        final k = key(day);
                        final isToday = isSameDay(day, today);
                        final dots = [
                          if (appt.contains(k)) p.ink,
                          if (logged.contains(k)) p.muted,
                          if (medd.contains(k)) p.fertile,
                          if (symd.contains(k)) p.symptom,
                        ];
                        final label = [
                          context.formatWeekdayDate(day),
                          if (isToday) l.today,
                          if (period.contains(k)) l.legendPeriod,
                          if (predicted.contains(k)) l.legendPredicted,
                          if (fertile.contains(k)) l.legendFertile,
                          if (appt.contains(k)) l.legendAppointment,
                          if (logged.contains(k)) l.legendLogged,
                          if (medd.contains(k)) l.legendMedication,
                          if (symd.contains(k)) l.daySymptoms,
                        ].join(', ');
                        final shaded = period.contains(k) || spot.contains(k);
                        final guess = predicted.contains(k);
                        final fert = fertile.contains(k);
                        final ring =
                            ui.ringDay != null &&
                            isSameDay(ui.ringDay!, day) &&
                            period.contains(k);
                        return Semantics(
                          button: true,
                          label: label,
                          excludeSemantics: true,
                          child: InkWell(
                            key: Key('day-${day.year}-${day.month}-${day.day}'),
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => showDaySheet(context, day),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: circle,
                                    height: circle,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          key: guess
                                              ? Key('predicted-$k')
                                              : fert
                                              ? Key('fertile-$k')
                                              : null,
                                          width: circle,
                                          height: circle,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: shaded
                                                ? p.periodSoft
                                                : fert
                                                ? p.fertileSoft
                                                : null,
                                            border: Border.all(
                                              color:
                                                  isToday && !period.contains(k)
                                                  ? p.ink
                                                  : guess
                                                  ? p.period
                                                  : Colors.transparent,
                                              width: guess && !isToday
                                                  ? 1.4
                                                  : 1.6,
                                            ),
                                          ),
                                          child: Text(
                                            '$d',
                                            textScaler: TextScaler.linear(
                                              MediaQuery.textScalerOf(context)
                                                      .scale(14)
                                                      .clamp(14, 16) /
                                                  14,
                                            ),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight:
                                                  period.contains(k) || isToday
                                                  ? FontWeight.w800
                                                  : FontWeight.w400,
                                              decoration:
                                                  isToday && period.contains(k)
                                                  ? TextDecoration.underline
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        if (ring)
                                          BrushCircle(
                                            key: ValueKey('brush-$k'),
                                            size: circle,
                                            color: p.period,
                                            onDone: ctrl.clearRing,
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  SizedBox(
                                    height: 6,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        for (final col in dots)
                                          Container(
                                            width: 5,
                                            height: 5,
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 1,
                                            ),
                                            decoration: BoxDecoration(
                                              color: col,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ];
                final rows = <Widget>[];
                for (var i = 0; i < cells.length; i += 7) {
                  rows.add(
                    Row(
                      children: [
                        for (var j = i; j < i + 7; j++)
                          Expanded(
                            child: j < cells.length
                                ? cells[j]
                                : const SizedBox(),
                          ),
                      ],
                    ),
                  );
                }
                return Column(children: rows);
              },
            ),
            if (!isThisMonth)
              TextButton(
                onPressed: () => ctrl.showMonth(today),
                child: Text(l.actionToday),
              ),
          ],
        ),
      ),
    );

    // Legend: period, appointment, health log, medication taken, symptoms.
    Widget sw(Color c, String text, {bool dot = true}) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: dot ? 8 : 14,
          height: dot ? 8 : 14,
          decoration: BoxDecoration(color: c, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Flexible(child: Text(text, style: const TextStyle(fontSize: 12))),
      ],
    );
    Widget ring(Color c, String text) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: c, width: 1.4),
          ),
        ),
        const SizedBox(width: 6),
        Flexible(child: Text(text, style: const TextStyle(fontSize: 12))),
      ],
    );
    out.add(
      Padding(
        key: const Key('calendar-legend'),
        padding: const EdgeInsets.fromLTRB(2, 4, 2, 12),
        child: Wrap(
          spacing: 14,
          runSpacing: 8,
          children: [
            sw(p.periodSoft, l.legendPeriod, dot: false),
            if (predicted.isNotEmpty) ring(p.period, l.legendPredicted),
            if (fertile.isNotEmpty)
              sw(p.fertileSoft, l.legendFertile, dot: false),
            sw(p.ink, l.legendAppointment),
            sw(p.muted, l.legendLogged),
            sw(p.fertile, l.legendMedication),
            sw(p.symptom, l.daySymptoms),
          ],
        ),
      ),
    );
    if (!preg) {
      out.add(
        Text(
          c.education['cycle']?.of(context.lang) ?? '',
          style: TextStyle(fontSize: 12.5, color: p.muted, height: 1.5),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: out,
    );
  }
}

class _CycleCard extends StatelessWidget {
  const _CycleCard({required this.e, required this.today});
  final CycleEstimate e;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    return AppCard(
      color: p.periodSoft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l.cycleNextPeriod,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Pill(l.estimateLabel, background: p.card),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            context.formatLongDate(e.next!),
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
          ),
          Text(
            e.lateDays > 0
                ? l.cycleDaysLate(e.lateDays)
                : l.cycleInDays(daysBetween(today, e.next!)),
          ),
          const SizedBox(height: 10),
          Text(
            l.cycleFertileWindow(
              context.formatDayMonth(e.fertileStart!),
              context.formatDayMonth(e.fertileEnd!),
            ),
          ),
          Text(l.cycleOvulation(context.formatDayMonth(e.ovulation!))),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              Pill(l.cycleAverageLength(e.cycleLength), background: p.card),
              Pill(l.cyclePeriodLength(e.periodLength), background: p.card),
              if (e.status == CycleStatus.defaults)
                Pill(l.cycleBasedOnTypical, background: p.card),
            ],
          ),
          if (e.irregular)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                l.cycleIrregularWarning,
                style: TextStyle(color: p.warn),
              ),
            ),
          if (e.shiftDays != 0)
            Padding(
              key: const Key('cycle-shift'),
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                e.shiftDays > 0
                    ? l.cycleShiftLater(e.shiftDays)
                    : l.cycleShiftEarlier(-e.shiftDays),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          const SizedBox(height: 12),
          Text(
            l.cycleUpcomingTitle,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          for (final u in e.upcoming.skip(1).take(3))
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                '• ${context.formatLongDate(u.start)}',
                key: const Key('cycle-upcoming'),
              ),
            ),
          const SizedBox(height: 6),
          Text(
            e.status == CycleStatus.defaults
                ? l.cycleNeedSecondPeriod
                : l.cycleBasedOnRecords(e.recorded),
            style: TextStyle(fontSize: 12.5, color: p.muted, height: 1.45),
          ),
        ],
      ),
    );
  }
}

/// Tap a date: what happened that day, with + buttons to add more and notes.
Future<void> showDaySheet(BuildContext context, DateTime day) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => DaySheet(day: dateOnly(day)),
    );

class DaySheet extends ConsumerWidget {
  const DaySheet({super.key, required this.day});
  final DateTime day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final c = ref.watch(contentProvider);
    final today = ref.watch(todayProvider);
    final future = daysBetween(today, day) > 0;
    PeriodDay? per;
    for (final x in m.of(m.data.periods)) {
      if (isSameDay(x.date, day)) per = x;
    }
    final sy = m.of(m.data.symptoms).where((s) => isSameDay(s.at, day));
    final lg = m.of(m.data.obs).where((o) => isSameDay(o.at, day));
    final ap = m.of(m.data.appointments).where((a) => isSameDay(a.at, day));
    final nt = m.of(m.data.notes).where((n) => isSameDay(n.date, day));

    void open(Widget page) {
      final nav = Navigator.of(context);
      nav.pop();
      nav.push(MaterialPageRoute<void>(builder: (_) => page));
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * .88,
      ),
      child: SingleChildScrollView(
        key: const Key('day-sheet'),
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.formatDayMonth(day),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            Text(
              context.formatWeekdayDate(day),
              style: TextStyle(color: p.muted),
            ),
            const SizedBox(height: 12),
            _DayBlock(
              title: l.dayPeriod,
              icon: Icons.water_drop_outlined,
              tone: p.period,
              background: p.periodSoft,
              rows: [if (per != null) l.flow(per.flow)],
              onAdd: future ? null : () => open(PeriodPage(day: day)),
              addKey: 'day-add-period',
            ),
            _DayBlock(
              title: l.daySymptoms,
              icon: Icons.healing_outlined,
              tone: p.pending,
              background: p.pendingSoft,
              rows: [for (final s in sy) c.symptomLabel(s.code, context.lang)],
              onAdd: future ? null : () => open(const SymptomsPage()),
              addKey: 'day-add-symptom',
            ),
            _DayBlock(
              title: l.dayHealthLogs,
              rows: [
                for (final o in lg) '${l.obs(o.type)}: ${obsValue(context, o)}',
              ],
              onAdd: future ? null : () => open(const AddLogPage()),
              addKey: 'day-add-log',
            ),
            _DayBlock(
              title: l.dayAppointments,
              rows: [
                for (final a in ap) '${context.formatTime(a.at)} ${a.purpose}',
              ],
              onAdd: () => open(AppointmentFormPage(day: day)),
              addKey: 'day-add-appointment',
            ),
            _DayBlock(
              title: l.dayNotes,
              rows: [for (final n in nt) n.text],
              onAdd: () => _addNote(context, ref, m.me.id),
              addKey: 'day-add-note',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addNote(
    BuildContext context,
    WidgetRef ref,
    String personId,
  ) async {
    final text = await showDialog<String>(
      context: context,
      builder: (_) => const _NoteDialog(),
    );
    if (text != null && text.trim().isNotEmpty) {
      ref
          .read(demoStoreProvider.notifier)
          .addNote(DayNote(personId, day, text.trim()));
    }
  }
}

class _NoteDialog extends StatefulWidget {
  const _NoteDialog();

  @override
  State<_NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<_NoteDialog> {
  final _c = TextEditingController();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AlertDialog(
      title: Text(l.addNoteTitle),
      content: SingleChildScrollView(
        child: AppTextField(
          fieldKey: const Key('note-text'),
          label: l.fieldNote,
          controller: _c,
          maxLines: 3,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l.actionCancel),
        ),
        FilledButton(
          key: const Key('note-save'),
          onPressed: () => Navigator.pop(context, _c.text),
          child: Text(l.actionSave),
        ),
      ],
    );
  }
}

class _DayBlock extends StatelessWidget {
  const _DayBlock({
    required this.title,
    required this.rows,
    this.onAdd,
    this.icon,
    this.tone,
    this.background,
    this.addKey,
  });

  final String title;
  final List<String> rows;
  final VoidCallback? onAdd;
  final IconData? icon;
  final Color? tone, background;
  final String? addKey;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: background == null
          ? const EdgeInsets.fromLTRB(2, 0, 0, 4)
          : const EdgeInsets.fromLTRB(12, 4, 6, 10),
      decoration: background == null
          ? null
          : BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(16),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: tone, size: 20),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              if (onAdd != null)
                IconButton(
                  key: addKey == null ? null : Key(addKey!),
                  tooltip: l.actionAdd,
                  onPressed: onAdd,
                  color: tone ?? p.rose,
                  icon: const Icon(Icons.add_rounded),
                )
              else
                const SizedBox(height: 48),
            ],
          ),
          if (rows.isEmpty)
            Text(
              l.nothingLogged,
              style: TextStyle(fontSize: 12.5, color: p.muted),
            )
          else
            for (final r in rows) Text('• $r'),
        ],
      ),
    );
  }
}

/// The pregnancy path: newest first, a Today marker, the start at the bottom.
class _Timeline extends ConsumerWidget {
  const _Timeline();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final c = ref.watch(contentProvider);
    final today = ref.watch(todayProvider);
    final me = m.me;
    final pr = PregnancyStatus.of(me, today, c);
    if (me.due == null) return EmptyNote(l.noData);
    final lmp = addDays(me.due!, -280);
    final second = c.dating['secondTrimesterStartWeek']!.toInt();
    final third = c.dating['thirdTrimesterStartWeek']!.toInt();
    final e = <(DateTime, IconData, String, String)>[
      (lmp, Icons.flag_outlined, l.timelineStart, ''),
      (
        addDays(lmp, second * 7),
        Icons.flag_outlined,
        l.timelineTrimesterStarts(l.trimesterSecond),
        '',
      ),
      (
        addDays(lmp, third * 7),
        Icons.flag_outlined,
        l.timelineTrimesterStarts(l.trimesterThird),
        '',
      ),
      (me.due!, Icons.child_friendly_outlined, l.timelineDueDate, ''),
      for (final a in m.of(m.data.appointments))
        if (!a.at.isBefore(lmp))
          (
            a.at,
            Icons.event_outlined,
            a.purpose,
            '${a.doctor} · ${context.formatTime(a.at)}',
          ),
      for (final s in m.of(m.data.scans))
        (
          s.date,
          Icons.insights_rounded,
          s.type,
          l.gaText(s.gaDays) +
              (s.measures['efw'] != null
                  ? ' · ${l.fetalEfw} ${context.formatNumber(s.measures['efw']!)} g'
                  : ''),
        ),
      for (final v in m.of(m.data.vaccines))
        if (!v.date.isBefore(lmp))
          (v.date, Icons.vaccines_outlined, v.name, l.vaccineGiven),
      for (final ms in m.of(m.data.milestones))
        (ms.date, Icons.star_outline_rounded, ms.title, ''),
    ]..sort((a, b) => b.$1.compareTo(a.$1));
    final firstPast = e.indexWhere((x) => daysBetween(today, x.$1) < 0);

    Widget todayMark() => Padding(
      key: const Key('timeline-today'),
      padding: const EdgeInsets.only(top: 4, bottom: 10),
      child: Row(
        children: [
          Pill(l.today, background: p.rose, foreground: p.onRose),
          const SizedBox(width: 8),
          Expanded(child: Container(height: 1.5, color: p.rose)),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (pr != null && pr.check == DueCheck.ok)
          AppCard(
            color: p.roseTint,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 10,
              spacing: 10,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l.gaText(pr.gaDays),
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(l.dueOn(context.formatLongDate(pr.due))),
                  ],
                ),
                TonalButton(
                  '+ ${l.createMilestone}',
                  onPressed: () => pushPage(context, const MilestonePage()),
                ),
              ],
            ),
          ),
        for (final (i, x) in e.indexed) ...[
          if (i == firstPast) todayMark(),
          _TimelineEntry(
            date: context.formatDate(x.$1),
            icon: x.$2,
            title: x.$3,
            detail: x.$4,
            past: daysBetween(today, x.$1) < 0,
            last: i == e.length - 1,
          ),
        ],
        if (firstPast == -1) todayMark(),
      ],
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.date,
    required this.icon,
    required this.title,
    required this.detail,
    required this.past,
    required this.last,
  });

  final String date, title, detail;
  final IconData icon;
  final bool past, last;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 36,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: past ? p.line : p.roseSoft,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 16, color: past ? p.muted : p.rose),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    constraints: const BoxConstraints(minHeight: 12),
                    color: last ? Colors.transparent : p.line,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(date, style: TextStyle(fontSize: 12.5, color: p.muted)),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: past ? p.muted : null,
                    ),
                  ),
                  if (detail.isNotEmpty)
                    Text(detail, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
