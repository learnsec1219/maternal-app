import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/util/l10n.dart';
import '../../../core/util/labels.dart';
import '../../../core/widgets/common.dart';
import '../application/calories_controller.dart';
import '../domain/food_entry.dart';
import 'food_form.dart';

class CaloriesScreen extends ConsumerWidget {
  const CaloriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final goal = ref.watch(calorieGoalProvider);
    final entries = ref.watch(todayFoodProvider);
    final totals = DayTotals.of(entries);
    final remaining = goal.kcal - totals.kcal;
    final progress = goal.kcal == 0 ? 0.0 : totals.kcal / goal.kcal;
    String g(double v) => v.round().toString();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
      children: [
        AppCard(
          color: AppColors.roseSoft,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: progress.clamp(0.0, 1.0),
                          strokeWidth: 10,
                          strokeCap: StrokeCap.round,
                          backgroundColor: Colors.white,
                          color: remaining < 0
                              ? AppColors.warn
                              : AppColors.rose,
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${remaining.abs()}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                remaining < 0 ? l.statusHigh : l.remaining,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Stat(l.calorieTarget, l.kcalValue(goal.kcal)),
                        _Stat(l.consumed, l.kcalValue(totals.kcal)),
                        _Stat(
                          l.remaining,
                          remaining < 0
                              ? l.overBy(-remaining)
                              : l.kcalValue(remaining),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                l.macros(g(totals.proteinG), g(totals.carbsG), g(totals.fatG)),
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 10, 4, 0),
          child: Text(
            goal.isCustom ? l.targetCustomNote : l.targetEstimateNote,
            style: const TextStyle(fontSize: 12, color: AppColors.muted),
          ),
        ),
        for (final meal in Meal.values)
          _MealSection(
            meal: meal,
            entries: entries.where((e) => e.meal == meal).toList(),
          ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 13),
          ),
        ),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

class _MealSection extends ConsumerWidget {
  const _MealSection({required this.meal, required this.entries});

  final Meal meal;
  final List<FoodEntry> entries;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final kcal = DayTotals.of(entries).kcal;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle(
          l.meal(meal),
          trailing: Text(
            l.kcalValue(kcal),
            style: const TextStyle(color: AppColors.muted),
          ),
        ),
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final e in entries)
                ListTile(
                  dense: true,
                  title: Text(e.name),
                  subtitle: e.portion == null ? null : Text(e.portion!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(l.kcalValue(e.kcal)),
                      IconButton(
                        tooltip: l.delete,
                        icon: const Icon(Icons.delete_outline, size: 20),
                        onPressed: () =>
                            ref.read(foodEntriesProvider.notifier).remove(e.id),
                      ),
                    ],
                  ),
                ),
              TextButton.icon(
                icon: const Icon(Icons.add),
                label: Text(l.addFood),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (_) => FoodForm(meal: meal),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
