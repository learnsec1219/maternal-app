import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/content/clinical_content.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/clock.dart';
import '../../core/util/dates.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/charts.dart';
import '../../core/widgets/common.dart';
import '../../data/models.dart';
import '../../domain/health_rules.dart';
import '../calendar/calendar_screen.dart';
import '../patient/patient_data.dart';
import 'food_form.dart';

class CaloriesScreen extends ConsumerStatefulWidget {
  const CaloriesScreen({super.key});

  @override
  ConsumerState<CaloriesScreen> createState() => _CaloriesScreenState();
}

class _CaloriesScreenState extends ConsumerState<CaloriesScreen> {
  int _offset = 0;
  int _range = 7;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final c = ref.watch(contentProvider);
    final today = ref.watch(todayProvider);
    final day = addDays(today, _offset);
    final entries = m.of(m.data.foods);
    final de = entries.where((f) => isSameDay(f.at, day)).toList();
    final eaten = de.fold<double>(0, (a, f) => a + f.kcal);
    final weights =
        m.of(m.data.obs).where((o) => o.type == ObsType.weight).toList()
          ..sort((a, b) => b.at.compareTo(a.at));
    final w = weights.isEmpty ? m.me.weight : weights.first.value;
    final pr = PregnancyStatus.of(m.me, today, c);
    final target = calorieTarget(
      m.me,
      w,
      pr != null && pr.check == DueCheck.ok ? pr.trimester : null,
      today,
      c,
    );

    final children = <Widget>[
      Row(
        children: [
          IconButton(
            tooltip: l.actionPreviousDay,
            onPressed: () => setState(() => _offset--),
            icon: const Icon(Icons.chevron_left_rounded),
          ),
          Expanded(
            child: Text(
              _offset == 0 ? l.today : context.formatWeekdayDate(day),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          IconButton(
            tooltip: l.actionNextDay,
            onPressed: _offset >= 0 ? null : () => setState(() => _offset++),
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    ];

    if (target == null) {
      children.add(
        InfoBanner(l.calorieNoTargetBody, title: l.calorieNoTargetTitle),
      );
    } else {
      final rem = target - eaten;
      children.add(
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ProgressRing(
                    size: 112,
                    progress: eaten / target,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.formatNumber(eaten),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          l.kcalConsumed,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l.calorieTarget, style: TextStyle(color: p.muted)),
                        Text(
                          '${context.formatNumber(target)} kcal',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Pill(
                          m.me.clinicianTarget != null
                              ? l.targetSetByClinician
                              : l.estimateLabel,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          rem >= 0
                              ? l.kcalRemaining(context.formatNumber(rem))
                              : l.kcalOver(context.formatNumber(-rem)),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.watch_outlined, size: 18, color: p.muted),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l.kcalBurntNotConnected,
                      style: TextStyle(fontSize: 12.5, color: p.muted),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                c.education['calories']?.of(context.lang) ?? '',
                style: TextStyle(fontSize: 12.5, color: p.muted, height: 1.45),
              ),
            ],
          ),
        ),
      );
    }

    final pro = de.fold<double>(0, (a, f) => a + f.protein);
    final carb = de.fold<double>(0, (a, f) => a + f.carbs);
    final fat = de.fold<double>(0, (a, f) => a + f.fat);
    final total = (pro + carb + fat) <= 0 ? 1.0 : pro + carb + fat;
    children.add(
      AppCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final (i, (label, g, col)) in [
              (l.macroProtein, pro, p.rose),
              (l.macroCarbs, carb, p.warn),
              (l.macroFat, fat, p.fertile),
            ].indexed) ...[
              if (i > 0) const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12.5, color: p.muted),
                    ),
                    Text(
                      '${context.formatNumber(g)} g',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: LinearProgressIndicator(
                        value: g / total,
                        minHeight: 6,
                        color: col,
                        backgroundColor: p.line,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );

    for (final meal in Meal.values) {
      final items = de.where((f) => f.meal == meal).toList();
      children.add(
        AppCard(
          padding: const EdgeInsets.fromLTRB(16, 6, 6, 8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _mealLabel(context, meal),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    '${context.formatNumber(items.fold<double>(0, (a, f) => a + f.kcal))} kcal',
                    style: TextStyle(color: p.muted),
                  ),
                  IconButton(
                    tooltip: l.actionAdd,
                    color: p.rose,
                    onPressed: () =>
                        pushPage(context, FoodFormPage(meal: meal, day: day)),
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),
              for (final f in items)
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(f.name),
                            Text(
                              l.macroSummary(
                                context.formatNumber(f.protein),
                                context.formatNumber(f.carbs),
                                context.formatNumber(f.fat),
                              ),
                              style: TextStyle(fontSize: 12.5, color: p.muted),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${context.formatNumber(f.kcal)} kcal',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
    }

    // History chart.
    final vals = <double>[], labs = <String>[];
    for (var b = _range - 1; b >= 0; b--) {
      final d = addDays(today, -b);
      vals.add(
        entries
            .where((f) => isSameDay(f.at, d))
            .fold<double>(0, (a, f) => a + f.kcal),
      );
      labs.add(b % (_range ~/ 5 + 1) == 0 ? context.formatShortDate(d) : '');
    }
    final logged = vals.where((v) => v > 0).toList();
    final avg = logged.isEmpty
        ? 0.0
        : logged.reduce((a, b) => a + b) / logged.length;
    children.add(SectionHeader(l.calorieHistory));
    children.add(
      ChoiceChips<int>(
        options: [
          for (final r in const [7, 14, 30]) (r, l.lastNDays(r)),
        ],
        selected: _range,
        onSelected: (r) => setState(() => _range = r),
      ),
    );
    children.add(
      AppCard(
        child: logged.isEmpty
            ? EmptyNote(l.calorieNoData)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BarChart(
                    values: vals,
                    labels: labs,
                    target: target?.toDouble(),
                    semanticLabel: l.calorieChartSummary(_range, logged.length),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      for (final (label, v) in [
                        (l.statLowest, logged.reduce((a, b) => a < b ? a : b)),
                        (l.statAverage, avg),
                        (l.statHighest, logged.reduce((a, b) => a > b ? a : b)),
                      ])
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                label,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: p.muted,
                                ),
                              ),
                              Text(
                                context.formatNumber(v),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Text(
                                'kcal',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    logged.length < 3
                        ? l.calorieAnalysisTooFew
                        : target != null
                        ? l.calorieAnalysis(
                            logged.length,
                            context.formatNumber(avg),
                            context.formatNumber(avg / target * 100),
                          )
                        : l.calorieAnalysisNoTarget(
                            logged.length,
                            context.formatNumber(avg),
                          ),
                    style: const TextStyle(height: 1.45),
                  ),
                  if (target != null)
                    Text(
                      l.chartTargetLineNote,
                      style: TextStyle(fontSize: 12.5, color: p.muted),
                    ),
                ],
              ),
      ),
    );

    return Column(
      children: [
        TabTitleBar(title: l.navCalories),
        Expanded(
          child: ListView(
            key: const Key('calories-list'),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            children: children,
          ),
        ),
      ],
    );
  }
}

String _mealLabel(BuildContext context, Meal m) {
  final l = context.l10n;
  return switch (m) {
    Meal.breakfast => l.mealBreakfast,
    Meal.lunch => l.mealLunch,
    Meal.dinner => l.mealDinner,
    Meal.snack => l.mealSnacks,
    Meal.drink => l.mealDrinks,
  };
}
