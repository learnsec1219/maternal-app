import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import '../../core/util/labels.dart';
import '../../core/widgets/common.dart';
import '../calories/application/calories_controller.dart';
import '../cycle/application/cycle_controller.dart';
import '../health_log/application/health_log_controller.dart';
import '../health_log/domain/health_log.dart';
import '../health_log/domain/symptoms.dart';
import '../pregnancy/domain/gestation.dart';
import '../profile/application/profile_controller.dart';
import '../shell/app_shell.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final profile = ref.watch(profileProvider);
    final gestation = ref.watch(gestationProvider);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
          child: Text(
            profile.name.isEmpty
                ? l.homeGreetingNoName
                : l.homeGreeting(profile.name.split(' ').first),
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        if (gestation != null)
          _PregnancyCard(gestation: gestation, babies: profile.babies)
        else if (profile.isPregnant)
          _PromptCard(text: l.setDueDatePrompt)
        else
          const _CycleCard(),
        SectionTitle(l.todaysHealth),
        const _HealthGrid(),
        SectionTitle(l.todaysTasks),
        _TasksCard(pregnant: gestation != null),
        SectionTitle(l.recentActivity),
        const _RecentActivity(),
        SectionTitle(l.warningSigns),
        const _WarningSigns(),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            l.disclaimer,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11.5, color: AppColors.muted),
          ),
        ),
      ],
    );
  }
}

class _PregnancyCard extends StatelessWidget {
  const _PregnancyCard({required this.gestation, required this.babies});

  final Gestation gestation;
  final int babies;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final g = gestation;
    final countdown = g.daysToDue >= 0
        ? l.daysToGo(g.daysToDue)
        : l.daysPastDue(-g.daysToDue);
    return AppCard(
      color: AppColors.roseSoft,
      child: Row(
        children: [
          SizedBox(
            width: 92,
            height: 92,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: g.progress,
                  strokeWidth: 9,
                  strokeCap: StrokeCap.round,
                  backgroundColor: Colors.white,
                  color: AppColors.rose,
                  semanticsLabel: l.pregnancyOverview,
                ),
                Center(
                  child: Text(
                    '${g.weeks}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.weeksDays(g.weeks, g.days),
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  '${l.trimester(g.trimester)} · ${l.babiesCount('$babies')}',
                  style: const TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 8),
                Text(l.dueDateLabel(context.formatDate(g.dueDate))),
                Text(
                  countdown,
                  style: const TextStyle(
                    color: AppColors.roseDeep,
                    fontWeight: FontWeight.w600,
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

class _CycleCard extends ConsumerWidget {
  const _CycleCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final periods = ref.watch(periodsProvider);
    final forecast = ref.watch(cycleForecastProvider);
    final next = forecast.nextPeriodStart;
    return AppCard(
      color: AppColors.roseSoft,
      onTap: () =>
          ref.read(currentTabProvider.notifier).select(AppTab.calendar),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.cycleOverview,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          if (periods.isEmpty || next == null)
            Text(l.noCycleData)
          else ...[
            Text(l.nextPeriodEstimate(context.formatDate(next))),
            const SizedBox(height: 4),
            Text(
              l.avgCycle(forecast.averageCycleLength),
              style: const TextStyle(color: AppColors.muted),
            ),
          ],
        ],
      ),
    );
  }
}

class _PromptCard extends ConsumerWidget {
  const _PromptCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) => AppCard(
    color: AppColors.roseSoft,
    onTap: () => ref.read(currentTabProvider.notifier).select(AppTab.profile),
    child: Row(
      children: [
        const Icon(Icons.info_outline, color: AppColors.roseDeep),
        const SizedBox(width: 12),
        Expanded(child: Text(text)),
      ],
    ),
  );
}

class _HealthGrid extends ConsumerWidget {
  const _HealthGrid();

  static const _shown = [
    HealthMetric.weight,
    HealthMetric.bloodPressure,
    HealthMetric.heartRate,
    HealthMetric.glucose,
    HealthMetric.spo2,
    HealthMetric.sleep,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latest = ref.watch(latestByMetricProvider);
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.55,
      children: [
        for (final m in _shown) _MetricTile(metric: m, entry: latest[m]),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.metric, required this.entry});

  final HealthMetric metric;
  final HealthLogEntry? entry;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final e = entry;
    final status = e?.status;
    final (fg, bg) = switch (status) {
      RangeStatus.high => (AppColors.danger, AppColors.dangerBg),
      RangeStatus.low => (AppColors.warn, AppColors.warnBg),
      _ => (AppColors.safe, AppColors.safeBg),
    };
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l.metric(metric),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12.5, color: AppColors.muted),
          ),
          if (e == null)
            Text(l.noData, style: const TextStyle(color: AppColors.muted))
          else
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: e.displayValue,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: ' ${metric.unit}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
            ),
          if (status != null)
            StatusPill(l.rangeStatus(status), fg: fg, bg: bg)
          else if (e != null)
            Text(
              context.formatShortDate(e.time),
              style: const TextStyle(fontSize: 11.5, color: AppColors.muted),
            ),
        ],
      ),
    );
  }
}

