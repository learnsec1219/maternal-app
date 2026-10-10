import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/util/ids.dart';
import '../../../core/util/l10n.dart';
import '../../../core/util/labels.dart';
import '../../../core/widgets/common.dart';
import '../application/health_log_controller.dart';
import '../domain/health_log.dart';
import '../domain/symptoms.dart';

/// Records a symptom. Warning symptoms show predefined guidance to seek care;
/// nothing here diagnoses.
class SymptomForm extends ConsumerStatefulWidget {
  const SymptomForm({super.key});

  @override
  ConsumerState<SymptomForm> createState() => _SymptomFormState();
}

class _SymptomFormState extends ConsumerState<SymptomForm> {
  SymptomKind? _selected;
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  void _save() {
    final s = _selected;
    if (s == null) return;
    ref
        .read(healthLogProvider.notifier)
        .add(
          HealthLogEntry(
            id: newId(),
            metric: HealthMetric.symptom,
            time: DateTime.now(),
            label: s.name,
            note: _note.text.trim().isEmpty ? null : _note.text.trim(),
          ),
        );
    showSavedSnack(context, context.l10n.symptomLogged);
    Navigator.of(context).pop();
  }

  Widget _chips(List<SymptomKind> kinds) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (final s in kinds)
        ChoiceChip(
          label: Text(context.l10n.symptom(s)),
          selected: _selected == s,
          onSelected: (_) => setState(() => _selected = s),
        ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final action = _selected == null ? null : l.symptomAction(_selected!);
    return Scaffold(
      appBar: AppBar(title: Text(l.symptomTitle)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l.symptomCommon, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 10),
          _chips(SymptomKind.values.where((s) => !s.warning).toList()),
          const SizedBox(height: 20),
          Text(
            l.symptomWarning,
            style: Theme.of(context).textTheme.labelLarge
                ?.copyWith(color: AppColors.danger),
          ),
          const SizedBox(height: 10),
          _chips(SymptomKind.warnings),
          if (action != null) ...[
            const SizedBox(height: 16),
            AppCard(
              color: AppColors.dangerBg,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.danger,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      action,
                      style: const TextStyle(
                        color: AppColors.danger,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          TextField(
            controller: _note,
            maxLines: 2,
            decoration: InputDecoration(labelText: l.noteOptional),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _selected == null ? null : _save,
            child: Text(l.save),
          ),
        ],
      ),
    );
  }
}
