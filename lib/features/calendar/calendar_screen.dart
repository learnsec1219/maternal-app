import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../core/util/clock.dart';
import '../../core/util/dates.dart';
import '../../core/util/l10n.dart';
import '../../core/util/labels.dart';
import '../../core/widgets/common.dart';
import '../cycle/application/cycle_controller.dart';
import '../cycle/domain/cycle_predictor.dart';
import '../cycle/domain/period_entry.dart';
import '../cycle/presentation/period_form.dart';
import '../health_log/application/health_log_controller.dart';
import '../health_log/domain/health_log.dart';
import '../health_log/domain/symptoms.dart';
import '../pregnancy/domain/gestation.dart';
import '../profile/application/profile_controller.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  /// Page index of the current month; earlier months are lower indices.
  static const _origin = 600;
  final _pages = PageController(initialPage: _origin);
  late DateTime _selected = ref.read(todayProvider);
  int _page = _origin;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  DateTime _monthFor(int page) {
    final today = ref.read(todayProvider);
    return DateTime(today.year, today.month + page - _origin);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final forecast = ref.watch(cycleForecastProvider);
    final periods = ref.watch(periodsProvider);
    final gestation = ref.watch(gestationProvider);
    final month = _monthFor(_page);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
      children: [
        if (gestation != null) ...[
          _PregnancyTimeline(gestation: gestation),
          const SizedBox(height: 16),
        ],
        AppCard(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => _pages.previousPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      DateFormat.yMMMM(context.intlLocale).format(month),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => _pages.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                    ),
                  ),
                ],
              ),
              _WeekdayHeader(),
              SizedBox(
                height: 6 * 46,
                child: PageView.builder(
                  controller: _pages,
                  onPageChanged: (p) => setState(() => _page = p),
                  itemBuilder: (_, page) => _MonthGrid(
                    month: _monthFor(page),
                    selected: _selected,
                    periods: periods,
                    forecast: forecast,
                    onSelect: (d) => setState(() => _selected = d),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const _Legend(),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (forecast.hasEnoughHistory)
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.avgCycle(forecast.averageCycleLength)),
                Text(l.avgPeriod(forecast.averagePeriodLength)),
                if (forecast.isIrregular) ...[
                  const SizedBox(height: 8),
                  Text(
                    l.irregularNote,
                    style: const TextStyle(color: AppColors.warn),
                  ),
                ],
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 10, 4, 0),
          child: Text(
            l.estimatesNote,
            style: const TextStyle(fontSize: 12, color: AppColors.muted),
          ),
        ),
        SectionTitle(context.formatDate(_selected)),
        _DayDetails(day: _selected),
      ],
    );
  }
}

class _WeekdayHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final symbols = MaterialLocalizations.of(context).narrowWeekdays;
    final first = MaterialLocalizations.of(context).firstDayOfWeekIndex;
    return Row(
      children: [
        for (var i = 0; i < 7; i++)
          Expanded(
            child: Center(
              child: Text(
                symbols[(first + i) % 7],
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.muted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _MonthGrid extends ConsumerWidget {
  const _MonthGrid({
    required this.month,
    required this.selected,
    required this.periods,
    required this.forecast,
    required this.onSelect,
  });

  final DateTime month;
  final DateTime selected;
  final List<PeriodEntry> periods;
  final CycleForecast forecast;
  final ValueChanged<DateTime> onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = ref.watch(todayProvider);
    final firstDayIndex = MaterialLocalizations.of(context).firstDayOfWeekIndex;
    // DateTime.weekday: Mon=1..Sun=7; firstDayOfWeekIndex: Sun=0.
    final lead = (month.weekday % 7 - firstDayIndex + 7) % 7;
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisExtent: 46,
      ),
      itemCount: 42,
      itemBuilder: (context, i) {
        final dayNum = i - lead + 1;
        if (dayNum < 1 || dayNum > daysInMonth) return const SizedBox.shrink();
        final day = DateTime(month.year, month.month, dayNum);
        final isPeriod = periods.any((p) => p.covers(day));
        // Predictions only apply from today onward.
        final future = daysBetween(today, day) >= 0;
        return _DayCell(
          day: day,
          isToday: isSameDay(day, today),
          isSelected: isSameDay(day, selected),
          isPeriod: isPeriod,
          isPredicted: !isPeriod && future && forecast.isPredictedPeriod(day),
          isFertile: !isPeriod && future && forecast.isFertile(day),
          isOvulation: !isPeriod && future && forecast.isOvulation(day),
          onTap: () => onSelect(day),
        );
      },
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.isToday,
    required this.isSelected,
    required this.isPeriod,
    required this.isPredicted,
    required this.isFertile,
    required this.isOvulation,
    required this.onTap,
  });

  final DateTime day;
  final bool isToday, isSelected, isPeriod, isPredicted, isFertile, isOvulation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color? fill;
    Color text = AppColors.ink;
    BoxBorder? border;
    if (isPeriod) {
      fill = AppColors.period;
      text = Colors.white;
    } else if (isPredicted) {
      // Dashed look approximated with an outline so it differs from logged days.
      border = Border.all(color: AppColors.period, width: 1.5);
      fill = AppColors.predicted.withValues(alpha: 0.35);
    } else if (isFertile) {
      fill = AppColors.fertile;
    }
    if (isSelected) {
      border = Border.all(color: AppColors.ink, width: 2);
    }
    return Semantics(
      button: true,
      selected: isSelected,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: BoxDecoration(
              color: fill,
              shape: BoxShape.circle,
              border: border,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${day.day}',
                  style: TextStyle(
                    color: text,
                    fontWeight: isToday ? FontWeight.w800 : FontWeight.w500,
                    decoration: isToday ? TextDecoration.underline : null,
                  ),
                ),
                if (isOvulation)
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: AppColors.ovulation,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    Widget item(Widget swatch, String label) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        swatch,
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
    Widget dot(Color c, {Color? border}) => Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: c,
        shape: BoxShape.circle,
        border: border == null ? null : Border.all(color: border, width: 1.5),
      ),
    );
    return Wrap(
      spacing: 14,
      runSpacing: 6,
      alignment: WrapAlignment.center,
      children: [
        item(dot(AppColors.period), l.legendPeriod),
        item(
          dot(
            AppColors.predicted.withValues(alpha: 0.35),
            border: AppColors.period,
          ),
          l.legendPredicted,
        ),
        item(dot(AppColors.fertile), l.legendFertile),
        item(dot(AppColors.ovulation), l.legendOvulation),
      ],
    );
  }
}

