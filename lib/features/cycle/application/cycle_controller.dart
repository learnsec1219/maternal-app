import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/local_store.dart';
import '../domain/cycle_predictor.dart';
import '../domain/period_entry.dart';

final periodsProvider = NotifierProvider<PeriodsController, List<PeriodEntry>>(
  PeriodsController.new,
);

/// Logged periods, oldest first.
class PeriodsController extends Notifier<List<PeriodEntry>> {
  static const _key = 'periods';

  @override
  List<PeriodEntry> build() =>
      ref
          .read(localStoreProvider)
          .readList(_key)
          .map(PeriodEntry.fromJson)
          .toList()
        ..sort((a, b) => a.start.compareTo(b.start));

  void add(PeriodEntry entry) {
    state = [...state, entry]..sort((a, b) => a.start.compareTo(b.start));
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

final cycleForecastProvider = Provider<CycleForecast>(
  (ref) => CyclePredictor.forecast(ref.watch(periodsProvider)),
);
