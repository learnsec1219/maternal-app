import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/local_store.dart';
import '../../../core/util/clock.dart';
import '../../../core/util/dates.dart';
import '../domain/health_log.dart';

final healthLogProvider =
    NotifierProvider<HealthLogController, List<HealthLogEntry>>(
      HealthLogController.new,
    );

/// Health log entries, newest first.
class HealthLogController extends Notifier<List<HealthLogEntry>> {
  static const _key = 'health_logs';

  @override
  List<HealthLogEntry> build() =>
      ref
          .read(localStoreProvider)
          .readList(_key)
          .map(HealthLogEntry.fromJson)
          .toList()
        ..sort((a, b) => b.time.compareTo(a.time));

  void add(HealthLogEntry entry) {
    state = [entry, ...state]..sort((a, b) => b.time.compareTo(a.time));
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

/// Most recent entry per metric.
final latestByMetricProvider = Provider<Map<HealthMetric, HealthLogEntry>>((
  ref,
) {
  final latest = <HealthMetric, HealthLogEntry>{};
  for (final e in ref.watch(healthLogProvider)) {
    latest.putIfAbsent(e.metric, () => e);
  }
  return latest;
});

/// Sum of today's entries for count-style metrics (water, fetal movements).
final todayTotalProvider = Provider.family<double, HealthMetric>((ref, metric) {
  final today = ref.watch(todayProvider);
  return ref
      .watch(healthLogProvider)
      .where((e) => e.metric == metric && isSameDay(e.time, today))
      .fold(0.0, (sum, e) => sum + (e.value ?? 0));
});
