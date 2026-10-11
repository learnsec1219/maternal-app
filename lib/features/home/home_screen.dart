import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/content/clinical_content.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/clock.dart';
import '../../core/util/dates.dart';
import '../../core/util/l10n.dart';
import '../../core/util/labels.dart';
import '../../core/widgets/charts.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../../data/models.dart';
import '../../domain/health_rules.dart';
import '../assistant/assistant_page.dart';
import '../patient/patient_data.dart';
import '../records/care_pages.dart';
import '../records/health_pages.dart';
import '../records/pregnancy_pages.dart';
import '../settings/language_switcher.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _baby = false;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final c = ref.watch(contentProvider);
    final today = ref.watch(todayProvider);
    final now = DateTime.now();
    final me = m.me;
    final pr = PregnancyStatus.of(me, today, c);
    final rem = remindersFor(context, m, today, now, c);

    final children = <Widget>[
      // Header: avatar, greeting, care stage, reminders bell, language.
      Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 12),
        child: Row(
          children: [
            Avatar(me.name, size: 44, photoUrl: me.photoUrl),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.homeGreeting(me.name.split(' ').first),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Pill(journeyLabel(l, me.journey)),
                ],
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  key: const Key('home-reminders'),
                  tooltip: l.remindersTitle,
                  onPressed: () => pushPage(context, const RemindersPage()),
                  icon: const Icon(Icons.notifications_none_rounded),
                ),
                if (rem.isNotEmpty)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: IgnorePointer(
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: p.rose,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text(
                          '${rem.length}',
                          textScaler: TextScaler.noScaling,
                          style: TextStyle(
                            fontSize: 10,
                            color: p.onRose,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const LanguageSwitcher(),
          ],
        ),
      ),
    ];

    final askCard = AppCard(
      onTap: () => pushPage(context, const AssistantPage()),
      child: Row(
        children: [
          TileIcon(
            Icons.chat_bubble_outline_rounded,
            background: p.sky,
            size: 42,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.assistantTitle,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  l.assistantHomeHint,
                  style: TextStyle(fontSize: 12.5, color: p.muted),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: p.muted),
        ],
      ),
    );

    if (me.journey == Journey.pregnancy && pr != null) {
      if (pr.check != DueCheck.ok) {
        children.add(
          InfoBanner(
            l.dueDateInvalidBody(context.formatLongDate(pr.due)),
            title: l.dueDateInvalidTitle,
            tone: Tone.warn,
          ),
        );
      } else {
        children.add(PregnancyCard(status: pr));
      }
      children.add(askCard);
      children.add(
        Segmented(
          labels: [l.homeTabMother, l.homeTabBaby],
          index: _baby ? 1 : 0,
          onChanged: (i) => setState(() => _baby = i == 1),
        ),
      );
    } else if (me.journey == Journey.postpartum) {
      final start = me.journeyStart ?? today;
      final d = daysBetween(start, today);
      children.add(
        AppCard(
          color: p.roseTint,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.journeyPostpartum,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(l.postpartumSince(d ~/ 7, d % 7)),
              Text(
                l.deliveredOn(context.formatLongDate(start)),
                style: TextStyle(fontSize: 12.5, color: p.muted),
              ),
            ],
          ),
        ),
      );
      children.add(askCard);
    } else {
      final e = CycleEstimate.from(flowDaysOf(m), today, c);
      children.add(
        AppCard(
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
              if (e.next != null) ...[
                const SizedBox(height: 6),
                Text(
                  context.formatLongDate(e.next!),
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  e.lateDays > 0
                      ? l.cycleDaysLate(e.lateDays)
                      : l.cycleInDays(daysBetween(today, e.next!)),
                ),
              ] else
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(l.cycleNoEstimate),
                ),
              const SizedBox(height: 12),
              TonalButton(
                l.cycleLogToday,
                onPressed: () => pushPage(context, const PeriodPage()),
              ),
            ],
          ),
        ),
      );
      children.add(askCard);
    }

    if (me.journey == Journey.pregnancy && pr != null && _baby) {
      children.add(BabySection(scans: m.of(m.data.scans), canAdd: true));
      children.add(const Disclaimer());
      return _list(children);
    }

    for (final (tone, msg) in rem.take(2)) {
      children.add(InfoBanner(msg, tone: tone));
    }

    // Today's health.
    final obs = m.of(m.data.obs)..sort((a, b) => b.at.compareTo(a.at));
    final latest = <ObsType, Observation>{};
    for (final o in obs) {
      latest.putIfAbsent(o.type, () => o);
    }
    children.add(
      SectionHeader(
        l.homeTodaysHealth,
        action: TextButton(
          onPressed: () => pushPage(context, const AddLogPage()),
          child: Text(l.actionAdd),
        ),
      ),
    );
    children.add(
      TwoColumn(
        children: [
          for (final k in const [
            ObsType.weight,
            ObsType.bp,
            ObsType.hr,
            ObsType.glu,
            ObsType.spo2,
            ObsType.sleep,
            ObsType.steps,
          ])
            _MetricTile(type: k, latest: latest[k], today: today, content: c),
        ],
      ),
    );

    // Today's tasks.
    final kicks = m
        .of(m.data.kicks)
        .where((k) => isSameDay(k.at, today))
        .length;
    final water = m
        .of(m.data.obs)
        .where((o) => o.type == ObsType.water && isSameDay(o.at, today))
        .fold<double>(0, (a, o) => a + o.value);
    final store = ref.read(demoStoreProvider.notifier);
    children.add(SectionHeader(l.homeTodaysTasks));
    children.add(
      AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: Column(
          children: [
            for (final (i, d) in dosesFor(m, today).indexed)
              _Task(
                done: d.taken,
                title: l.taskTakeMedication(d.med.name, d.med.dose),
                subtitle: d.slot,
                first: i == 0,
                onTap: d.taken
                    ? null
                    : () => store.takeDose(me.id, d.med.id, d.slot, today),
              ),
            if (me.journey == Journey.pregnancy)
              _Task(
                done: kicks > 0,
                title: l.taskCountKicks,
                subtitle: l.kicksTodayCount(kicks),
                first: dosesFor(m, today).isEmpty,
                onTap: () => pushPage(context, const KickPage()),
              ),
            _Task(
              done: water >= 1500,
              title: l.taskDrinkWater,
              subtitle: l.waterTodayMl(context.formatNumber(water)),
              first: false,
              onTap: () =>
                  pushPage(context, const AddLogPage(type: ObsType.water)),
            ),
          ],
        ),
      ),
    );

    // Next appointment.
    final up =
        m.of(m.data.appointments).where((a) => a.at.isAfter(now)).toList()
          ..sort((a, b) => a.at.compareTo(b.at));
    children.add(SectionHeader(l.homeNextAppointment));
    children.add(
      up.isEmpty
          ? AppCard(child: EmptyNote(l.appointmentsNoneUpcoming))
          : AppointmentCard(appointment: up.first, highlight: true),
    );

    // Latest activity.
    final recent = <(DateTime, IconData, String, String)>[
      for (final o in obs.take(6))
        (o.at, obsStyle(o.type).icon, l.obs(o.type), obsValue(context, o)),
      for (final s in m.of(m.data.symptoms).reversed.take(3))
        (
          s.at,
          Icons.healing_outlined,
          l.symptomLogged,
          c.symptomLabel(s.code, context.lang),
        ),
    ]..sort((a, b) => b.$1.compareTo(a.$1));
    children.add(SectionHeader(l.homeRecentActivity));
    children.add(
      recent.isEmpty
          ? AppCard(child: EmptyNote(l.activityEmpty))
          : ListCard(
              rows: [
                for (final (at, icon, a, b) in recent.take(6))
                  ListRow(
                    leading: Icon(icon, color: p.rose),
                    title: a,
                    subtitle: b,
                    trailing: Text(
                      context.formatDateTime(at),
                      style: TextStyle(fontSize: 12, color: p.muted),
                    ),
                  ),
              ],
            ),
    );
    children.add(InfoBanner(l.demoModeBody, title: l.demoModeTitle));
    children.add(const Disclaimer());
    return _list(children);
  }

  Widget _list(List<Widget> children) => ListView(
    key: const Key('home-list'),
    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
    children: children,
  );
}

