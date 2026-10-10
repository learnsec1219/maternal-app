import '../../../core/util/dates.dart';

enum FlowLevel { spotting, light, medium, heavy }

class PeriodEntry {
  const PeriodEntry({
    required this.id,
    required this.start,
    this.end,
    this.flow = FlowLevel.medium,
    this.note,
  });

  final String id;
  final DateTime start;
  final DateTime? end;
  final FlowLevel flow;
  final String? note;

  /// Whether [day] falls in this logged period. An open period counts its
  /// start day only until an end date is recorded.
  bool covers(DateTime day) {
    final last = end ?? start;
    return daysBetween(start, day) >= 0 && daysBetween(day, last) >= 0;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'start': start.toIso8601String(),
    if (end != null) 'end': end!.toIso8601String(),
    'flow': flow.name,
    if (note != null) 'note': note,
  };

  factory PeriodEntry.fromJson(Map<String, dynamic> j) => PeriodEntry(
    id: j['id'] as String,
    start: DateTime.parse(j['start'] as String),
    end: j['end'] == null ? null : DateTime.parse(j['end'] as String),
    flow: FlowLevel.values.asNameMap()[j['flow']] ?? FlowLevel.medium,
    note: j['note'] as String?,
  );
}
