import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/content/clinical_content.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/clock.dart';
import '../../core/util/dates.dart';
import '../../core/util/l10n.dart';
import '../../core/util/labels.dart';
import '../../core/widgets/charts.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../../data/models.dart';
import '../../domain/health_rules.dart';
import '../calendar/calendar_screen.dart';
import '../home/home_screen.dart';
import '../patient/patient_data.dart';
import '../profile/profile_screen.dart';
import '../profile/settings_pages.dart';
import '../shell/patient_shell.dart';

/// Every time the doctor opens a patient record (kept for this session).
final accessLogProvider = NotifierProvider<AccessLog, List<(String, DateTime)>>(
  AccessLog.new,
);

class AccessLog extends Notifier<List<(String, DateTime)>> {
  @override
  List<(String, DateTime)> build() => const [];
  void add(String id) => state = [...state, (id, DateTime.now())];
}

class _Alert {
  _Alert(this.personId, this.at, this.text);
  final String personId;
  final DateTime at;
  final String text;
}

List<_Alert> _alerts(
  BuildContext context,
  DemoData d,
  ClinicalContent c,
  DateTime today,
) {
  final l = context.l10n, since = addDays(today, -7), out = <_Alert>[];
  for (final e in d.links.entries) {
    if (e.value != LinkState.active) continue;
    for (final o in d.obs) {
      if (o.personId != e.key || o.at.isBefore(since)) continue;
      final r = rangeOf(o, c);
      if (r == RangeClass.above || r == RangeClass.below) {
        out.add(
          _Alert(e.key, o.at, '${l.obs(o.type)}: ${obsValue(context, o)}'),
        );
      }
    }
    for (final s in d.symptoms) {
      if (s.personId == e.key && s.warning && !s.at.isBefore(since)) {
        out.add(
          _Alert(
            e.key,
            s.at,
            l.alertWarningSign(c.symptomLabel(s.code, context.lang)),
          ),
        );
      }
    }
  }
  return out..sort((a, b) => b.at.compareTo(a.at));
}

String _statusLine(
  BuildContext context,
  Profile p,
  DateTime today,
  ClinicalContent c,
) {
  final l = context.l10n;
  final pr = PregnancyStatus.of(p, today, c);
  return pr != null && pr.check == DueCheck.ok
      ? '${l.gaText(pr.gaDays)} · ${l.dueOn(context.formatDate(pr.due))}'
      : journeyLabel(l, p.journey);
}

void _openPatient(BuildContext context, WidgetRef ref, String id) {
  ref.read(accessLogProvider.notifier).add(id);
  pushPage(context, DoctorPatientPage(personId: id));
}

