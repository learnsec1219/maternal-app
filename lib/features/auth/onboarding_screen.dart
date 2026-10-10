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
import '../settings/language_switcher.dart';
import '../settings/locale_controller.dart';
import 'login_screen.dart';

enum _Step { role, verify, personal, body, pregnancy, done }

/// Multi-step sign-up: role, verify phone or email, about you, body,
/// pregnancy, done. Doctors skip body and pregnancy and wait for approval.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key, this.verifiedEmail});

  /// Set when the person came from Google or Microsoft: no code step.
  final String? verifiedEmail;

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  _Step _step = _Step.role;
  UserRole? _role;
  bool _email = false, _sent = false, _verified = false;
  String? _error;
  final _id = TextEditingController();
  final _code = TextEditingController();
  final _name = TextEditingController();
  final _mmc = TextEditingController();
  final _clinic = TextEditingController();
  DateTime? _dob, _due;
  double _height = 160, _weight = 60;
  bool? _pregnant;
  int _babies = 1;
  bool _showErrors = false;

  @override
  void initState() {
    super.initState();
    if (widget.verifiedEmail != null) {
      _email = true;
      _verified = true;
      _id.text = widget.verifiedEmail!;
    }
  }

  @override
  void dispose() {
    for (final c in [_id, _code, _name, _mmc, _clinic]) {
      c.dispose();
    }
    super.dispose();
  }

  List<_Step> get _steps => _role == UserRole.doctor
      ? const [_Step.role, _Step.verify, _Step.personal, _Step.done]
      : _Step.values;

  void _go(int delta) {
    var i = _steps.indexOf(_step) + delta;
    if (i < 0) {
      Navigator.of(context).pop();
      return;
    }
    if (_steps[i] == _Step.verify && _verified) i += delta;
    if (i < 0) {
      Navigator.of(context).pop();
      return;
    }
    setState(() {
      _step = _steps[i];
      _error = null;
      _showErrors = false;
    });
  }

  void _finish() {
    final today = ref.read(todayProvider);
    if (_role == UserRole.doctor) {
      Navigator.of(context).pop();
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(ctx.l10n.doctorPendingTitle),
          content: Text(ctx.l10n.doctorPendingBody),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(ctx.l10n.actionOk),
            ),
          ],
        ),
      );
      return;
    }
    final id = 'new${DateTime.now().millisecondsSinceEpoch}';
    final pregnant = _pregnant == true && _due != null;
    final profile = Profile(
      id: id,
      name: _name.text.trim(),
      email: _email ? _id.text.trim().toLowerCase() : null,
      phone: _email ? null : _id.text.replaceAll(RegExp(r'[\s\-()]'), ''),
      dob: _dob,
      height: _height,
      weight: _weight,
      journey: pregnant ? Journey.pregnancy : Journey.general,
      due: pregnant ? _due : null,
      babies: _babies,
      journeyStart: today,
    );
    ref.read(demoStoreProvider.notifier).addProfile(profile);
    ref.read(sessionProvider.notifier).signIn(id);
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    final idx = _steps.indexOf(_step);
    final total = _steps.length + 1; // the welcome screen counts as step 1
    final (title, sub, body, button, onPressed) = _page(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l.actionBack,
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => _go(-1),
        ),
        title: Text(
          l.onboardingStepOf(idx + 2, total),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: const [LanguageSwitcher(), SizedBox(width: 6)],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (idx + 2) / total,
            minHeight: 4,
            color: p.rose,
            backgroundColor: p.line,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (sub != null) ...[
                    const SizedBox(height: 6),
                    Text(sub, style: TextStyle(color: p.muted, height: 1.45)),
                  ],
                  const SizedBox(height: 18),
                  ...body,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
              child: PrimaryButton(
                button,
                key: const Key('onboarding-next'),
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  (String, String?, List<Widget>, String, VoidCallback?) _page(
    BuildContext context,
  ) {
    final l = context.l10n, p = context.pal;
    final today = ref.watch(todayProvider);
    switch (_step) {
      case _Step.role:
        return (
          l.onboardingRoleTitle,
          l.onboardingRoleSubtitle,
          [
            _Option(
              icon: Icons.person_outline_rounded,
              title: l.rolePatient,
              hint: l.rolePatientHint,
              selected: _role == UserRole.patient,
              onTap: () => setState(() => _role = UserRole.patient),
            ),
            _Option(
              icon: Icons.medical_services_outlined,
              title: l.roleDoctor,
              hint: l.roleDoctorHint,
              selected: _role == UserRole.doctor,
              onTap: () => setState(() => _role = UserRole.doctor),
            ),
          ],
          l.actionContinue,
          _role == null ? null : () => _go(1),
        );
      case _Step.verify:
        return (
          l.onboardingVerifyTitle,
          l.onboardingVerifySubtitle,
          [
            ChoiceChips<bool>(
              options: [(false, l.channelPhone), (true, l.channelEmail)],
              selected: _email,
              onSelected: (v) => setState(() {
                _email = v;
                _sent = false;
              }),
            ),
            AppTextField(
              label: _email ? l.fieldEmail : l.fieldPhone,
              controller: _id,
              enabled: !_sent,
              hint: _email ? 'name@example.com' : '+60 12-345 6789',
              keyboardType: _email
                  ? TextInputType.emailAddress
                  : TextInputType.phone,
            ),
            if (_sent)
              AppTextField(
                label: l.fieldOtp,
                controller: _code,
                keyboardType: TextInputType.number,
              ),
            if (_error != null) InfoBanner(_error!, tone: Tone.alert),
            InfoBanner(
              l.onboardingDemoCode(DemoAccounts.code),
              title: l.demoModeTitle,
            ),
          ],
          _sent ? l.actionVerify : l.actionSendCode,
          () {
            if (!_sent) {
              final ok =
                  isValidIdentifier(_id.text.trim()) &&
                  (_email == _id.text.contains('@'));
              setState(() {
                _error = ok ? null : l.authInvalidIdentifier;
                _sent = ok;
              });
            } else if (_code.text.trim() != DemoAccounts.code) {
              setState(() => _error = l.authInvalidCode);
            } else {
              _verified = true;
              _go(1);
            }
          },
        );
      case _Step.personal:
        final lang = ref.watch(localeProvider).languageCode;
        return (
          l.onboardingPersonalTitle,
          l.onboardingPersonalSubtitle,
          [
            AppTextField(
              label: l.fieldFullName,
              controller: _name,
              error: _showErrors && _name.text.trim().length < 2
                  ? l.errorRequired
                  : null,
            ),
            DateField(
              label: l.fieldDateOfBirth,
              value: _dob,
              firstDate: DateTime(today.year - 80),
              lastDate: DateTime(today.year - 10, 12, 31),
              error: _showErrors && _dob == null ? l.errorRequired : null,
              onChanged: (d) => setState(() => _dob = d),
            ),
            LabeledField(
              label: l.fieldPreferredLanguage,
              child: ChoiceChips<String>(
                options: [
                  for (final a in appLanguages)
                    (a.locale.languageCode, a.native),
                ],
                selected: lang,
                onSelected: (c) => ref
                    .read(localeProvider.notifier)
                    .set(
                      appLanguages
                          .firstWhere((a) => a.locale.languageCode == c)
                          .locale,
                    ),
              ),
            ),
            if (_role == UserRole.doctor) ...[
              AppTextField(
                label: l.fieldMmcNumber,
                controller: _mmc,
                helper: l.fieldMmcHelper,
              ),
              AppTextField(label: l.fieldClinic, controller: _clinic),
            ],
          ],
          l.actionContinue,
          () {
            if (_name.text.trim().length < 2 || _dob == null) {
              setState(() => _showErrors = true);
            } else {
              _go(1);
            }
          },
        );
      case _Step.body:
        Widget slider(
          String label,
          double value,
          double min,
          double max,
          String unit,
          ValueChanged<double> set,
        ) => AppCard(
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(color: p.muted, fontSize: 12.5),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filledTonal(
                    tooltip: l.actionDecrease,
                    onPressed: () => set((value - 1).clamp(min, max)),
                    icon: const Icon(Icons.remove_rounded),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: FittedBox(
                        child: Text(
                          '${value.round()} $unit',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton.filledTonal(
                    tooltip: l.actionIncrease,
                    onPressed: () => set((value + 1).clamp(min, max)),
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),
              Slider(
                value: value,
                min: min,
                max: max,
                label: label,
                onChanged: (v) => set(v.roundToDouble()),
              ),
            ],
          ),
        );
        return (
          l.onboardingBodyTitle,
          l.onboardingBodySubtitle,
          [
            slider(
              l.fieldHeight,
              _height,
              130,
              200,
              'cm',
              (v) => setState(() => _height = v),
            ),
            slider(
              l.fieldPrePregnancyWeight,
              _weight,
              35,
              150,
              'kg',
              (v) => setState(() => _weight = v),
            ),
          ],
          l.actionContinue,
          () => _go(1),
        );
      case _Step.pregnancy:
        final content = ref.watch(contentProvider);
        String? dueError, dueHelp = l.dueDateHelper;
        if (_due != null) {
          switch (checkDueDate(_due!, today, content)) {
            case DueCheck.future:
              dueError = l.dueDateTooFarFuture;
            case DueCheck.past:
              dueError = l.dueDateTooFarPast;
            case DueCheck.ok:
              dueHelp = l.dueDateGaPreview(l.gaText(gaDaysFor(_due!, today)));
          }
        }
        return (
          l.onboardingPregnancyTitle,
          l.onboardingPregnancySubtitle,
          [
            Row(
              children: [
                for (final (v, icon, label) in [
                  (true, Icons.check_rounded, l.answerYes),
                  (false, Icons.circle_outlined, l.answerNo),
                ]) ...[
                  if (!v) const SizedBox(width: 10),
                  Expanded(
                    child: _Option(
                      icon: icon,
                      title: label,
                      selected: _pregnant == v,
                      onTap: () => setState(() => _pregnant = v),
                    ),
                  ),
                ],
              ],
            ),
            if (_pregnant == true) ...[
              DateField(
                label: l.fieldDueDate,
                value: _due,
                firstDate: addDays(today, -60),
                lastDate: addDays(today, 300),
                helper: dueHelp,
                error: dueError,
                onChanged: (d) => setState(() => _due = d),
              ),
              LabeledField(
                label: l.fieldNumberOfBabies,
                child: ChoiceChips<int>(
                  options: [
                    for (final n in [1, 2, 3, 4]) (n, l.babyCount(n)),
                  ],
                  selected: _babies,
                  onSelected: (n) => setState(() => _babies = n),
                ),
              ),
            ],
            if (_pregnant == false) InfoBanner(l.onboardingNotPregnantInfo),
          ],
          l.actionContinue,
          _pregnant == null ||
                  (_pregnant! && (_due == null || dueError != null))
              ? null
              : () => _go(1),
        );
      case _Step.done:
        final doctor = _role == UserRole.doctor;
        Widget row(String k, String v) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(k, style: TextStyle(color: p.muted)),
              ),
              const SizedBox(width: 8),
              Flexible(child: Text(v, textAlign: TextAlign.end)),
            ],
          ),
        );
        return (
          doctor ? l.onboardingDoctorDoneTitle : l.onboardingDoneTitle,
          doctor ? l.onboardingDoctorDoneSubtitle : l.onboardingDoneSubtitle,
          [
            Center(
              child: Container(
                width: 110,
                height: 110,
                margin: const EdgeInsets.only(bottom: 18),
                decoration: BoxDecoration(
                  color: p.goodSoft,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  doctor ? Icons.hourglass_top_rounded : Icons.check_rounded,
                  size: 54,
                  color: p.good,
                ),
              ),
            ),
            AppCard(
              child: Column(
                children: [
                  row(l.fieldFullName, _name.text.trim()),
                  row(l.fieldPhoneOrEmail, _id.text.trim()),
                  if (!doctor && _pregnant == true && _due != null)
                    row(l.fieldDueDate, context.formatLongDate(_due!)),
                ],
              ),
            ),
          ],
          doctor ? l.actionFinish : l.actionGoHome,
          _finish,
        );
    }
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.icon,
    required this.title,
    this.hint,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String? hint;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    return Semantics(
      selected: selected,
      button: true,
      child: AppCard(
        color: selected ? p.roseSoft : null,
        onTap: onTap,
        child: Row(
          children: [
            TileIcon(
              icon,
              background: selected ? p.card : p.roseSoft,
              size: 46,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  if (hint != null)
                    Text(
                      hint!,
                      style: TextStyle(color: p.muted, fontSize: 12.5),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
