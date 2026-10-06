import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';
import '../calories/presentation/food_form.dart';
import '../health_log/domain/health_log.dart';
import '../health_log/presentation/health_log_form.dart';
import '../health_log/presentation/symptom_form.dart';
import '../cycle/presentation/period_form.dart';

Future<void> showCreateSheet(BuildContext context) => showModalBottomSheet(
  context: context,
  showDragHandle: true,
  backgroundColor: AppColors.background,
  isScrollControlled: true,
  sheetAnimationStyle: const AnimationStyle(
    duration: Duration(milliseconds: 320),
    reverseDuration: Duration(milliseconds: 220),
  ),
  builder: (_) => const CreateSheet(),
);

class _CreateOption {
  const _CreateOption(this.icon, this.label, this.color, [this.page]);

  final IconData icon;
  final String label;
  final Color color;

  /// Null while the feature is still to be built.
  final WidgetBuilder? page;
}

class CreateSheet extends StatelessWidget {
  const CreateSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final options = [
      _CreateOption(
        Icons.monitor_heart_outlined,
        l.createHealthLog,
        const Color(0xFFF6E8ED),
        (_) => const HealthLogForm(),
      ),
      _CreateOption(
        Icons.sick_outlined,
        l.createSymptoms,
        const Color(0xFFFCEEDC),
        (_) => const SymptomForm(),
      ),
      _CreateOption(
        Icons.water_drop_outlined,
        l.createPeriod,
        const Color(0xFFFBE3EA),
        (_) => const PeriodForm(),
      ),
      _CreateOption(
        Icons.restaurant_outlined,
        l.createMeal,
        const Color(0xFFE6F3EC),
        (_) => const FoodForm(),
      ),
      _CreateOption(
        Icons.pregnant_woman_outlined,
        l.createPregnancyRecord,
        const Color(0xFFE8F2FB),
        (_) => const HealthLogForm(initial: HealthMetric.fetalMovement),
      ),
      _CreateOption(
        Icons.vaccines_outlined,
        l.createVaccine,
        const Color(0xFFF1EEF8),
      ),
      _CreateOption(
        Icons.event_outlined,
        l.createAppointment,
        const Color(0xFFF1EEF8),
      ),
      _CreateOption(
        Icons.description_outlined,
        l.createDocument,
        const Color(0xFFF1EEF8),
      ),
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.createTitle,
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 10,
              childAspectRatio: 0.72,
              children: [
                for (final (i, o) in options.indexed)
                  _StaggeredIn(
                    index: i,
                    child: _OptionTile(option: o),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({required this.option});

  final _CreateOption option;

  @override
  Widget build(BuildContext context) {
    final page = option.page;
    final enabled = page != null;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        if (page == null) {
          showSavedSnack(context, context.l10n.comingSoon);
          return;
        }
        final navigator = Navigator.of(context);
        navigator.pop();
        navigator.push(
          MaterialPageRoute(builder: page, fullscreenDialog: true),
        );
      },
      child: Opacity(
        opacity: enabled ? 1 : 0.55,
        child: Column(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: option.color,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(option.icon, color: AppColors.roseDeep, size: 28),
            ),
            const SizedBox(height: 6),
            Text(
              option.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            if (!enabled)
              Text(
                context.l10n.soonBadge,
                style: const TextStyle(fontSize: 10, color: AppColors.muted),
              ),
          ],
        ),
      ),
    );
  }
}

/// Fades and lifts each option in with a short stagger.
class _StaggeredIn extends StatelessWidget {
  const _StaggeredIn({required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0, end: 1),
    duration: Duration(milliseconds: 220 + index * 35),
    curve: Curves.easeOutCubic,
    builder: (_, t, c) => Opacity(
      opacity: t,
      child: Transform.translate(offset: Offset(0, 12 * (1 - t)), child: c),
    ),
    child: child,
  );
}
