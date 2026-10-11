import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/integrations/integration_config.dart';
import '../../core/integrations/totp.dart';
import '../../core/integrations/verification.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';

/// How a one-time code reaches the person.
enum CodeMethod {
  /// Built-in demo accounts, or a service that is not set up: code 123456.
  demo,

  /// A real code by email (EmailJS).
  email,

  /// The 6-digit code in Google Authenticator or a similar app.
  totp,
}

/// Picks how to verify an email, sends the code, checks it.
class CodeFlow {
  CodeMethod? method;
  String target = '';

  /// When an email code stops working; null for the other methods.
  DateTime? expiresAt;

  bool get expired => expiresAt != null && clock.now().isAfter(expiresAt!);

  bool get sent => method != null;

  static bool isEmail(String id) => id.contains('@');

  /// Sends a code to [id]. [demoAccount] is true for the built-in demo
  /// accounts, which keep the demo code. [totpSecret] is set when the
  /// account has an authenticator app turned on.
  Future<void> start(
    WidgetRef ref,
    String id, {
    required bool demoAccount,
    String? totpSecret,
  }) async {
    target = id;
    expiresAt = null;
    final cfg = ref.read(integrationConfigProvider);
    final v = ref.read(verificationProvider);
    if (totpSecret != null) {
      method = CodeMethod.totp;
    } else if (demoAccount) {
      method = CodeMethod.demo;
    } else if (cfg.hasEmail) {
      await v.sendEmailCode(id);
      method = CodeMethod.email;
      expiresAt = clock.now().add(emailCodeLife);
    } else {
      method = CodeMethod.demo;
    }
  }

  /// Sends a real code instead of asking for the authenticator code.
  Future<void> sendInstead(WidgetRef ref, {required bool demoAccount}) =>
      start(ref, target, demoAccount: demoAccount);

  Future<bool> check(WidgetRef ref, String code, {String? totpSecret}) async {
    final c = code.trim();
    return switch (method) {
      CodeMethod.demo => c == DemoAccounts.code,
      CodeMethod.email =>
        ref.read(verificationProvider).checkEmailCode(target, c),
      CodeMethod.totp =>
        totpSecret != null && Totp.verify(totpSecret, c, clock.now()),
      null => false,
    };
  }

  void reset() {
    method = null;
    target = '';
    expiresAt = null;
  }
}

/// The note under the code field: where the code went, or the demo code.
class CodeNote extends StatelessWidget {
  const CodeNote({super.key, required this.flow, required this.demoAccount});
  final CodeFlow flow;
  final bool demoAccount;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return switch (flow.method) {
      CodeMethod.email => InfoBanner(l.otpSentTo(flow.target)),
      CodeMethod.totp => InfoBanner(l.authAuthenticatorHelp),
      CodeMethod.demo => InfoBanner(
        demoAccount
            ? l.onboardingDemoCode(DemoAccounts.code)
            : '${l.onboardingDemoCode(DemoAccounts.code)} '
                  '${l.authEmailNotSetUp}',
        title: l.demoModeTitle,
      ),
      null => const SizedBox.shrink(),
    };
  }
}

String verifyErrorText(BuildContext context, Object e) {
  final l = context.l10n;
  if (e is VerifyException) {
    return switch (e.error) {
      VerifyError.notConfigured => l.authEmailNotSetUp,
      VerifyError.sendFailed => l.authSendFailed(e.detail),
    };
  }
  return l.authSendFailed('$e');
}

/// Seconds left on an email code, counting down to 0. When time runs out it
/// says so and offers to send a new code.
class CodeCountdown extends StatefulWidget {
  const CodeCountdown({super.key, required this.flow, required this.onResend});
  final CodeFlow flow;
  final VoidCallback? onResend;

  @override
  State<CodeCountdown> createState() => _CodeCountdownState();
}

class _CodeCountdownState extends State<CodeCountdown> {
  Timer? _tick;

  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() {
    _tick?.cancel();
    _tick = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
      if (widget.flow.expired) _tick?.cancel();
    });
  }

  @override
  void didUpdateWidget(CodeCountdown old) {
    super.didUpdateWidget(old);
    // A new code was sent: count down again.
    if (!(_tick?.isActive ?? false) && !widget.flow.expired) _start();
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    final end = widget.flow.expiresAt;
    if (end == null) return const SizedBox.shrink();
    final left = end.difference(clock.now()).inSeconds.clamp(0, 999);
    if (left <= 0 || widget.flow.expired) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Icon(Icons.timer_off_outlined, color: p.alert, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                l.otpExpired,
                key: const Key('otp-expired'),
                style: TextStyle(color: p.alert),
              ),
            ),
            TextButton(
              key: const Key('otp-resend'),
              onPressed: widget.onResend,
              child: Text(l.otpResend),
            ),
          ],
        ),
      );
    }
    final mm = left ~/ 60, ss = (left % 60).toString().padLeft(2, '0');
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(Icons.timer_outlined, color: p.rose, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              l.otpExpiresIn('$mm:$ss'),
              key: const Key('otp-countdown'),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
