import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/util/ids.dart';
import '../../../core/util/l10n.dart';
import '../../../core/util/labels.dart';
import '../../../core/widgets/common.dart';
import '../application/health_log_controller.dart';
import '../domain/health_log.dart';

/// Metrics entered as numbers in this form (symptoms have their own form).
const loggableMetrics = [
  HealthMetric.bloodPressure,
  HealthMetric.weight,
  HealthMetric.heartRate,
  HealthMetric.glucose,
  HealthMetric.temperature,
  HealthMetric.spo2,
  HealthMetric.sleep,
  HealthMetric.water,
  HealthMetric.fetalMovement,
];

/// Plausible input bounds, to catch typos rather than judge health.
const _bounds = {
  HealthMetric.bloodPressure: (40.0, 260.0),
  HealthMetric.weight: (25.0, 250.0),
  HealthMetric.heartRate: (25.0, 240.0),
  HealthMetric.glucose: (1.0, 35.0),
  HealthMetric.temperature: (33.0, 43.0),
  HealthMetric.spo2: (50.0, 100.0),
  HealthMetric.sleep: (0.0, 24.0),
  HealthMetric.water: (0.0, 30.0),
  HealthMetric.fetalMovement: (0.0, 200.0),
};

class HealthLogForm extends ConsumerStatefulWidget {
  const HealthLogForm({super.key, this.initial = HealthMetric.bloodPressure});

  final HealthMetric initial;

  @override
  ConsumerState<HealthLogForm> createState() => _HealthLogFormState();
}

class _HealthLogFormState extends ConsumerState<HealthLogForm> {
  final _formKey = GlobalKey<FormState>();
  final _value = TextEditingController();
  final _secondary = TextEditingController();
  final _note = TextEditingController();
  late HealthMetric _metric = widget.initial;

  @override
  void dispose() {
    _value.dispose();
    _secondary.dispose();
    _note.dispose();
    super.dispose();
  }

  String? _validate(String? raw, HealthMetric metric) {
    final l = context.l10n;
    if (raw == null || raw.trim().isEmpty) return l.required;
    final v = double.tryParse(raw.trim().replaceAll(',', '.'));
    final (min, max) = _bounds[metric]!;
    if (v == null || v < min || v > max) return l.invalidNumber;
    return null;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    double parse(TextEditingController c) =>
        double.parse(c.text.trim().replaceAll(',', '.'));
    final isBp = _metric == HealthMetric.bloodPressure;
    ref
        .read(healthLogProvider.notifier)
        .add(
          HealthLogEntry(
            id: newId(),
            metric: _metric,
            time: DateTime.now(),
            value: parse(_value),
            secondary: isBp ? parse(_secondary) : null,
            note: _note.text.trim().isEmpty ? null : _note.text.trim(),
          ),
        );
    showSavedSnack(context, context.l10n.saved);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final isBp = _metric == HealthMetric.bloodPressure;
    final numberInput = [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))];
    return Scaffold(
      appBar: AppBar(title: Text(l.healthLogTitle)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(l.measurement, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final m in loggableMetrics)
                  ChoiceChip(
                    label: Text(l.metric(m)),
                    selected: m == _metric,
                    onSelected: (_) => setState(() => _metric = m),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            if (_metric == HealthMetric.fetalMovement) ...[
              _KickCounter(),
              const SizedBox(height: 16),
            ],
            if (isBp)
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _value,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: numberInput,
                      decoration: InputDecoration(labelText: l.systolic),
                      validator: (v) => _validate(v, _metric),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _secondary,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: numberInput,
                      decoration: InputDecoration(labelText: l.diastolic),
                      validator: (v) => _validate(v, _metric),
                    ),
                  ),
                ],
              )
            else
              TextFormField(
                key: ValueKey(_metric),
                controller: _value,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: numberInput,
                decoration: InputDecoration(
                  labelText: l.valueWithUnit(_metric.unit),
                ),
                validator: (v) => _validate(v, _metric),
              ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _note,
              maxLines: 2,
              decoration: InputDecoration(labelText: l.noteOptional),
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _save, child: Text(l.save)),
          ],
        ),
      ),
    );
  }
}

/// One-tap kick logging, carried over from the prototype's movement diary.
class _KickCounter extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final count = ref
        .watch(todayTotalProvider(HealthMetric.fetalMovement))
        .round();
    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Text(
              l.kicksToday(count),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          FilledButton.tonalIcon(
            onPressed: () => ref
                .read(healthLogProvider.notifier)
                .add(
                  HealthLogEntry(
                    id: newId(),
                    metric: HealthMetric.fetalMovement,
                    time: DateTime.now(),
                    value: 1,
                  ),
                ),
            icon: const Icon(Icons.add),
            label: Text(l.quickKick),
          ),
        ],
      ),
    );
  }
}
