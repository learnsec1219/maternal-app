import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/util/clock.dart';
import '../../../core/util/dates.dart';
import '../../../core/util/ids.dart';
import '../../../core/util/l10n.dart';
import '../../../core/util/labels.dart';
import '../../../core/widgets/common.dart';
import '../application/cycle_controller.dart';
import '../domain/period_entry.dart';

class PeriodForm extends ConsumerStatefulWidget {
  const PeriodForm({super.key, this.initialStart});

  final DateTime? initialStart;

  @override
  ConsumerState<PeriodForm> createState() => _PeriodFormState();
}

class _PeriodFormState extends ConsumerState<PeriodForm> {
  late DateTime _start = widget.initialStart ?? ref.read(todayProvider);
  DateTime? _end;
  FlowLevel _flow = FlowLevel.medium;
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  bool get _endInvalid => _end != null && daysBetween(_start, _end!) < 0;

  void _save() {
    if (_endInvalid) return;
    ref
        .read(periodsProvider.notifier)
        .add(
          PeriodEntry(
            id: newId(),
            start: dateOnly(_start),
            end: _end == null ? null : dateOnly(_end!),
            flow: _flow,
            note: _note.text.trim().isEmpty ? null : _note.text.trim(),
          ),
        );
    showSavedSnack(context, context.l10n.saved);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final today = ref.watch(todayProvider);
    final first = DateTime(today.year - 2);
    return Scaffold(
      appBar: AppBar(title: Text(l.periodTitle)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DateField(
            label: l.periodStart,
            value: _start,
            firstDate: first,
            lastDate: today,
            onChanged: (d) => setState(() => _start = d),
          ),
          const SizedBox(height: 16),
          DateField(
            label: l.periodEnd,
            value: _end,
            firstDate: first,
            lastDate: today,
            onChanged: (d) => setState(() => _end = d),
          ),
          if (_endInvalid)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 12),
              child: Text(
                l.endBeforeStart,
                style: const TextStyle(color: AppColors.danger, fontSize: 12),
              ),
            ),
          const SizedBox(height: 20),
          Text(l.flow, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 10),
          SegmentedButton<FlowLevel>(
            segments: [
              for (final f in FlowLevel.values)
                ButtonSegment(value: f, label: Text(l.flowLabel(f))),
            ],
            selected: {_flow},
            showSelectedIcon: false,
            onSelectionChanged: (s) => setState(() => _flow = s.first),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _note,
            maxLines: 2,
            decoration: InputDecoration(labelText: l.noteOptional),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _endInvalid ? null : _save,
            child: Text(l.save),
          ),
        ],
      ),
    );
  }
}