/// Week ring, gestation, trimester and due date.
class PregnancyCard extends StatelessWidget {
  const PregnancyCard({super.key, required this.status});
  final PregnancyStatus status;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal, pr = status;
    return AppCard(
      color: p.roseTint,
      child: Row(
        children: [
          ProgressRing(
            progress: pr.progress,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${pr.weeks}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                Text(l.unitWeeksShort, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.gaText(pr.gaDays),
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  l.trimester(pr.trimester),
                  style: TextStyle(color: p.muted),
                ),
                const SizedBox(height: 10),
                Text(
                  l.dueOn(context.formatLongDate(pr.due)),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  pr.daysToDue >= 0
                      ? l.daysToGo(pr.daysToDue)
                      : l.daysPastDue(-pr.daysToDue),
                ),
                if (pr.babies > 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Pill(l.babyCount(pr.babies), background: p.card),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Two-option pill switch (Mother / Baby).
class Segmented extends StatelessWidget {
  const Segmented({
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
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: p.line),
        borderRadius: BorderRadius.circular(99),
        color: p.card,
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++)
            Expanded(
              child: Semantics(
                selected: i == index,
                button: true,
                child: Material(
                  color: i == index ? p.roseSoft : p.card,
                  child: InkWell(
                    onTap: () => onChanged(i),
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 42),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Text(
                        labels[i],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.type,
    required this.latest,
    required this.today,
    required this.content,
  });
  final ObsType type;
  final Observation? latest;
  final DateTime today;
  final ClinicalContent content;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal, st = obsStyle(type), o = latest;
    return Material(
      color: p.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: p.line),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => pushPage(
          context,
          o == null ? AddLogPage(type: type) : TrendPage(type: type),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TileIcon(st.icon, background: st.tint(p), size: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l.obs(type),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              if (o != null) ...[
                const SizedBox(height: 10),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    obsValue(context, o),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      isSameDay(o.at, today)
                          ? l.today
                          : context.formatShortDate(o.at),
                      style: TextStyle(fontSize: 12, color: p.muted),
                    ),
                    rangePill(context, rangeOf(o, content)),
                  ],
                ),
              ] else
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    l.noDataTapToAdd,
                    style: TextStyle(fontSize: 12.5, color: p.muted),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Task extends StatelessWidget {
  const _Task({
    required this.done,
    required this.title,
    required this.subtitle,
    required this.first,
    this.onTap,
  });
  final bool done, first;
  final String title, subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    return ListRow(
      divider: !first,
      onTap: onTap,
      leading: Icon(
        done
            ? Icons.check_circle_rounded
            : Icons.radio_button_unchecked_rounded,
        color: done ? p.good : p.muted,
        semanticLabel: done ? l.taskDone : l.taskNotDone,
      ),
      title: title,
      subtitle: subtitle,
      strike: done,
    );
  }
}

/// Baby's measurements from the scans, each with a small trend line.
class BabySection extends ConsumerWidget {
  const BabySection({super.key, required this.scans, this.canAdd = false});
  final List<Scan> scans;
  final bool canAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final c = ref.watch(contentProvider);
    final fields = <(String, String, String, int)>[
      ('efw', l.fetalEfw, 'g', 0),
      ('crl', l.fetalCrl, 'mm', 0),
      ('bpd', l.fetalBpd, 'mm', 0),
      ('hc', l.fetalHc, 'mm', 0),
      ('ac', l.fetalAc, 'mm', 0),
      ('fl', l.fetalFl, 'mm', 0),
      ('afi', l.fetalAfi, 'cm', 1),
      ('fhr', l.fetalFhr, 'bpm', 0),
      ('nt', l.fetalNt, 'mm', 1),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          l.babyParameters,
          action: canAdd
              ? TextButton(
                  onPressed: () => pushPage(context, const AddScanPage()),
                  child: Text(l.actionAdd),
                )
              : null,
        ),
        InfoBanner(c.education['growth']?.of(context.lang) ?? ''),
        TwoColumn(
          children: [
            for (final (k, label, unit, dec) in fields)
              Builder(
                builder: (context) {
                  final s = scans.where((x) => x.measures[k] != null).toList()
                    ..sort((a, b) => a.gaDays.compareTo(b.gaDays));
                  final last = s.isEmpty ? null : s.last;
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: p.card,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: p.line),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (last == null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              l.noData,
                              style: TextStyle(fontSize: 12.5, color: p.muted),
                            ),
                          )
                        else ...[
                          const SizedBox(height: 8),
                          Text(
                            '${context.formatNumber(last.measures[k]!, dec)} $unit',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            l.atGestation(l.gaText(last.gaDays)),
                            style: TextStyle(fontSize: 12, color: p.muted),
                          ),
                          if (k == 'efw' && last.percentile != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Pill(
                                l.percentileFromReport(
                                  context.formatNumber(last.percentile!),
                                ),
                              ),
                            ),
                          if (s.length > 1)
                            LineChart(
                              height: 70,
                              axis: false,
                              points: [
                                for (final x in s)
                                  ChartPoint(x.gaDays / 7, x.measures[k]!),
                              ],
                            ),
                        ],
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ],
    );
  }
}
