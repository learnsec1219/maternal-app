import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/content/clinical_content.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/clock.dart';
import '../../core/util/dates.dart';
import '../../core/util/l10n.dart';
import '../../core/util/labels.dart';
import '../../core/widgets/common.dart';
import '../../core/widgets/date_field.dart';
import '../../data/demo_store.dart';
import '../../data/models.dart';
import '../../data/session.dart';
import '../../domain/health_rules.dart';
import '../patient/patient_data.dart';
import 'profile_screen.dart';

/// Label above value, so long labels in any language wrap instead of
/// being cut off.
class InfoRow extends StatelessWidget {
  const InfoRow(this.label, this.value, {super.key, this.first = false});
  final String label;
  final String? value;
  final bool first;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        border: first ? null : Border(top: BorderSide(color: p.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12.5, color: p.muted)),
          const SizedBox(height: 2),
          Text(value == null || value!.isEmpty ? '—' : value!),
        ],
      ),
    );
  }
}

class PersonalInfoPage extends ConsumerWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final me = mineOf(ref).me;
    String num(double? v, String unit) =>
        v == null ? '' : '${context.formatNumber(v, v % 1 == 0 ? 0 : 1)} $unit';
    return PageScaffold(
      title: l.menuPersonalInfo,
      children: [
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            children: [
              InfoRow(l.fieldFullName, me.name, first: true),
              InfoRow(
                l.fieldDateOfBirth,
                me.dob == null ? null : context.formatLongDate(me.dob!),
              ),
              InfoRow(l.fieldPhoneOrEmail, me.phone ?? me.email),
              InfoRow(l.fieldHeight, num(me.height, 'cm')),
              InfoRow(l.fieldPrePregnancyWeight, num(me.weight, 'kg')),
              InfoRow(l.fieldActivityLevel, l.activity(me.activity)),
              InfoRow(l.fieldBloodGroup, me.blood),
              InfoRow(l.fieldAllergies, me.allergies),
              InfoRow(l.menuEmergencyContact, me.emergency),
            ],
          ),
        ),
      ],
    );
  }
}

class PregnancyInfoPage extends ConsumerStatefulWidget {
  const PregnancyInfoPage({super.key});

  @override
  ConsumerState<PregnancyInfoPage> createState() => _PregnancyInfoPageState();
}

class _PregnancyInfoPageState extends ConsumerState<PregnancyInfoPage> {
  DateTime? _due;
  int? _babies;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final me = mineOf(ref).me;
    final c = ref.watch(contentProvider);
    final today = ref.watch(todayProvider);
    final preg = me.journey == Journey.pregnancy;
    _due ??= preg ? me.due : null;
    _babies ??= me.babies;
    final ga = _due == null ? null : gaDaysFor(_due!, today);
    return PageScaffold(
      title: l.menuPregnancyInfo,
      bottom: PrimaryButton(
        l.actionSave,
        onPressed: () {
          if (_due == null) {
            setState(() => _error = l.errorRequired);
            return;
          }
          final check = checkDueDate(_due!, today, c);
          if (check != DueCheck.ok) {
            setState(
              () => _error = check == DueCheck.future
                  ? l.dueDateTooFarFuture
                  : l.dueDateTooFarPast,
            );
            return;
          }
          me
            ..due = dateOnly(_due!)
            ..journey = Journey.pregnancy
            ..babies = _babies ?? 1
            ..journeyStart = addDays(_due!, -280);
          ref.read(demoStoreProvider.notifier).updateProfile(me);
          showToast(context, l.savedMessage);
          Navigator.pop(context);
        },
      ),
      children: [
        if (!preg) InfoBanner(l.pregnancyStartInfo),
        DateField(
          label: l.fieldDueDate,
          value: _due,
          firstDate: addDays(today, -60),
          lastDate: addDays(today, 300),
          helper: ga != null && ga >= 0 && ga <= 300
              ? l.dueDateGaPreview(l.gaText(ga))
              : l.dueDateHelper,
          error: _error,
          onChanged: (d) => setState(() {
            _due = d;
            _error = null;
          }),
        ),
        LabeledField(
          label: l.fieldNumberOfBabies,
          child: ChoiceChips<int>(
            options: [for (var i = 1; i <= 4; i++) (i, l.babyCount(i))],
            selected: _babies,
            onSelected: (v) => setState(() => _babies = v),
          ),
        ),
      ],
    );
  }
}

