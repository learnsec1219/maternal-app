import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import '../../core/util/labels.dart';
import '../../core/widgets/common.dart';
import '../pregnancy/domain/gestation.dart';

/// Placeholder patient used until the clinic backend exists.
class _DemoPatient {
  const _DemoPatient(this.id, this.name, this.phone, this.dueDate, this.alert);

  final String id;
  final String name;
  final String phone;
  final DateTime? dueDate;
  final bool alert;
}

/// Doctor / admin home. Uses fictional demo data; real patient records will
/// come from the backend with role-based access control.
class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  String _query = '';

  static final _now = DateTime.now();
  static final _patients = [
    _DemoPatient(
      'P-1001',
      'Demo Patient A',
      '012-000 0001',
      _now.add(const Duration(days: 52)),
      true,
    ),
    _DemoPatient(
      'P-1002',
      'Demo Patient B',
      '012-000 0002',
      _now.add(const Duration(days: 160)),
      false,
    ),
    _DemoPatient(
      'P-1003',
      'Demo Patient C',
      '012-000 0003',
      _now.add(const Duration(days: 230)),
      false,
    ),
    const _DemoPatient('P-1004', 'Demo Patient D', '012-000 0004', null, false),
  ];

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final q = _query.toLowerCase();
    final matches = _patients
        .where(
          (p) =>
              q.isEmpty ||
              p.name.toLowerCase().contains(q) ||
              p.id.toLowerCase().contains(q) ||
              p.phone.replaceAll(' ', '').contains(q.replaceAll(' ', '')),
        )
        .toList();

    Widget stat(String label, String value, IconData icon) => Expanded(
      child: AppCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.roseDeep),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            Text(
              label,
              maxLines: 2,
              style: const TextStyle(fontSize: 12, color: AppColors.muted),
            ),
          ],
        ),
      ),
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
      children: [
        Row(
          children: [
            stat(l.totalPatients, '${_patients.length}', Icons.groups_outlined),
            const SizedBox(width: 10),
            stat(l.todaysAppointments, '2', Icons.event_outlined),
            const SizedBox(width: 10),
            stat(
              l.alertsToReview,
              '${_patients.where((p) => p.alert).length}',
              Icons.notification_important_outlined,
            ),
          ],
        ),
        SectionTitle(l.patients),
        TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: l.searchPatients,
          ),
          onChanged: (v) => setState(() => _query = v.trim()),
        ),
        const SizedBox(height: 10),
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            children: [
              if (matches.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(l.noMatches),
                ),
              for (final p in matches)
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.roseSoft,
                    child: Icon(Icons.person, color: AppColors.roseDeep),
                  ),
                  title: Text(p.name),
                  subtitle: Text(_subtitle(context, p)),
                  trailing: p.alert
                      ? const StatusPill(
                          '!',
                          fg: AppColors.danger,
                          bg: AppColors.dangerBg,
                        )
                      : null,
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            l.doctorDemoNote,
            style: const TextStyle(fontSize: 12, color: AppColors.muted),
          ),
        ),
      ],
    );
  }

  String _subtitle(BuildContext context, _DemoPatient p) {
    final l = context.l10n;
    final due = p.dueDate;
    if (due == null) return '${p.id} · ${p.phone}';
    final g = Gestation.fromDueDate(due, today: DateTime.now());
    return '${p.id} · ${l.weeksDays(g.weeks, g.days)} · ${l.trimester(g.trimester)}';
  }
}
