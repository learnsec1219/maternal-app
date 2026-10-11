import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';
import '../../data/models.dart';
import '../../data/session.dart';
import '../assistant/assistant_page.dart';
import '../calendar/calendar_screen.dart';
import '../calories/calories_screen.dart';
import '../calories/food_form.dart';
import '../home/home_screen.dart';
import '../patient/patient_data.dart';
import '../profile/profile_screen.dart';
import '../profile/watch_section.dart';
import '../records/care_pages.dart';
import '../records/health_pages.dart';
import '../records/pregnancy_pages.dart';

/// Home, Calendar, the raised Create button, Calories and Profile.
class PatientShell extends ConsumerStatefulWidget {
  const PatientShell({super.key});

  @override
  ConsumerState<PatientShell> createState() => _PatientShellState();
}

class _PatientShellState extends ConsumerState<PatientShell> {
  @override
  void initState() {
    super.initState();
    // Ask once whether to pair a Bluetooth watch.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) askForWatchOnce(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tab = ref.watch(patientTabProvider);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: tab,
          children: const [
            HomeScreen(),
            CalendarScreen(),
            CaloriesScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: const _PatientNav(),
    );
  }
}

class _PatientNav extends ConsumerWidget {
  const _PatientNav();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final tab = ref.watch(patientTabProvider);
    void go(int i) => ref.read(patientTabProvider.notifier).set(i);
    return Material(
      color: p.card,
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: p.line)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 70,
            child: Row(
              children: [
                NavItem(
                  Icons.home_outlined,
                  Icons.home_rounded,
                  l.navHome,
                  tab == 0,
                  () => go(0),
                  key: const Key('nav-home'),
                ),
                NavItem(
                  Icons.calendar_month_outlined,
                  Icons.calendar_month_rounded,
                  l.navCalendar,
                  tab == 1,
                  () => go(1),
                  key: const Key('nav-calendar'),
                ),
                Expanded(
                  child: Semantics(
                    button: true,
                    label: l.navCreate,
                    child: InkWell(
                      key: const Key('nav-create'),
                      onTap: () => showCreateSheet(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: p.rose,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: p.rose.withValues(alpha: .35),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.add_rounded,
                              color: p.onRose,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 2),
                          _NavLabel(l.navCreate, color: p.muted, bold: false),
                        ],
                      ),
                    ),
                  ),
                ),
                NavItem(
                  Icons.local_fire_department_outlined,
                  Icons.local_fire_department_rounded,
                  l.navCalories,
                  tab == 2,
                  () => go(2),
                  key: const Key('nav-calories'),
                ),
                NavItem(
                  Icons.person_outline_rounded,
                  Icons.person_rounded,
                  l.navProfile,
                  tab == 3,
                  () => go(3),
                  key: const Key('nav-profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// One bottom-bar button. The label shrinks to fit rather than wrapping.
class NavItem extends StatelessWidget {
  const NavItem(
    this.icon,
    this.activeIcon,
    this.label,
    this.selected,
    this.onTap, {
    super.key,
  });

  final IconData icon, activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.pal;
    final c = selected ? p.rose : p.muted;
    return Expanded(
      child: Semantics(
        selected: selected,
        button: true,
        label: label,
        excludeSemantics: true,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(selected ? activeIcon : icon, color: c, size: 24),
              const SizedBox(height: 3),
              _NavLabel(label, color: c, bold: selected),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLabel extends StatelessWidget {
  const _NavLabel(this.text, {required this.color, required this.bold});
  final String text;
  final Color color;
  final bool bold;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        maxLines: 1,
        textScaler: TextScaler.noScaling,
        style: TextStyle(
          fontSize: 11.5,
          color: color,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    ),
  );
}

/// The Create sheet: grouped tiles that scroll on short screens, so nothing
/// overflows on any phone.
Future<void> showCreateSheet(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const CreateSheet(),
    );

class CreateSheet extends ConsumerWidget {
  const CreateSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final preg = ref.watch(meProvider)?.journey == Journey.pregnancy;
    void open(Widget page) {
      final nav = Navigator.of(context);
      nav.pop();
      nav.push(MaterialPageRoute<void>(builder: (_) => page));
    }

    CreateTile tile(
      IconData i,
      String label,
      Color bg,
      Widget page,
      String key,
    ) => CreateTile(
      icon: i,
      label: label,
      background: bg,
      onTap: () => open(page),
      tileKey: Key(key),
    );

    final groups = <(String, List<CreateTile>)>[
      (
        l.createGroupHealth,
        [
          tile(
            Icons.monitor_heart_outlined,
            l.createHealthLog,
            p.roseSoft,
            const AddLogPage(),
            'create-healthlog',
          ),
          tile(
            Icons.healing_outlined,
            l.createSymptoms,
            p.pendingSoft,
            const SymptomsPage(),
            'create-symptoms',
          ),
          tile(
            Icons.medication_outlined,
            l.createMedication,
            p.lavender,
            const MedsPage(),
            'create-medication',
          ),
          if (!preg)
            tile(
              Icons.water_drop_outlined,
              l.createPeriod,
              p.periodSoft,
              const PeriodPage(),
              'create-period',
            ),
          tile(
            Icons.chat_bubble_outline_rounded,
            l.createAskAi,
            p.sky,
            const AssistantPage(),
            'create-ai',
          ),
        ],
      ),
      if (preg)
        (
          l.createGroupPregnancy,
          [
            tile(
              Icons.child_care_rounded,
              l.createKickCounter,
              p.peach,
              const KickPage(),
              'create-kicks',
            ),
            tile(
              Icons.timer_outlined,
              l.createContractions,
              p.roseTint,
              const ContractionPage(),
              'create-contractions',
            ),
            tile(
              Icons.insights_rounded,
              l.createUltrasound,
              p.sky,
              const AddScanPage(),
              'create-scan',
            ),
            tile(
              Icons.flag_outlined,
              l.createMilestone,
              p.butter,
              const MilestonePage(),
              'create-milestone',
            ),
          ],
        ),
      (
        l.createGroupCare,
        [
          tile(
            Icons.event_outlined,
            l.createAppointment,
            p.sage,
            const AppointmentFormPage(),
            'create-appointment',
          ),
          tile(
            Icons.vaccines_outlined,
            l.createVaccine,
            p.sky,
            const VaccinesPage(),
            'create-vaccine',
          ),
          tile(
            Icons.description_outlined,
            l.createDocument,
            p.sand,
            const DocumentsPage(),
            'create-document',
          ),
        ],
      ),
      (
        l.createGroupNutrition,
        [
          tile(
            Icons.restaurant_outlined,
            l.createFood,
            p.sand,
            const FoodFormPage(),
            'create-food',
          ),
          tile(
            Icons.local_drink_outlined,
            l.createWater,
            p.sky,
            const AddLogPage(type: ObsType.water),
            'create-water',
          ),
        ],
      ),
    ];

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * .88,
      ),
      child: SingleChildScrollView(
        key: const Key('create-sheet'),
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.createTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            for (final (title, tiles) in groups) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 16, 2, 8),
                child: Text(
                  title,
                  style: TextStyle(
                    color: p.muted,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TwoColumn(children: tiles),
            ],
          ],
        ),
      ),
    );
  }
}

class CreateTile extends StatelessWidget {
  const CreateTile({
    super.key,
    required this.icon,
    required this.label,
    required this.background,
    required this.onTap,
    this.tileKey,
  });

  final IconData icon;
  final String label;
  final Color background;
  final VoidCallback onTap;
  final Key? tileKey;

  @override
  Widget build(BuildContext context) => Material(
    key: tileKey,
    color: background,
    borderRadius: BorderRadius.circular(16),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 64),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(icon, size: 22, color: context.pal.ink),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
