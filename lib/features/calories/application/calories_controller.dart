import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/local_store.dart';
import '../../../core/util/clock.dart';
import '../../../core/util/dates.dart';
import '../../profile/application/profile_controller.dart';
import '../domain/calorie_target.dart';
import '../domain/food_entry.dart';

final foodEntriesProvider =
    NotifierProvider<FoodEntriesController, List<FoodEntry>>(
      FoodEntriesController.new,
    );

class FoodEntriesController extends Notifier<List<FoodEntry>> {
  static const _key = 'food_entries';

  @override
  List<FoodEntry> build() => ref
      .read(localStoreProvider)
      .readList(_key)
      .map(FoodEntry.fromJson)
      .toList();

  void add(FoodEntry entry) {
    state = [...state, entry];
    _persist();
  }

  void remove(String id) {
    state = state.where((e) => e.id != id).toList();
    _persist();
  }

  void _persist() => ref
      .read(localStoreProvider)
      .writeJson(_key, state.map((e) => e.toJson()).toList());
}

final todayFoodProvider = Provider<List<FoodEntry>>((ref) {
  final today = ref.watch(todayProvider);
  return ref
      .watch(foodEntriesProvider)
      .where((e) => isSameDay(e.date, today))
      .toList();
});

class CalorieGoal {
  const CalorieGoal(this.kcal, {required this.isCustom});
  final int kcal;

  /// True when a clinician-set target overrides the estimate.
  final bool isCustom;
}

final calorieGoalProvider = Provider<CalorieGoal>((ref) {
  final profile = ref.watch(profileProvider);
  final custom = profile.calorieTargetOverride;
  if (custom != null) return CalorieGoal(custom, isCustom: true);
  return CalorieGoal(
    CalorieTarget.estimate(
      weightKg: profile.preWeightKg,
      heightCm: profile.heightCm,
      ageYears: profile.ageOn(ref.watch(todayProvider)),
      activity: profile.activity,
      trimester: ref.watch(gestationProvider)?.trimester,
    ),
    isCustom: false,
  );
});
