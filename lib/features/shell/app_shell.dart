import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';
import '../calendar/calendar_screen.dart';
import '../calories/presentation/calories_screen.dart';
import '../create/create_sheet.dart';
import '../doctor/doctor_home_screen.dart';
import '../home/home_screen.dart';
import '../profile/application/profile_controller.dart';
import '../profile/domain/user_profile.dart';
import '../profile/presentation/profile_screen.dart';

enum AppTab { home, calendar, calories, profile }

final currentTabProvider = NotifierProvider<CurrentTab, AppTab>(CurrentTab.new);

class CurrentTab extends Notifier<AppTab> {
  @override
  AppTab build() => AppTab.home;

  void select(AppTab tab) => state = tab;
}

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final tab = ref.watch(currentTabProvider);
    final isDoctor = ref.watch(profileProvider).role == UserRole.doctor;
    final titles = {
      AppTab.home: isDoctor ? l.doctorDashboard : l.navHome,
      AppTab.calendar: l.navCalendar,
      AppTab.calories: l.navCalories,
      AppTab.profile: l.profileTitle,
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[tab]!),
        actions: const [LanguageSwitcher()],
      ),
      body: IndexedStack(
        index: tab.index,
        children: [
          isDoctor ? const DoctorHomeScreen() : const HomeScreen(),
          const CalendarScreen(),
          const CaloriesScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: _BottomNav(
        current: tab,
        onSelect: ref.read(currentTabProvider.notifier).select,
        onCreate: () => showCreateSheet(context),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.current,
    required this.onSelect,
    required this.onCreate,
  });

  final AppTab current;
  final ValueChanged<AppTab> onSelect;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    Widget item(AppTab tab, IconData icon, IconData active, String label) =>
        Expanded(
          child: _NavItem(
            icon: current == tab ? active : icon,
            label: label,
            selected: current == tab,
            onTap: () => onSelect(tab),
          ),
        );
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 76,
          child: Row(
            children: [
              item(
                AppTab.home,
                Icons.home_outlined,
                Icons.home_rounded,
                l.navHome,
              ),
              item(
                AppTab.calendar,
                Icons.calendar_month_outlined,
                Icons.calendar_month,
                l.navCalendar,
              ),
              Expanded(child: CreateButton(onPressed: onCreate)),
              item(
                AppTab.calories,
                Icons.local_fire_department_outlined,
                Icons.local_fire_department,
                l.navCalories,
              ),
              item(
                AppTab.profile,
                Icons.person_outline,
                Icons.person,
                l.navProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.roseDeep : AppColors.muted;
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.5,
                color: color,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The emphasised centre button: scales down on press and glows softly.
class CreateButton extends StatefulWidget {
  const CreateButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<CreateButton> createState() => _CreateButtonState();
}

class _CreateButtonState extends State<CreateButton> {
  bool _pressed = false;

  void _setPressed(bool v) => setState(() => _pressed = v);

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Semantics(
      button: true,
      label: l.navCreate,
      child: GestureDetector(
        onTapDown: (_) => _setPressed(true),
        onTapCancel: () => _setPressed(false),
        onTapUp: (_) {
          _setPressed(false);
          widget.onPressed();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: _pressed ? 0.9 : 1,
              duration: const Duration(milliseconds: 140),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.rose,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.rose.withValues(
                        alpha: _pressed ? 0.55 : 0.3,
                      ),
                      blurRadius: _pressed ? 22 : 14,
                      spreadRadius: _pressed ? 3 : 0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(height: 2),
            ExcludeSemantics(
              child: Text(
                l.navCreate,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: AppColors.roseDeep,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