class DoctorShell extends ConsumerWidget {
  const DoctorShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final tab = ref.watch(doctorTabProvider);
    void go(int i) => ref.read(doctorTabProvider.notifier).set(i);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: tab,
          children: const [
            _Dashboard(),
            _Patients(),
            _Appointments(),
            _DoctorProfile(),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        color: p.card,
        child: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: p.line)),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 66,
              child: Row(
                children: [
                  NavItem(
                    Icons.grid_view_outlined,
                    Icons.grid_view_rounded,
                    l.doctorNavDashboard,
                    tab == 0,
                    () => go(0),
                    key: const Key('dnav-dash'),
                  ),
                  NavItem(
                    Icons.groups_outlined,
                    Icons.groups_rounded,
                    l.doctorNavPatients,
                    tab == 1,
                    () => go(1),
                    key: const Key('dnav-patients'),
                  ),
                  NavItem(
                    Icons.event_outlined,
                    Icons.event_rounded,
                    l.appointmentsTitle,
                    tab == 2,
                    () => go(2),
                    key: const Key('dnav-appts'),
                  ),
                  NavItem(
                    Icons.person_outline_rounded,
                    Icons.person_rounded,
                    l.navProfile,
                    tab == 3,
                    () => go(3),
                    key: const Key('dnav-profile'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Dashboard extends ConsumerWidget {
  const _Dashboard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final d = ref.watch(demoStoreProvider);
    final c = ref.watch(contentProvider);
    final today = ref.watch(todayProvider);
    final alerts = _alerts(context, d, c, today);
    final active = d.links.entries
        .where((e) => e.value == LinkState.active)
        .length;
    final pending = d.links.entries
        .where((e) => e.value == LinkState.pending)
        .map((e) => e.key)
        .toList();
    final todays =
        d.appointments
            .where(
              (a) =>
                  d.links[a.personId] == LinkState.active &&
                  isSameDay(a.at, today),
            )
            .toList()
          ..sort((a, b) => a.at.compareTo(b.at));
    Widget tile(String label, int n, Color bg, [VoidCallback? onTap]) =>
        Material(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$n',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(label, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ),
        );
    return Column(
      children: [
        TabTitleBar(title: l.doctorNavDashboard),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              Text(
                l.doctorGreeting(DemoDoctor.name),
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(DemoDoctor.clinic, style: TextStyle(color: p.muted)),
              const SizedBox(height: 12),
              TwoColumn(
                children: [
                  tile(
                    l.statTotalPatients,
                    active,
                    p.sage,
                    () => ref.read(doctorTabProvider.notifier).set(1),
                  ),
                  tile(l.statTodaysAppointments, todays.length, p.sky),
                  tile(l.statNewRequests, pending.length, p.peach),
                  tile(
                    l.statAlerts,
                    alerts.length,
                    alerts.isEmpty ? p.sand : p.alertSoft,
                  ),
                ],
              ),
              if (pending.isNotEmpty) ...[
                SectionHeader(l.statNewRequests),
                for (final id in pending)
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          d.profiles[id]!.name,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          _statusLine(context, d.profiles[id]!, today, c),
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            FilledButton(
                              onPressed: () => ref
                                  .read(demoStoreProvider.notifier)
                                  .setLink(id, LinkState.active),
                              child: Text(l.actionAccept),
                            ),
                            OutlinedButton(
                              onPressed: () => ref
                                  .read(demoStoreProvider.notifier)
                                  .setLink(id, LinkState.revoked),
                              child: Text(l.actionDecline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
              SectionHeader(l.alertsToReview),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  l.alertsExplainer(7),
                  style: TextStyle(fontSize: 12.5, color: p.muted),
                ),
              ),
              if (alerts.isEmpty)
                AppCard(child: EmptyNote(l.alertsNone))
              else
                ListCard(
                  rows: [
                    for (final a in alerts.take(8))
                      ListRow(
                        leading: Icon(
                          Icons.warning_amber_rounded,
                          color: p.alert,
                        ),
                        title: d.profiles[a.personId]!.name,
                        subtitle: '${a.text}\n${context.formatDateTime(a.at)}',
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => _openPatient(context, ref, a.personId),
                      ),
                  ],
                ),
              SectionHeader(l.statTodaysAppointments),
              if (todays.isEmpty)
                AppCard(child: EmptyNote(l.appointmentsNoneToday))
              else
                ListCard(
                  rows: [
                    for (final a in todays)
                      ListRow(
                        leading: Text(
                          context.formatTime(a.at),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        title: d.profiles[a.personId]!.name,
                        subtitle: a.purpose,
                        onTap: () => _openPatient(context, ref, a.personId),
                      ),
                  ],
                ),
              InfoBanner(l.demoModeBody, title: l.demoModeTitle),
            ],
          ),
        ),
      ],
    );
  }
}

class _Patients extends ConsumerStatefulWidget {
  const _Patients();

  @override
  ConsumerState<_Patients> createState() => _PatientsState();
}

class _PatientsState extends ConsumerState<_Patients> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    final d = ref.watch(demoStoreProvider);
    final c = ref.watch(contentProvider);
    final today = ref.watch(todayProvider);
    final alerts = _alerts(context, d, c, today);
    final q = _q.toLowerCase();
    final list =
        [
            for (final e in d.links.entries)
              if (e.value != LinkState.revoked) (d.profiles[e.key]!, e.value),
          ].where((x) {
            final pr = x.$1;
            return q.isEmpty ||
                [
                  pr.name,
                  pr.id,
                  pr.phone ?? '',
                  pr.due == null ? '' : context.formatDate(pr.due!),
                ].join(' ').toLowerCase().contains(q);
          }).toList()
          ..sort((a, b) => a.$1.name.compareTo(b.$1.name));
    return Column(
      children: [
        TabTitleBar(title: l.doctorNavPatients),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              TextField(
                onChanged: (v) => setState(() => _q = v),
                decoration: InputDecoration(
                  hintText: l.patientSearchHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
              ),
              const SizedBox(height: 12),
              if (list.isEmpty) EmptyNote(l.patientSearchEmpty),
              for (final (pt, st) in list)
                AppCard(
                  padding: const EdgeInsets.all(12),
                  onTap: st == LinkState.active
                      ? () => _openPatient(context, ref, pt.id)
                      : null,
                  child: Row(
                    children: [
                      Avatar(pt.name),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pt.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              _statusLine(context, pt, today, c),
                              style: const TextStyle(fontSize: 13),
                            ),
                            Text(
                              'ID ${pt.id}${pt.phone == null ? '' : ' · ${pt.phone}'}',
                              style: TextStyle(fontSize: 12.5, color: p.muted),
                            ),
                          ],
                        ),
                      ),
                      if (st == LinkState.pending)
                        Pill(l.filterPending, background: p.peach)
                      else if (alerts.any((a) => a.personId == pt.id))
                        Pill(
                          l.alertCount(
                            alerts.where((a) => a.personId == pt.id).length,
                          ),
                          background: p.alertSoft,
                          foreground: p.alert,
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Appointments extends ConsumerWidget {
  const _Appointments();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final d = ref.watch(demoStoreProvider);
    final c = ref.watch(contentProvider);
    final today = ref.watch(todayProvider);
    final now = DateTime.now();
    final up =
        d.appointments
            .where(
              (a) =>
                  d.links[a.personId] == LinkState.active && a.at.isAfter(now),
            )
            .toList()
          ..sort((a, b) => a.at.compareTo(b.at));
    return Column(
      children: [
        TabTitleBar(title: l.appointmentsTitle),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              if (up.isEmpty) EmptyNote(l.appointmentsNoneUpcoming),
              for (final (i, a) in up.indexed) ...[
                if (i == 0 || !isSameDay(up[i - 1].at, a.at))
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 10, 2, 6),
                    child: Text(
                      context.formatWeekdayDate(a.at),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                AppCard(
                  padding: const EdgeInsets.all(12),
                  onTap: () => _openPatient(context, ref, a.personId),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 72,
                        child: Text(
                          context.formatTime(a.at),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              d.profiles[a.personId]!.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(a.purpose),
                            Text(
                              _statusLine(
                                context,
                                d.profiles[a.personId]!,
                                today,
                                c,
                              ),
                              style: TextStyle(fontSize: 12.5, color: p.muted),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _DoctorProfile extends ConsumerWidget {
  const _DoctorProfile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final log = ref.watch(accessLogProvider).reversed.take(15).toList();
    return Column(
      children: [
        TabTitleBar(title: l.navProfile),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              AppCard(
                color: p.roseTint,
                child: Column(
                  children: [
                    const Avatar(DemoDoctor.name, size: 80),
                    const SizedBox(height: 8),
                    const Text(
                      DemoDoctor.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(DemoDoctor.clinic, style: TextStyle(color: p.muted)),
                  ],
                ),
              ),
              AppCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoRow(l.fieldFullName, DemoDoctor.name, first: true),
                    InfoRow(l.fieldMmcNumber, DemoDoctor.mmc),
                    InfoRow(l.fieldClinic, DemoDoctor.clinic),
                    InfoRow(l.fieldPhone, DemoDoctor.phone),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: p.line)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              l.verificationStatus,
                              style: TextStyle(fontSize: 12.5, color: p.muted),
                            ),
                          ),
                          Pill(
                            l.verified,
                            background: p.goodSoft,
                            foreground: p.good,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SectionHeader(l.menuAppearance),
              const AppearancePicker(),
              SectionHeader(l.accessLogTitle),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  l.accessLogExplainer,
                  style: TextStyle(fontSize: 12.5, color: p.muted),
                ),
              ),
              if (log.isEmpty)
                AppCard(child: EmptyNote(l.nothingLogged))
              else
                ListCard(
                  rows: [
                    for (final (id, at) in log)
                      ListRow(
                        title: l.accessLogViewed(id),
                        trailing: Text(
                          context.formatDateTime(at),
                          style: TextStyle(fontSize: 12, color: p.muted),
                        ),
                      ),
                  ],
                ),
              const SignOutButton(),
            ],
          ),
        ),
      ],
    );
  }
}

/// One patient's record: summary, timeline, growth and vitals.
class DoctorPatientPage extends ConsumerStatefulWidget {
  const DoctorPatientPage({super.key, required this.personId});
  final String personId;

  @override
  ConsumerState<DoctorPatientPage> createState() => _DoctorPatientPageState();
}

class _DoctorPatientPageState extends ConsumerState<DoctorPatientPage> {
  int _tab = 0;
  ObsType? _vital;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    final d = ref.watch(demoStoreProvider);
    final c = ref.watch(contentProvider);
    final today = ref.watch(todayProvider);
    final id = widget.personId;
    final pt = d.profiles[id]!;
    final pr = PregnancyStatus.of(pt, today, c);
    final obs = d.of(d.obs, id)..sort((a, b) => b.at.compareTo(a.at));
    final scans = d.of(d.scans, id)
      ..sort((a, b) => a.gaDays.compareTo(b.gaDays));

    Widget card(List<(String, String?)> rows) => AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          for (final (i, (a, b)) in rows.indexed) InfoRow(a, b, first: i == 0),
        ],
      ),
    );

    final body = <Widget>[];
    if (_tab == 0) {
      String? age;
      if (pt.dob != null) {
        var a = today.year - pt.dob!.year;
        if (today.isBefore(DateTime(today.year, pt.dob!.month, pt.dob!.day))) {
          a--;
        }
        age = '${context.formatDate(pt.dob!)} (${l.ageYears(a)})';
      }
      final meds = d
          .of(d.meds, id)
          .map((m) => '${m.name} ${m.dose} (${m.times.join(', ')})')
          .join('\n');
      body.addAll([
        card([
          (l.fieldFullName, pt.name),
          (l.patientId, pt.id),
          (l.fieldDateOfBirth, age),
          (l.fieldPhone, pt.phone),
          (l.menuEmergencyContact, pt.emergency),
        ]),
        SectionHeader(journeyLabel(l, pt.journey)),
        card([
          if (pr != null) ...[
            (l.fieldDueDate, context.formatLongDate(pr.due)),
            (
              l.colGestation,
              pr.check == DueCheck.ok
                  ? l.gaText(pr.gaDays)
                  : l.dueDateInvalidTitle,
            ),
            (l.trimesterLabel, l.trimester(pr.trimester)),
            (l.fieldNumberOfBabies, l.babyCount(pr.babies)),
          ],
          (l.gravidaPara, pt.gp),
        ]),
        SectionHeader(l.clinicalSummary),
        card([
          (l.fieldBloodGroup, pt.blood),
          (l.fieldAllergies, pt.allergies),
          (l.fieldMedicalHistory, pt.history),
          (l.medicationsTitle, meds),
          (l.riskFactors, pt.risks),
        ]),
      ]);
    } else if (_tab == 1) {
      final e = <(DateTime, IconData, String, String)>[
        for (final o in obs.take(40))
          (o.at, obsStyle(o.type).icon, l.obs(o.type), obsValue(context, o)),
        for (final s in scans)
          (s.date, Icons.insights_rounded, s.type, l.gaText(s.gaDays)),
        for (final a in d.of(d.appointments, id))
          (a.at, Icons.event_outlined, a.purpose, a.doctor),
        for (final v in d.of(d.vaccines, id))
          (v.date, Icons.vaccines_outlined, v.name, l.vaccineGiven),
        for (final doc in d.of(d.documents, id))
          (
            doc.date,
            Icons.description_outlined,
            doc.title,
            l.docCategory(doc.category),
          ),
        for (final s in d.of(d.symptoms, id))
          (
            s.at,
            s.warning ? Icons.warning_amber_rounded : Icons.healing_outlined,
            c.symptomLabel(s.code, context.lang),
            '',
          ),
      ]..sort((a, b) => b.$1.compareTo(a.$1));
      if (e.isEmpty) body.add(EmptyNote(l.nothingLogged));
      for (final (i, x) in e.indexed) {
        if (i == 0 || !isSameDay(e[i - 1].$1, x.$1)) {
          body.add(
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
              child: Text(
                context.formatDate(x.$1),
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          );
        }
        body.add(
          ListRow(
            divider: false,
            leading: Icon(x.$2, color: p.rose),
            title: x.$3,
            subtitle: x.$4.isEmpty ? null : x.$4,
            trailing: Text(
              context.formatTime(x.$1),
              style: TextStyle(fontSize: 12, color: p.muted),
            ),
          ),
        );
      }
    } else if (_tab == 2) {
      if (scans.isEmpty) {
        body.add(EmptyNote(l.growthNoScans));
      } else {
        const cols = ['efw', 'bpd', 'hc', 'ac', 'fl', 'afi', 'crl', 'fhr'];
        body.addAll([
          SectionHeader(l.growthCompareScans),
          AppCard(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 14,
                headingRowHeight: 40,
                columns: [
                  DataColumn(label: Text(l.colScan)),
                  DataColumn(label: Text(l.colGestation)),
                  for (final k in cols)
                    DataColumn(label: Text(k.toUpperCase()), numeric: true),
                ],
                rows: [
                  for (final s in scans)
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            '${s.type}\n${context.formatDate(s.date)}',
                            style: const TextStyle(fontSize: 12.5),
                          ),
                        ),
                        DataCell(Text('${s.gaDays ~/ 7}+${s.gaDays % 7}')),
                        for (final k in cols)
                          DataCell(
                            Text(
                              s.measures[k] == null
                                  ? '—'
                                  : context.formatNumber(
                                      s.measures[k]!,
                                      k == 'afi' ? 1 : 0,
                                    ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          BabySection(scans: scans),
        ]);
      }
    } else {
      final types = <ObsType>{for (final o in obs) o.type}.toList();
      final k = types.contains(_vital)
          ? _vital
          : (types.isEmpty ? null : types.first);
      if (k == null) {
        body.add(EmptyNote(l.noReadingsYet));
      } else {
        final from = addDays(today, -29);
        final rr = obs
            .where((o) => o.type == k && !o.at.isBefore(from))
            .toList();
        final bandKey = {
          ObsType.bp: 'systolic',
          ObsType.hr: 'heart_rate',
          ObsType.spo2: 'spo2',
        }[k];
        final band = bandKey == null ? null : c.ranges[bandKey];
        body.addAll([
          ChoiceChips<ObsType>(
            options: [for (final t in types) (t, l.obs(t))],
            selected: k,
            onSelected: (t) => setState(() => _vital = t),
          ),
          if (rr.isNotEmpty)
            AppCard(
              child: LineChart(
                points: [
                  for (final o in rr)
                    ChartPoint(
                      daysBetween(from, o.at).toDouble(),
                      o.value,
                      context.formatShortDate(o.at),
                    ),
                ],
                second: k == ObsType.bp
                    ? [
                        for (final o in rr)
                          if (o.value2 != null)
                            ChartPoint(
                              daysBetween(from, o.at).toDouble(),
                              o.value2!,
                            ),
                      ]
                    : null,
                band: band == null ? null : (band.low, band.high),
              ),
            ),
          ListCard(
            rows: [
              for (final o in obs.where((o) => o.type == k).take(15))
                ListRow(
                  title: obsValue(context, o),
                  subtitle: context.formatDateTime(o.at),
                  trailing: rangePill(context, rangeOf(o, c)),
                ),
            ],
          ),
        ]);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(pt.name)),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            UnderlineTabs(
              labels: [l.tabSummary, l.tabTimeline, l.tabGrowth, l.tabVitals],
              index: _tab,
              onChanged: (i) => setState(() => _tab = i),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                children: body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
