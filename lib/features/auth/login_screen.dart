import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../../data/session.dart';
import '../../core/integrations/totp.dart';
import '../../core/integrations/verification.dart';
import 'code_flow.dart';
import 'onboarding_screen.dart';
import 'welcome_screen.dart';

final _emailRe = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
final _phoneRe = RegExp(r'^\+?\d{8,15}$');

bool isValidIdentifier(String id) =>
    _emailRe.hasMatch(id) ||
    _phoneRe.hasMatch(id.replaceAll(RegExp(r'[\s\-()]'), ''));

/// Phone or email, then a one-time code: a real SMS or email code when
/// those services are set up, the authenticator app when the account has one,
/// and the demo code 123456 for the built-in demo accounts.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _id = TextEditingController();
  final _code = TextEditingController();
  final _flow = CodeFlow();
  bool _busy = false;
  String? _error;
  String? _personId;

  @override
  void dispose() {
    _id.dispose();
    _code.dispose();
    super.dispose();
  }

  String? _lookup(String id) {
    final data = ref.read(demoStoreProvider);
    final clean = id.replaceAll(RegExp(r'[\s\-()]'), '').toLowerCase();
    final e164 = CodeFlow.isEmail(clean) ? clean : toE164(clean);
    for (final p in data.profiles.values) {
      if (p.email?.toLowerCase() == clean ||
          (p.phone != null && (p.phone == clean || toE164(p.phone!) == e164))) {
        return p.id;
      }
    }
    return null;
  }

  /// The built-in demo accounts keep the demo code.
  bool get _demoAccount => _personId != null && !_personId!.startsWith('new');

  String? get _totpSecret =>
      _personId == null ? null : ref.read(totpStoreProvider)[_personId];

  Future<void> _run(Future<void> Function() job) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await job();
    } on Object catch (e) {
      if (mounted) setState(() => _error = verifyErrorText(context, e));
    }
    if (mounted) setState(() => _busy = false);
  }

  Future<void> _send() async {
    final l = context.l10n;
    final id = _id.text.trim();
    if (!isValidIdentifier(id)) {
      setState(() => _error = l.authInvalidIdentifier);
      return;
    }
    _personId = _lookup(id);
    await _run(
      () => _flow.start(
        ref,
        id,
        demoAccount: _demoAccount,
        totpSecret: _totpSecret,
      ),
    );
    if (_flow.method == CodeMethod.sms &&
        ref.read(verificationProvider).smsAutoVerified) {
      _done();
    }
  }

  Future<void> _verify() async {
    var ok = false;
    await _run(() async {
      ok = await _flow.check(ref, _code.text, totpSecret: _totpSecret);
    });
    if (!mounted || _error != null) return;
    if (!ok) {
      setState(() => _error = context.l10n.authInvalidCode);
      return;
    }
    _done();
  }

  void _done() {
    final nav = Navigator.of(context);
    if (_personId != null) {
      ref.read(sessionProvider.notifier).signIn(_personId!);
      nav.popUntil((r) => r.isFirst);
      return;
    }
    // Verified, but no account yet: carry on into sign-up.
    final id = _id.text.trim();
    showToast(context, context.l10n.authNoAccountYet);
    nav.pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => CodeFlow.isEmail(id)
            ? OnboardingScreen(verifiedEmail: id.toLowerCase())
            : OnboardingScreen(verifiedPhone: toE164(id)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    return PageScaffold(
      title: l.loginTitle,
      showLanguage: true,
      children: [
        Text(l.loginIntro, style: const TextStyle(height: 1.5)),
        const SizedBox(height: 14),
        AppTextField(
          fieldKey: const Key('login-id'),
          label: l.fieldPhoneOrEmail,
          controller: _id,
          enabled: !_flow.sent && !_busy,
          keyboardType: TextInputType.emailAddress,
        ),
        if (_flow.sent) ...[
          AppTextField(
            fieldKey: const Key('login-code'),
            label: _flow.method == CodeMethod.totp
                ? l.totpCodeLabel
                : l.fieldOtp,
            controller: _code,
            keyboardType: TextInputType.number,
          ),
          CodeNote(flow: _flow, demoAccount: _demoAccount),
        ],
        if (_error != null) InfoBanner(_error!, tone: Tone.alert),
        if (_busy)
          const Padding(
            padding: EdgeInsets.all(8),
            child: Center(child: CircularProgressIndicator()),
          )
        else
          PrimaryButton(
            _flow.sent ? l.actionVerify : l.actionSendCode,
            key: const Key('login-submit'),
            onPressed: _flow.sent ? _verify : _send,
          ),
        if (_flow.method == CodeMethod.totp && !_busy)
          TextButton(
            key: const Key('login-send-instead'),
            onPressed: () =>
                _run(() => _flow.sendInstead(ref, demoAccount: _demoAccount)),
            child: Text(l.authSendCodeInstead),
          ),
        if (_flow.sent)
          TextButton(
            onPressed: () => setState(() {
              _flow.reset();
              _code.clear();
              _error = null;
            }),
            child: Text(l.loginChangeIdentifier),
          ),
        const SizedBox(height: 8),
        Text(
          l.loginRecoveryHint,
          style: TextStyle(color: p.muted, fontSize: 12.5, height: 1.5),
        ),
        const SsoButtons(),
        const ConnectionsLink(),
        AppCard(
          color: p.sky,
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.demoModeTitle,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(
                l.welcomeDemoHint(DemoAccounts.code),
                style: const TextStyle(fontSize: 13.5, height: 1.45),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final (label, email) in [
                    (l.demoUsePatient, DemoAccounts.patient),
                    (l.demoUseCyclePatient, DemoAccounts.cycle),
                    (l.demoUseDoctor, DemoAccounts.doctor),
                  ])
                    SelectChip(
                      label: label,
                      selected: false,
                      onTap: () => setState(() {
                        _id.text = email;
                        _flow.reset();
                        _error = null;
                      }),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
