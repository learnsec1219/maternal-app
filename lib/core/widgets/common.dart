import 'package:flutter/material.dart';

import '../util/l10n.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(4, 20, 4, 10),
    child: Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        ?trailing,
      ],
    ),
  );
}

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.color,
    this.padding = const EdgeInsets.all(18),
    this.onTap,
  });

  final Widget child;
  final Color? color;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Card(
    color: color,
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Padding(padding: padding, child: child),
    ),
  );
}

/// Small pill used for statuses. Always carries text so meaning never
/// depends on colour alone.
class StatusPill extends StatelessWidget {
  const StatusPill(this.text, {super.key, required this.fg, required this.bg});

  final String text;
  final Color fg;
  final Color bg;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(99),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: fg),
    ),
  );
}

/// Read-only field that opens a date picker.
class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.firstDate,
    required this.lastDate,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final DateTime firstDate;
  final DateTime lastDate;

  @override
  Widget build(BuildContext context) {
    final v = value;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: v ?? DateTime.now().clamp(firstDate, lastDate),
          firstDate: firstDate,
          lastDate: lastDate,
          helpText: label,
        );
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20),
        ),
        child: Text(
          v == null ? context.l10n.selectDate : context.formatDate(v),
        ),
      ),
    );
  }
}

extension on DateTime {
  DateTime clamp(DateTime min, DateTime max) =>
      isBefore(min) ? min : (isAfter(max) ? max : this);
}

void showSavedSnack(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
    );
}
