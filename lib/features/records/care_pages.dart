import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/content/clinical_content.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/clock.dart';
import '../../core/util/dates.dart';
import '../../core/util/l10n.dart';
import '../../core/util/labels.dart';
import '../../core/util/phone.dart';
import '../../core/widgets/common.dart';
import '../../core/widgets/date_field.dart';
import '../../data/demo_store.dart';
import '../../data/models.dart';
import '../patient/patient_data.dart';

/// Date and time on the left, purpose, doctor and clinic on the right.
class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
    this.highlight = false,
  });
  final Appointment appointment;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final p = context.pal, a = appointment;
    return AppCard(
      color: highlight ? p.sage : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 64,
            child: Column(
              children: [
                Text(
                  context.formatShortDate(a.at),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                Text(
                  context.formatTime(a.at),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12.5),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  a.purpose,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(a.doctor),
                Text(
                  a.clinic,
                  style: TextStyle(fontSize: 12.5, color: p.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentFormPage extends ConsumerStatefulWidget {
  const AppointmentFormPage({super.key, this.day, this.purpose});
  final DateTime? day;
  final String? purpose;

  @override
  ConsumerState<AppointmentFormPage> createState() =>
      _AppointmentFormPageState();
}

class _AppointmentFormPageState extends ConsumerState<AppointmentFormPage> {
  final _doctor = TextEditingController(text: DemoDoctor.name);
  final _clinic = TextEditingController(text: DemoDoctor.clinic);
  late final _purpose = TextEditingController(text: widget.purpose ?? '');
  late DateTime _date = widget.day ?? addDays(ref.read(todayProvider), 1);
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0);
  String? _error;

  @override
  void dispose() {
    _doctor.dispose();
    _clinic.dispose();
    _purpose.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final today = ref.watch(todayProvider);
    return PageScaffold(
      title: l.addAppointmentTitle,
      bottom: PrimaryButton(
        l.actionSave,
        key: const Key('appointment-save'),
        onPressed: () {
          if (_doctor.text.trim().isEmpty || _clinic.text.trim().isEmpty) {
            setState(() => _error = l.errorRequired);
            return;
          }
          ref
              .read(demoStoreProvider.notifier)
              .addAppointment(
                Appointment(
                  mineOf(ref).me.id,
                  DateTime(
                    _date.year,
                    _date.month,
                    _date.day,
                    _time.hour,
                    _time.minute,
                  ),
                  _doctor.text.trim(),
                  _clinic.text.trim(),
                  _purpose.text.trim().isEmpty
                      ? l.appointmentDefaultPurpose
                      : _purpose.text.trim(),
                ),
              );
          showToast(context, l.savedMessage);
          Navigator.pop(context, true);
        },
      ),
      children: [
        LabeledField(
          label: l.yourDoctors,
          child: Wrap(
            children: [
              SelectChip(
                label: DemoDoctor.name,
                selected: false,
                onTap: () => setState(() {
                  _doctor.text = DemoDoctor.name;
                  _clinic.text = DemoDoctor.clinic;
                }),
              ),
            ],
          ),
        ),
        AppTextField(label: l.fieldDoctor, controller: _doctor),
        AppTextField(label: l.fieldClinicHospital, controller: _clinic),
        DateField(
          label: l.fieldDate,
          value: _date,
          firstDate: addDays(today, -365),
          lastDate: addDays(today, 365 * 2),
          onChanged: (d) => setState(() => _date = d),
        ),
        TimeField(
          label: l.fieldTime,
          value: _time,
          onChanged: (t) => setState(() => _time = t),
        ),
        AppTextField(
          label: l.fieldPurpose,
          controller: _purpose,
          hint: l.purposeHint,
        ),
        if (_error != null) InfoBanner(_error!, tone: Tone.alert),
      ],
    );
  }
}

class AppointmentsPage extends ConsumerWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final m = mineOf(ref);
    final now = DateTime.now();
    final all = m.of(m.data.appointments);
    final up = all.where((a) => a.at.isAfter(now)).toList()
      ..sort((a, b) => a.at.compareTo(b.at));
    final past = all.where((a) => !a.at.isAfter(now)).toList()
      ..sort((a, b) => b.at.compareTo(a.at));
    return PageScaffold(
      title: l.appointmentsTitle,
      bottom: PrimaryButton(
        l.createAppointment,
        onPressed: () => pushPage(context, const AppointmentFormPage()),
      ),
      children: [
        SectionHeader(l.upcoming),
        if (up.isEmpty) EmptyNote(l.appointmentsNoneUpcoming),
        for (final a in up) AppointmentCard(appointment: a, highlight: true),
        SectionHeader(l.past),
        for (final a in past) AppointmentCard(appointment: a),
      ],
    );
  }
}

Widget vaxPill(BuildContext context, VaxState s) {
  final l = context.l10n, p = context.pal;
  return switch (s) {
    VaxState.given => Pill(
      l.vaccineGiven,
      icon: '✓',
      background: p.goodSoft,
      foreground: p.good,
    ),
    VaxState.due => Pill(
      l.vaccineDueNow,
      icon: '!',
      background: p.alertSoft,
      foreground: p.alert,
    ),
    VaxState.pending => Pill(
      l.vaccinePending,
      icon: '◷',
      background: p.pendingSoft,
      foreground: p.pending,
    ),
  };
}

/// Given (green), due now (red) and pending (yellow), in one list.
class VaccinesPage extends ConsumerWidget {
  const VaccinesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final items = vaxItemsFor(
      m,
      ref.watch(todayProvider),
      ref.watch(contentProvider),
      context.lang,
    );
    return PageScaffold(
      title: l.vaccinesTitle,
      children: [
        InfoBanner(l.contentPendingReview, tone: Tone.warn),
        SectionHeader(l.vaccineHistory),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final s in [VaxState.given, VaxState.due, VaxState.pending])
                vaxPill(context, s),
            ],
          ),
        ),
        if (items.isEmpty) EmptyNote(l.vaccineHistoryEmpty),
        for (final it in items)
          AppCard(
            onTap: it.state == VaxState.given
                ? null
                : () => pushPage(context, VaccineDetailPage(itemKey: it.key)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        it.name,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: 8),
                    vaxPill(context, it.state),
                  ],
                ),
                if (it.given != null)
                  Text(
                    l.vaccineGivenOn(context.formatDate(it.given!.date)) +
                        (it.given!.place == null || it.given!.place!.isEmpty
                            ? ''
                            : ' · ${it.given!.place}'),
                    style: TextStyle(fontSize: 12.5, color: p.muted),
                  )
                else if (it.schedule != null)
                  Text(
                    it.schedule!.window.of(context.lang),
                    style: TextStyle(fontSize: 12.5, color: p.muted),
                  ),
                if (it.state != VaxState.given)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        if (it.offer != null)
                          Text(
                            context.formatMoney(it.offer!.price),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        const Spacer(),
                        Flexible(
                          child: Text(
                            l.vaccineTapForDetails,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: p.rose,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded, color: p.rose),
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

class VaccineDetailPage extends ConsumerStatefulWidget {
  const VaccineDetailPage({super.key, required this.itemKey});
  final String itemKey;

  @override
  ConsumerState<VaccineDetailPage> createState() => _VaccineDetailPageState();
}

class _VaccineDetailPageState extends ConsumerState<VaccineDetailPage> {
  bool _read = false;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal, lang = context.lang;
    final m = mineOf(ref);
    final today = ref.watch(todayProvider);
    final items = vaxItemsFor(m, today, ref.watch(contentProvider), lang);
    final it = items.where((x) => x.key == widget.itemKey).firstOrNull;
    if (it == null) {
      return PageScaffold(
        title: l.vaccinesTitle,
        children: [EmptyNote(l.vaccineHistoryEmpty)],
      );
    }
    final o = it.offer;
    final desc = o != null && o.description.isNotEmpty
        ? o.description
        : it.schedule?.description.of(lang) ?? l.vaccineNoDescription;
    return PageScaffold(
      title: it.name,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: vaxPill(context, it.state),
        ),
        SectionHeader(l.vaccineWhatItDoes),
        AppCard(child: Text(desc, style: const TextStyle(height: 1.5))),
        if (it.schedule != null) ...[
          SectionHeader(l.vaccineWhen),
          AppCard(child: Text(it.schedule!.window.of(lang))),
        ],
        SectionHeader(l.vaccinePriceLabel),
        AppCard(
          color: p.roseTint,
          child: o == null
              ? Text(l.vaccinePriceUnknown)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.formatMoney(o.price),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(l.vaccinePriceAt(o.clinic)),
                    if (o.demo)
                      Text(
                        l.vaccineDemoPrice,
                        style: TextStyle(fontSize: 12.5, color: p.muted),
                      ),
                  ],
                ),
        ),
        Text(
          l.vaccineDoctorConfirms,
          style: TextStyle(fontSize: 12.5, color: p.muted, height: 1.5),
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: _read,
          onChanged: (v) => setState(() => _read = v ?? false),
          title: Text(l.vaccineConfirmRead),
        ),
        PrimaryButton(
          l.vaccineBook,
          onPressed: !_read
              ? null
              : () async {
                  final nav = Navigator.of(context);
                  final saved = await pushPage<bool>(
                    context,
                    AppointmentFormPage(purpose: l.vaccinationPurpose(it.name)),
                  );
                  if (saved == true) nav.pop();
                },
        ),
        if (!_read)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              l.vaccineBookHint,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.5, color: p.muted),
            ),
          ),
        const SizedBox(height: 10),
        GhostButton(
          l.vaccineAlreadyHad,
          onPressed: () {
            ref
                .read(demoStoreProvider.notifier)
                .addVaccine(
                  VaccineRecord(
                    m.me.id,
                    today,
                    it.name,
                    key: it.key,
                    place: o?.clinic,
                  ),
                );
            showToast(context, l.savedMessage);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class CareTeamPage extends ConsumerWidget {
  const CareTeamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final link = m.data.links[m.me.id];
    return PageScaffold(
      title: l.menuCareTeam,
      children: [
        InfoBanner(l.careTeamIntro),
        if (link == null || link == LinkState.revoked)
          EmptyNote(l.careTeamEmpty)
        else
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Avatar(DemoDoctor.name, size: 48),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            DemoDoctor.name,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const Text(DemoDoctor.clinic),
                          Text(
                            link == LinkState.active
                                ? l.linkActive
                                : l.linkPending,
                            style: TextStyle(fontSize: 12.5, color: p.muted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GhostButton(
                  l.callDoctor(DemoDoctor.name),
                  icon: Icons.call_rounded,
                  onPressed: () => callNumber(context, DemoDoctor.phone),
                ),
                const SizedBox(height: 4),
                Center(
                  child: SelectableText(
                    DemoDoctor.phone,
                    style: TextStyle(fontSize: 12.5, color: p.muted),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class DocumentsPage extends ConsumerStatefulWidget {
  const DocumentsPage({super.key});

  @override
  ConsumerState<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends ConsumerState<DocumentsPage> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final q = _q.trim().toLowerCase();
    final docs =
        m
            .of(m.data.documents)
            .where(
              (d) =>
                  q.isEmpty ||
                  '${d.title} ${d.description}'.toLowerCase().contains(q),
            )
            .toList()
          ..sort((a, b) => b.date.compareTo(a.date));
    return PageScaffold(
      title: l.documentsTitle,
      bottom: PrimaryButton(
        '+ ${l.createDocument}',
        onPressed: () => pushPage(context, const AddDocumentPage()),
      ),
      children: [
        LabeledField(
          label: l.documentSearchHint,
          child: TextField(
            onChanged: (v) => setState(() => _q = v),
            decoration: InputDecoration(
              hintText: l.documentSearchHint,
              prefixIcon: const Icon(Icons.search_rounded),
            ),
          ),
        ),
        if (docs.isEmpty)
          EmptyNote(q.isEmpty ? l.documentsEmpty : l.documentSearchEmpty),
        for (final d in docs)
          AppCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TileIcon(
                  Icons.description_outlined,
                  background: p.sand,
                  size: 42,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        d.title,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '${l.docCategory(d.category)} · ${context.formatDate(d.date)} · ${l.uploadedBy(d.by)}',
                        style: TextStyle(fontSize: 12.5, color: p.muted),
                      ),
                      if (d.description.isNotEmpty)
                        Text(
                          d.description,
                          style: const TextStyle(fontSize: 13),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        InfoBanner(l.documentStorageNote),
      ],
    );
  }
}

class AddDocumentPage extends ConsumerStatefulWidget {
  const AddDocumentPage({super.key});

  @override
  ConsumerState<AddDocumentPage> createState() => _AddDocumentPageState();
}

class _AddDocumentPageState extends ConsumerState<AddDocumentPage> {
  DocCategory _cat = DocCategory.bloodTest;
  final _title = TextEditingController(), _desc = TextEditingController();
  DateTime? _date;
  String? _error;

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final today = ref.watch(todayProvider);
    _date ??= today;
    return PageScaffold(
      title: l.addDocumentTitle,
      bottom: PrimaryButton(
        l.actionSave,
        onPressed: () {
          if (_title.text.trim().isEmpty) {
            setState(() => _error = l.errorRequired);
            return;
          }
          final me = mineOf(ref).me;
          ref
              .read(demoStoreProvider.notifier)
              .addDocument(
                MedicalDocument(
                  me.id,
                  _date!,
                  _cat,
                  _title.text.trim(),
                  description: _desc.text.trim(),
                  by: me.name,
                ),
              );
          showToast(context, l.savedMessage);
          Navigator.pop(context);
        },
      ),
      children: [
        LabeledField(
          label: l.fieldCategory,
          child: ChoiceChips<DocCategory>(
            options: [
              for (final c in DocCategory.values) (c, l.docCategory(c)),
            ],
            selected: _cat,
            onSelected: (c) => setState(() => _cat = c),
          ),
        ),
        AppTextField(label: l.fieldTitle, controller: _title, error: _error),
        DateField(
          label: l.fieldDocumentDate,
          value: _date,
          firstDate: DateTime(1950),
          lastDate: today,
          onChanged: (d) => setState(() => _date = d),
        ),
        AppTextField(label: l.fieldDescription, controller: _desc, maxLines: 3),
      ],
    );
  }
}
