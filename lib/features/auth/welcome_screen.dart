import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../settings/language_switcher.dart';
import 'google_button.dart';
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
            OneLine(
              l.appName,
              alignment: Alignment.center,
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
            const GoogleButton(),
            const SizedBox(height: 10),
            InfoBanner(
              l.welcomeDemoHint(DemoAccounts.code),
              title: l.demoModeTitle,
            ),
            const Disclaimer(),
          ],
        ),
      ),
    );
  }
}
