import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/integrations/integration_config.dart';
import '../../core/integrations/totp.dart';
import '../../core/integrations/verification.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../profile/connections_page.dart';

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
    final cfg = ref.read(integrationConfigProvider);
    final v = ref.read(verificationProvider);
    if (totpSecret != null) {
      method = CodeMethod.totp;
    } else if (demoAccount) {
      method = CodeMethod.demo;
    } else if (cfg.hasEmail) {
      await v.sendEmailCode(id);
      method = CodeMethod.email;
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
        totpSecret != null && Totp.verify(totpSecret, c, DateTime.now()),
      null => false,
    };
  }

  void reset() {
    method = null;
    target = '';
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

/// Small link to the Connections page, for testers on the sign-in screens.
class ConnectionsLink extends StatelessWidget {
  const ConnectionsLink({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: TextButton.icon(
      key: const Key('open-connections'),
      onPressed: () => Navigator.of(
        context,
      ).push(MaterialPageRoute<void>(builder: (_) => const ConnectionsPage())),
      icon: const Icon(Icons.hub_outlined, size: 18),
      label: Text(context.l10n.connectionsTitle),
    ),
  );
}