class _DayDetails extends ConsumerWidget {
  const _DayDetails({required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final periods = ref
        .watch(periodsProvider)
        .where((p) => p.covers(day))
        .toList();
    final logs = ref
        .watch(healthLogProvider)
        .where((e) => isSameDay(e.time, day))
        .toList();
    final symptoms = SymptomKind.values.asNameMap();
    final isFuture = daysBetween(ref.watch(todayProvider), day) > 0;

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (periods.isEmpty && logs.isEmpty)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                l.dayEmpty,
                style: const TextStyle(color: AppColors.muted),
              ),
            ),
          for (final p in periods)
            ListTile(
              dense: true,
              leading: const Icon(Icons.water_drop, color: AppColors.period),
              title: Text('${l.legendPeriod} · ${l.flowLabel(p.flow)}'),
              subtitle: p.note == null ? null : Text(p.note!),
              trailing: IconButton(
                tooltip: l.delete,
                icon: const Icon(Icons.delete_outline, size: 20),
                onPressed: () =>
                    ref.read(periodsProvider.notifier).remove(p.id),
              ),
            ),
          for (final e in logs)
            ListTile(
              dense: true,
              leading: const Icon(Icons.monitor_heart_outlined),
              title: Text(
                e.metric == HealthMetric.symptom
                    ? (symptoms[e.label] == null
                          ? l.metricSymptom
                          : l.symptom(symptoms[e.label]!))
                    : '${l.metric(e.metric)}: ${e.displayValue} ${e.metric.unit}',
              ),
              subtitle: Text(context.formatTime(e.time)),
            ),
          if (periods.isEmpty && !isFuture)
            TextButton.icon(
              icon: const Icon(Icons.add),
              label: Text(l.logPeriodThisDay),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => PeriodForm(initialStart: day),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PregnancyTimeline extends StatelessWidget {
  const _PregnancyTimeline({required this.gestation});

  final Gestation gestation;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final milestones = [
      (13, l.ms_firstTrimesterEnds),
      (20, l.ms_halfway),
      (27, l.ms_thirdTrimester),
      (37, l.ms_fullTerm),
      (40, l.ms_dueDate),
    ];
    final lmp = addDays(gestation.dueDate, -pregnancyLengthDays);
    return AppCard(
      color: AppColors.roseSoft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.pregnancyTimeline,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            l.weeksDays(gestation.weeks, gestation.days),
            style: const TextStyle(color: AppColors.roseDeep),
          ),
          const SizedBox(height: 10),
          for (final (week, label) in milestones)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(
                    gestation.weeks >= week
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    size: 18,
                    color: gestation.weeks >= week
                        ? AppColors.safe
                        : AppColors.muted,
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text('${l.milestoneWeek(week)} · $label')),
                  Text(
                    context.formatShortDate(addDays(lmp, week * 7)),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
