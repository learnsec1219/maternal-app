enum HealthMetric {
  weight('kg'),
  bloodPressure('mmHg'),
  heartRate('bpm'),
  glucose('mmol/L'),
  temperature('°C'),
  spo2('%'),
  sleep('h'),
  water('glasses'),
  fetalMovement('kicks'),
  symptom('');

  const HealthMetric(this.unit);
  final String unit;
}

enum RangeStatus { low, normal, high }

/// Typical adult reference ranges used only to colour the dashboard cards.
/// These are not diagnostic thresholds.
class ReferenceRange {
  const ReferenceRange(this.low, this.high);
  final double low;
  final double high;

  RangeStatus classify(double v) => v < low
      ? RangeStatus.low
      : v > high
      ? RangeStatus.high
      : RangeStatus.normal;

  static const Map<HealthMetric, ReferenceRange> typical = {
    HealthMetric.bloodPressure: ReferenceRange(90, 139), // systolic
    HealthMetric.heartRate: ReferenceRange(60, 100),
    HealthMetric.glucose: ReferenceRange(3.5, 5.3), // fasting
    HealthMetric.temperature: ReferenceRange(36.0, 37.7),
    HealthMetric.spo2: ReferenceRange(95, 100),
  };
}

class HealthLogEntry {
  const HealthLogEntry({
    required this.id,
    required this.metric,
    required this.time,
    this.value,
    this.secondary,
    this.label,
    this.note,
  });

  final String id;
  final HealthMetric metric;
  final DateTime time;

  /// Main reading (systolic for blood pressure).
  final double? value;

  /// Diastolic for blood pressure.
  final double? secondary;

  /// Symptom key for [HealthMetric.symptom] entries.
  final String? label;
  final String? note;

  RangeStatus? get status {
    final v = value;
    final range = ReferenceRange.typical[metric];
    if (v == null || range == null) return null;
    final main = range.classify(v);
    // Diastolic above 89 also counts as high for blood pressure.
    if (metric == HealthMetric.bloodPressure &&
        main == RangeStatus.normal &&
        (secondary ?? 0) > 89) {
      return RangeStatus.high;
    }
    return main;
  }

  String get displayValue {
    final v = value;
    if (v == null) return '';
    String fmt(double x) =>
        x == x.roundToDouble() ? x.toInt().toString() : x.toStringAsFixed(1);
    if (metric == HealthMetric.bloodPressure && secondary != null) {
      return '${fmt(v)}/${fmt(secondary!)}';
    }
    return fmt(v);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'metric': metric.name,
    'time': time.toIso8601String(),
    if (value != null) 'value': value,
    if (secondary != null) 'secondary': secondary,
    if (label != null) 'label': label,
    if (note != null) 'note': note,
  };

  factory HealthLogEntry.fromJson(Map<String, dynamic> j) => HealthLogEntry(
    id: j['id'] as String,
    metric:
        HealthMetric.values.asNameMap()[j['metric']] ?? HealthMetric.symptom,
    time: DateTime.parse(j['time'] as String),
    value: (j['value'] as num?)?.toDouble(),
    secondary: (j['secondary'] as num?)?.toDouble(),
    label: j['label'] as String?,
    note: j['note'] as String?,
  );
}
