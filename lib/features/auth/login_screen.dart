import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../../data/session.dart';
import 'welcome_screen.dart';

final _emailRe = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
final _phoneRe = RegExp(r'^\+?\d{8,15}$');

bool isValidIdentifier(String id) =>
    _emailRe.hasMatch(id) ||
    _phoneRe.hasMatch(id.replaceAll(RegExp(r'[\s\-()]'), ''));

/// Phone or email, then a one-time code. In the demo build the code is
/// always 123456 and only the demo accounts (and new sign-ups) exist.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _id = TextEditingController();
  final _code = TextEditingController();
  bool _sent = false;
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
    for (final p in data.profiles.values) {
      if (p.email?.toLowerCase() == clean ||
          (p.phone != null && p.phone == clean)) {
        return p.id;
      }
    }
    return null;
  }

  void _send() {
    final l = context.l10n;
    final id = _id.text.trim();
    setState(() {
      if (!isValidIdentifier(id)) {
        _error = l.authInvalidIdentifier;
      } else if ((_personId = _lookup(id)) == null) {
        _error = l.authAccountNotFound;
      } else {
        _error = null;
        _sent = true;
      }
    });
  }

  void _verify() {
    if (_code.text.trim() != DemoAccounts.code) {
      setState(() => _error = context.l10n.authInvalidCode);
      return;
    }
    ref.read(sessionProvider.notifier).signIn(_personId!);
    Navigator.of(context).popUntil((r) => r.isFirst);
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
          enabled: !_sent,
          keyboardType: TextInputType.emailAddress,
        ),
        if (_sent)
          AppTextField(
            fieldKey: const Key('login-code'),
            label: l.fieldOtp,
            controller: _code,
            keyboardType: TextInputType.number,
            helper: l.otpSentTo(_id.text.trim()),
          ),
        if (_error != null) InfoBanner(_error!, tone: Tone.alert),
        PrimaryButton(
          _sent ? l.actionVerify : l.actionSendCode,
          key: const Key('login-submit'),
          onPressed: _sent ? _verify : _send,
        ),
        if (_sent)
          TextButton(
            onPressed: () => setState(() {
              _sent = false;
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
        const SizedBox(height: 12),
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
                        _sent = false;
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
