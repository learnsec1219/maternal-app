import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../util/l10n.dart';
import 'common.dart';

/// Tappable box that opens the date picker; the label sits above it.
class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.firstDate,
    required this.lastDate,
    this.helper,
    this.error,
    this.placeholder,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final DateTime firstDate, lastDate;
  final String? helper, error, placeholder;

  @override
  Widget build(BuildContext context) => LabeledField(
    label: label,
    helper: helper,
    error: error,
    child: _PickerBox(
      text: value == null
          ? (placeholder ?? '—')
          : context.formatLongDate(value!),
      muted: value == null,
      icon: Icons.calendar_today_outlined,
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value == null
              ? (DateTime.now().isAfter(lastDate)
                    ? lastDate
                    : (DateTime.now().isBefore(firstDate)
                          ? firstDate
                          : DateTime.now()))
              : value!,
          firstDate: firstDate,
          lastDate: lastDate,
        );
        if (picked != null) onChanged(picked);
      },
    ),
  );
}

class TimeField extends StatelessWidget {
  const TimeField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final TimeOfDay value;
  final ValueChanged<TimeOfDay> onChanged;

  @override
  Widget build(BuildContext context) => LabeledField(
    label: label,
    child: _PickerBox(
      text: value.format(context),
      icon: Icons.schedule_rounded,
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: value,
        );
        if (picked != null) onChanged(picked);
      },
    ),
  );
}

class _PickerBox extends StatelessWidget {
  const _PickerBox({
    required this.text,
    required this.icon,
    required this.onTap,
    this.muted = false,
  });

  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    return Material(
      color: p.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: p.line),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                    color: muted ? p.muted : p.ink,
                  ),
                ),
              ),
              Icon(icon, size: 20, color: p.muted),
            ],
          ),
        ),
      ),
    );
  }
}
