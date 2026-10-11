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
import '../calendar/calendar_screen.dart';
import '../patient/patient_data.dart';
import '../records/care_pages.dart';
import '../records/health_pages.dart';
import 'connections_page.dart';
import 'security_page.dart';
import 'settings_pages.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final me = m.me;
    final store = ref.read(demoStoreProvider.notifier);
    final today = ref.watch(todayProvider);

    final Widget action = switch (me.journey) {
      Journey.pregnancy => FilledButton(
        onPressed: () async {
          final ok = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(l.deliveredConfirmTitle),
              content: Text(
                l.deliveredConfirmBody(context.formatLongDate(today)),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: Text(l.actionCancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: Text(l.actionConfirm),
                ),
              ],
            ),
          );
          if (ok == true) {
            me
              ..journey = Journey.postpartum
              ..journeyStart = today;
            store.updateProfile(me);
            if (context.mounted) showToast(context, l.deliveredSaved);
          }
        },
        child: Text(l.actionBabyDelivered, textAlign: TextAlign.center),
      ),
      Journey.postpartum => OutlinedButton(
        onPressed: () {
          me.journey = Journey.general;
          store.updateProfile(me);
        },
        child: Text(l.actionEndPostpartum, textAlign: TextAlign.center),
      ),
      Journey.general => OutlinedButton(
        onPressed: () => pushPage(context, const PregnancyInfoPage()),
        child: Text(l.actionImPregnant, textAlign: TextAlign.center),
      ),
    };

    Widget menu(List<(IconData, String, Widget)> items) => ListCard(
      rows: [
        for (final (icon, label, page) in items)
          ListRow(
            leading: Icon(icon, size: 22),
            title: label,
            trailing: Icon(Icons.chevron_right_rounded, color: p.muted),
            onTap: () => pushPage(context, page),
          ),
      ],
    );

    return Column(
      children: [
        TabTitleBar(title: l.navProfile),
        Expanded(
          child: ListView(
            key: const Key('profile-list'),
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              AppCard(
                color: p.roseTint,
                child: Column(
                  children: [
                    Avatar(me.name, size: 80, photoUrl: me.photoUrl),
                    const SizedBox(height: 8),
                    Text(
                      me.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      journeyLabel(l, me.journey),
                      style: TextStyle(color: p.muted),
                    ),
                    const SizedBox(height: 12),
                    action,
                  ],
                ),
              ),
              menu([
                (
                  Icons.person_outline_rounded,
                  l.menuPersonalInfo,
                  const PersonalInfoPage(),
                ),
                (
                  Icons.child_friendly_outlined,
                  l.menuPregnancyInfo,
                  const PregnancyInfoPage(),
                ),
                (
                  Icons.phone_outlined,
                  l.menuEmergencyContact,
                  const PersonalInfoPage(),
                ),
              ]),
              menu([
                (
                  Icons.event_outlined,
                  l.appointmentsTitle,
                  const AppointmentsPage(),
                ),
                (
                  Icons.medication_outlined,
                  l.medicationsTitle,
                  const MedsPage(),
                ),
                (
                  Icons.vaccines_outlined,
                  l.vaccinesTitle,
                  const VaccinesPage(),
                ),
                (
                  Icons.description_outlined,
                  l.documentsTitle,
                  const DocumentsPage(),
                ),
              ]),
              menu([
                (Icons.groups_outlined, l.menuCareTeam, const CareTeamPage()),
                (Icons.watch_outlined, l.devicesTitle, const DevicesPage()),
                (
                  Icons.notifications_none_rounded,
                  l.menuNotifications,
                  const NotificationsPage(),
                ),
                (
                  Icons.dark_mode_outlined,
                  l.menuAppearance,
                  const AppearancePage(),
                ),
                (
                  Icons.lock_outline_rounded,
                  l.securityTitle,
                  const SecurityPage(),
                ),
                (Icons.shield_outlined, l.menuPrivacy, const PrivacyPage()),
                (
                  Icons.hub_outlined,
                  l.connectionsTitle,
                  const ConnectionsPage(),
                ),
                (Icons.info_outline_rounded, l.menuAbout, const AboutPage()),
              ]),
              const SignOutButton(),
              Text(
                l.versionLabel(appVersion),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.5, color: p.muted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

const appVersion = '0.1.0 (1)';

/// Red outlined pill, icon and label centred together, with a confirm step.
class SignOutButton extends ConsumerWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton(
          key: const Key('sign-out'),
          style: OutlinedButton.styleFrom(
            foregroundColor: p.alert,
            side: BorderSide(color: p.alert, width: 1.2),
            shape: const StadiumBorder(),
          ),
          onPressed: () async {
            final ok = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(l.signOutConfirm),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: Text(l.actionCancel),
                  ),
                  FilledButton(
                    key: const Key('sign-out-confirm'),
                    onPressed: () => Navigator.pop(ctx, true),
                    child: Text(l.actionSignOut),
                  ),
                ],
              ),
            );
            if (ok == true) {
              ref.read(patientTabProvider.notifier).set(0);
              ref.read(doctorTabProvider.notifier).set(0);
              ref.read(sessionProvider.notifier).signOut();
              await ref.read(googleAuthProvider).signOut();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.logout_rounded, size: 20),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  l.actionSignOut,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
