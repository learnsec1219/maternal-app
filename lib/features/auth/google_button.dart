import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/integrations/google_auth.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/clock.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../../data/models.dart';
import '../../data/session.dart';
import '../patient/patient_data.dart';
import 'onboarding_screen.dart';

/// "or" divider and the Continue with Google button.
class GoogleButton extends ConsumerWidget {
  const GoogleButton({super.key});

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
        GhostButton(
          l.googleContinue,
          key: const Key('google-sign-in'),
          leading: Image.asset(
            'assets/branding/google-g.png',
            width: 20,
            height: 20,
            semanticLabel: 'Google',
          ),
          onPressed: () => signInWithGoogle(context, ref),
        ),
      ],
    );
  }
}

/// Signs in with Google. A known email goes straight in. A new one is asked
/// whether to copy the Google name, email and photo into a new profile; if
/// they allow it they go straight to Home, otherwise sign-up continues with
/// the email already verified.
Future<void> signInWithGoogle(BuildContext context, WidgetRef ref) async {
  final l = context.l10n;
  final nav = Navigator.of(context);
  final GoogleProfile? g;
  try {
    final r = await ref.read(googleAuthProvider).signIn();
    g = r == null
        ? null
        : GoogleProfile(
            email: r.email.trim().toLowerCase(),
            name: r.name,
            photoUrl: r.photoUrl,
          );
  } on GoogleAuthException catch (e) {
    if (context.mounted) {
      showToast(
        context,
        e.error == GoogleAuthError.notConfigured
            ? l.googleNotSetUp
            : l.googleFailed(e.detail),
      );
    }
    return;
  } on Object catch (e) {
    if (context.mounted) showToast(context, l.googleFailed('$e'));
    return;
  }
  if (g == null || !context.mounted) return;
  final known = ref.read(demoStoreProvider).profileByEmail(g.email);
  if (known != null) {
    if (known.photoUrl == null && g.photoUrl != null) {
      known.photoUrl = g.photoUrl;
      ref.read(demoStoreProvider.notifier).updateProfile(known);
    }
    ref.read(sessionProvider.notifier).signIn(known.id);
    nav.popUntil((r) => r.isFirst);
    return;
  }
  final allow = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _ConsentSheet(g!),
  );
  if (allow == null || !context.mounted) return;
  if (!allow) {
    nav.push(
      MaterialPageRoute<void>(
        builder: (_) => OnboardingScreen(verifiedEmail: g!.email),
      ),
    );
    return;
  }
  final id = 'new${DateTime.now().millisecondsSinceEpoch}';
  final name = (g.name ?? '').trim();
  ref
      .read(demoStoreProvider.notifier)
      .addProfile(
        Profile(
          id: id,
          name: name.isEmpty ? g.email.split('@').first : name,
          email: g.email,
          photoUrl: g.photoUrl,
          journey: Journey.general,
          journeyStart: ref.read(todayProvider),
        ),
      );
  ref.read(sessionProvider.notifier).signIn(id);
  nav.popUntil((r) => r.isFirst);
}

/// Asks before copying the Google details into the profile.
class _ConsentSheet extends StatelessWidget {
  const _ConsentSheet(this.g);
  final GoogleProfile g;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    Widget row(IconData icon, String label, String value) => ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: p.muted),
      title: Text(label, style: TextStyle(color: p.muted, fontSize: 12.5)),
      subtitle: Text(value, style: const TextStyle(fontSize: 15)),
    );
    return SafeArea(
      child: SingleChildScrollView(
        key: const Key('google-consent'),
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Avatar(g.name ?? g.email, size: 64, photoUrl: g.photoUrl),
            ),
            const SizedBox(height: 12),
            Text(
              l.googleConsentTitle,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              l.googleConsentBody,
              style: TextStyle(color: p.muted, fontSize: 13, height: 1.45),
            ),
            if ((g.name ?? '').isNotEmpty)
              row(Icons.person_outline_rounded, l.fieldFullName, g.name!),
            row(Icons.mail_outline_rounded, l.fieldEmail, g.email),
            if (g.photoUrl != null)
              row(Icons.photo_outlined, l.googlePhoto, l.googlePhotoValue),
            const SizedBox(height: 8),
            PrimaryButton(
              l.googleConsentAllow,
              key: const Key('google-allow'),
              onPressed: () => Navigator.pop(context, true),
            ),
            const SizedBox(height: 8),
            GhostButton(
              l.googleConsentManual,
              key: const Key('google-manual'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      ),
    );
  }
}