class _TasksCard extends ConsumerWidget {
  const _TasksCard({required this.pregnant});

  final bool pregnant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final bpToday =
        ref.watch(todayTotalProvider(HealthMetric.bloodPressure)) > 0;
    final kicks = ref.watch(todayTotalProvider(HealthMetric.fetalMovement));
    final water = ref.watch(todayTotalProvider(HealthMetric.water));
    final meals = ref.watch(todayFoodProvider).isNotEmpty;
    final tasks = [
      (l.taskLogBp, bpToday),
      if (pregnant) (l.taskKicks, kicks > 0),
      (l.taskWater, water >= 8),
      (l.taskLogMeal, meals),
    ];
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Column(
        children: [
          for (final (label, done) in tasks)
            ListTile(
              dense: true,
              leading: Icon(
                done ? Icons.check_circle : Icons.radio_button_unchecked,
                color: done ? AppColors.safe : AppColors.muted,
              ),
              title: Text(
                label,
                style: TextStyle(
                  decoration: done ? TextDecoration.lineThrough : null,
                  color: done ? AppColors.muted : AppColors.ink,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RecentActivity extends ConsumerWidget {
  const _RecentActivity();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final entries = ref.watch(healthLogProvider).take(5).toList();
    if (entries.isEmpty) {
      return AppCard(
        child: Text(
          l.noActivity,
          style: const TextStyle(color: AppColors.muted),
        ),
      );
    }
    final symptoms = SymptomKind.values.asNameMap();
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Column(
        children: [
          for (final e in entries)
            ListTile(
              dense: true,
              title: Text(
                e.metric == HealthMetric.symptom
                    ? (symptoms[e.label] == null
                          ? l.metricSymptom
                          : l.symptom(symptoms[e.label]!))
                    : '${l.metric(e.metric)}: ${e.displayValue} ${e.metric.unit}',
              ),
              subtitle: Text(
                '${context.formatShortDate(e.time)} · ${context.formatTime(e.time)}',
              ),
              trailing: IconButton(
                tooltip: l.delete,
                icon: const Icon(Icons.delete_outline, size: 20),
                onPressed: () =>
                    ref.read(healthLogProvider.notifier).remove(e.id),
              ),
            ),
        ],
      ),
    );
  }
}

class _WarningSigns extends StatelessWidget {
  const _WarningSigns();

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AppCard(
      color: AppColors.warnBg,
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              l.warningSignsIntro,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          for (final s in SymptomKind.warnings)
            Theme(
              data: Theme.of(context)
                  .copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                dense: true,
                title: Text(
                  l.symptom(s),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                expandedAlignment: Alignment.centerLeft,
                children: [
                  Text(
                    l.symptomAction(s)!,
                    style: const TextStyle(
                      color: AppColors.danger,
                      fontWeight: FontWeight.w600,
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