/// Light (default), Dark, or follow the phone. Used by patient and doctor.
class AppearancePicker extends ConsumerWidget {
  const AppearancePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final current = ref.watch(appearanceProvider);
    return ListCard(
      rows: [
        for (final (a, icon, label) in [
          (Appearance.light, Icons.light_mode_outlined, l.appearanceLight),
          (Appearance.dark, Icons.dark_mode_outlined, l.appearanceDark),
          (Appearance.system, Icons.phone_android_rounded, l.appearanceSystem),
        ])
          ListRow(
            leading: Icon(icon),
            title: label,
            trailing: current == a
                ? Icon(Icons.check_rounded, color: p.rose)
                : null,
            onTap: () => ref.read(appearanceProvider.notifier).set(a),
          ),
      ],
    );
  }
}

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return PageScaffold(
      title: l.menuAppearance,
      children: [
        const AppearancePicker(),
        Text(
          l.appearanceExplainer,
          style: TextStyle(
            fontSize: 12.5,
            color: context.pal.muted,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

/// On/off rows; in this demo build they are not saved.
class _Toggles extends StatefulWidget {
  const _Toggles(this.items);
  final List<(String, String?, bool)> items;

  @override
  State<_Toggles> createState() => _TogglesState();
}

class _TogglesState extends State<_Toggles> {
  late final _on = [for (final i in widget.items) i.$3];

  @override
  Widget build(BuildContext context) => AppCard(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    child: Column(
      children: [
        for (var i = 0; i < widget.items.length; i++)
          SwitchListTile(
            value: _on[i],
            onChanged: (v) => setState(() => _on[i] = v),
            title: Text(widget.items[i].$1),
            subtitle: widget.items[i].$2 == null
                ? null
                : Text(widget.items[i].$2!),
          ),
      ],
    ),
  );
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return PageScaffold(
      title: l.menuNotifications,
      children: [
        InfoBanner(l.notificationsRationale),
        _Toggles([
          (l.notifAppointments, null, true),
          (l.notifMedication, null, true),
          (l.notifVaccines, null, true),
          (l.notifHealthLogs, null, true),
          (l.notifMilestones, null, true),
          (l.notifDoctorMessages, null, true),
          (l.notifLockScreenDetails, l.notifLockScreenHelp, false),
        ]),
      ],
    );
  }
}

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return PageScaffold(
      title: l.menuPrivacy,
      children: [
        InfoBanner(l.privacyIntro),
        SectionHeader(l.sharingTitle),
        _Toggles([
          (l.shareVitals, null, true),
          (l.sharePregnancy, null, true),
          (l.shareCycle, null, true),
          (l.shareIntimacy, null, false),
          (l.shareDocuments, null, true),
          (l.shareNutrition, null, true),
        ]),
        SectionHeader(l.permissionsTitle),
        AppCard(
          child: Text(l.permissionsBody, style: const TextStyle(height: 1.5)),
        ),
      ],
    );
  }
}

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final c = ref.watch(contentProvider);
    return PageScaffold(
      title: l.menuAbout,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.appName,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(l.versionLabel(appVersion)),
              const SizedBox(height: 8),
              Text(l.contentVersion(c.version)),
              Text(l.contentPendingReview),
            ],
          ),
        ),
        InfoBanner(l.aboutRegulatory, tone: Tone.warn),
        const Disclaimer(),
      ],
    );
  }
}

class DevicesPage extends ConsumerWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final on = m.data.wearableConnected;
    final store = ref.read(demoStoreProvider.notifier);
    Widget status(bool ok) => Pill(
      ok ? l.statusConnected : l.statusNotConnected,
      background: ok ? p.goodSoft : p.line,
      foreground: ok ? p.good : p.muted,
    );
    return PageScaffold(
      title: l.devicesTitle,
      children: [
        InfoBanner(l.devicesDemoNote),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l.healthConnectTitle,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  status(on),
                ],
              ),
              const SizedBox(height: 8),
              Text(l.healthConnectBody, style: const TextStyle(height: 1.45)),
              const SizedBox(height: 12),
              if (on)
                GhostButton(
                  l.actionDisconnect,
                  onPressed: () => store.setWearable(false),
                )
              else
                PrimaryButton(
                  l.actionConnect,
                  onPressed: () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(l.healthConnectTitle),
                        content: Text(l.healthConnectRationale),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: Text(l.actionNotNow),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: Text(l.actionContinue),
                          ),
                        ],
                      ),
                    );
                    if (ok != true) return;
                    final now = DateTime.now();
                    store
                      ..setWearable(true)
                      ..addObservation(
                        Observation(m.me.id, now, ObsType.steps, 4200),
                      )
                      ..addObservation(
                        Observation(m.me.id, now, ObsType.hr, 81),
                      );
                    if (context.mounted) {
                      showToast(context, l.syncedReadings(2));
                    }
                  },
                ),
            ],
          ),
        ),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l.bluetoothTitle,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  status(false),
                ],
              ),
              const SizedBox(height: 8),
              Text(l.bluetoothBody, style: const TextStyle(height: 1.45)),
            ],
          ),
        ),
      ],
    );
  }
}
