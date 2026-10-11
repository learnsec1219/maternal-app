import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../../data/session.dart';
import '../settings/language_switcher.dart';
import '../../core/integrations/integration_config.dart';
import '../../core/integrations/verification.dart';
import 'code_flow.dart';
import 'login_screen.dart';
import 'onboarding_screen.dart';

/// First screen when nobody is signed in.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: LanguageSwitcher(),
            ),
            const SizedBox(height: 12),
            Center(
              child: ClipOval(
                child: Image.asset(
                  'assets/branding/maternal-icon.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  semanticLabel: l.appName,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l.appName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              l.welcomeTagline,
              textAlign: TextAlign.center,
              style: TextStyle(color: p.muted, height: 1.5),
            ),
            const SizedBox(height: 28),
            PrimaryButton(
              l.welcomeCreateAccount,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const OnboardingScreen(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            GhostButton(
              l.welcomeSignIn,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
              ),
            ),
            const SsoButtons(),
            const SizedBox(height: 10),
            InfoBanner(
              l.welcomeDemoHint(DemoAccounts.code),
              title: l.demoModeTitle,
            ),
            const ConnectionsLink(),
            const Disclaimer(),
          ],
        ),
      ),
    );
  }
}

/// "or" divider and the Google / Microsoft buttons.
class SsoButtons extends ConsumerWidget {
  const SsoButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(child: Divider(color: p.line)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  l.ssoOr,
                  style: TextStyle(color: p.muted, fontSize: 12.5),
                ),
              ),
              Expanded(child: Divider(color: p.line)),
            ],
          ),
        ),
        for (final (provider, icon) in const [
          ('Google', Icons.account_circle_outlined),
          ('Microsoft', Icons.public_rounded),
        ]) ...[
          GhostButton(
            l.ssoContinueWith(provider),
            icon: icon,
            onPressed: () => ref.read(integrationConfigProvider).hasFirebase
                ? realSsoSignIn(context, ref, provider)
                : showSsoSheet(context, provider),
          ),
          const SizedBox(height: 10),
        ],
        Text(
          l.ssoNote,
          textAlign: TextAlign.center,
          style: TextStyle(color: p.muted, fontSize: 12.5, height: 1.45),
        ),
      ],
    );
  }
}

/// Real Google / Microsoft sign-in through Firebase. A known email signs
/// in; a new one carries on into sign-up with the email already verified.
Future<void> realSsoSignIn(
  BuildContext context,
  WidgetRef ref,
  String provider,
) async {
  final nav = Navigator.of(context);
  final String email;
  try {
    email = await ref.read(verificationProvider).signInWith(provider);
  } on VerifyException catch (e) {
    if (context.mounted && e.error != VerifyError.cancelled) {
      showToast(context, verifyErrorText(context, e));
    }
    return;
  } on Object catch (e) {
    if (context.mounted) showToast(context, verifyErrorText(context, e));
    return;
  }
  final known = ref.read(demoStoreProvider).profileByEmail(email);
  if (known != null) {
    ref.read(sessionProvider.notifier).signIn(known.id);
    nav.popUntil((r) => r.isFirst);
  } else {
    nav.push(
      MaterialPageRoute<void>(
        builder: (_) => OnboardingScreen(verifiedEmail: email),
      ),
    );
  }
}

/// Google and Microsoft sign-in need the clinic's own client IDs, so the demo
/// build offers the demo accounts instead and says so.
Future<void> showSsoSheet(BuildContext context, String provider) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _SsoSheet(provider: provider),
    );

class _SsoSheet extends ConsumerWidget {
  const _SsoSheet({required this.provider});
  final String provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    const newEmail = 'new.person@example.com';
    final accounts = [
      ('Gwen', DemoAccounts.patient),
      ('Aina', DemoAccounts.cycle),
      (DemoDoctor.name, DemoAccounts.doctor),
      (l.ssoDemoNewPerson, newEmail),
    ];
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.ssoDemoTitle(provider),
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              l.ssoDemoBody(provider),
              style: TextStyle(color: p.muted, fontSize: 13, height: 1.45),
            ),
            const SizedBox(height: 8),
            for (final (name, email) in accounts)
              ListRow(
                leading: const Icon(Icons.person_outline_rounded),
                title: name,
                subtitle: email,
                trailing: Icon(Icons.chevron_right_rounded, color: p.muted),
                onTap: () {
                  final known = ref
                      .read(demoStoreProvider)
                      .profileByEmail(email);
                  final nav = Navigator.of(context);
                  nav.pop();
                  if (known != null) {
                    ref.read(sessionProvider.notifier).signIn(known.id);
                    nav.popUntil((r) => r.isFirst);
                  } else {
                    nav.push(
                      MaterialPageRoute<void>(
                        builder: (_) => OnboardingScreen(verifiedEmail: email),
                      ),
                    );
                  }
                },
              ),
            const ConnectionsLink(),
          ],
        ),
      ),
    );
  }
}
