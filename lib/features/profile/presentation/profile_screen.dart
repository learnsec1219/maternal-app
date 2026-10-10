import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/util/clock.dart';
import '../../../core/util/l10n.dart';
import '../../../core/util/labels.dart';
import '../../../core/widgets/common.dart';
import '../../calories/domain/calorie_target.dart';
import '../application/profile_controller.dart';
import '../domain/user_profile.dart';

/// Editable profile. The multi-step onboarding flow from the spec will reuse
/// these fields in a later step.
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late UserProfile _draft = ref.read(profileProvider);
  late final _name = TextEditingController(text: _draft.name);
  late final _height = TextEditingController(text: _fmt(_draft.heightCm));
  late final _weight = TextEditingController(text: _fmt(_draft.preWeightKg));
  late final _calorie = TextEditingController(
    text: _draft.calorieTargetOverride?.toString() ?? '',
  );

  static String _fmt(double? v) => v == null
      ? ''
      : (v == v.roundToDouble() ? v.toInt().toString() : v.toString());

  @override
  void dispose() {
    for (final c in [_name, _height, _weight, _calorie]) {
      c.dispose();
    }
    super.dispose();
  }

  double? _parse(String raw) =>
      double.tryParse(raw.trim().replaceAll(',', '.'));

  String? Function(String?) _range(double min, double max) => (v) {
    if (v == null || v.trim().isEmpty) return null;
    final n = _parse(v);
    return n == null || n < min || n > max ? context.l10n.invalidNumber : null;
  };

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final calorie = int.tryParse(_calorie.text.trim());
    final profile = _draft.copyWith(
      name: _name.text.trim(),
      heightCm: _parse(_height.text),
      preWeightKg: _parse(_weight.text),
      calorieTargetOverride: () => calorie,
      // Keep the role chosen live in the toggle above.
      role: ref.read(profileProvider).role,
    );
    ref.read(profileProvider.notifier).save(profile);
    setState(() => _draft = profile);
    showSavedSnack(context, context.l10n.saved);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final today = ref.watch(todayProvider);
    final role = ref.watch(profileProvider).role;
    final numeric = [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))];
    const gap = SizedBox(height: 14);

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
        children: [
          SectionTitle(l.role),
          SegmentedButton<UserRole>(
            segments: [
              ButtonSegment(
                value: UserRole.patient,
                icon: const Icon(Icons.person_outline),
                label: Text(l.rolePatient),
              ),
              ButtonSegment(
                value: UserRole.doctor,
                icon: const Icon(Icons.medical_services_outlined),
                label: Text(l.roleDoctor),
              ),
            ],
            selected: {role},
            onSelectionChanged: (s) =>
                ref.read(profileProvider.notifier).setRole(s.first),
          ),
          SectionTitle(l.profileTitle),
          TextFormField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(labelText: l.fullName),
          ),
          gap,
          DateField(
            label: l.dateOfBirth,
            value: _draft.dateOfBirth,
            firstDate: DateTime(today.year - 70),
            lastDate: DateTime(today.year - 10, today.month, today.day),
            onChanged: (d) =>
                setState(() => _draft = _draft.copyWith(dateOfBirth: d)),
          ),
          gap,
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _height,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: numeric,
                  decoration: InputDecoration(labelText: l.heightCm),
                  validator: _range(100, 220),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _weight,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: numeric,
                  decoration: InputDecoration(labelText: l.preWeightKg),
                  validator: _range(25, 250),
                ),
              ),
            ],
          ),
          SectionTitle(l.pregnantQuestion),
          SegmentedButton<bool>(
            segments: [
              ButtonSegment(value: true, label: Text(l.yes)),
              ButtonSegment(value: false, label: Text(l.no)),
            ],
            selected: {_draft.isPregnant},
            showSelectedIcon: false,
            onSelectionChanged: (s) =>
                setState(() => _draft = _draft.copyWith(isPregnant: s.first)),
          ),
          if (_draft.isPregnant) ...[
            gap,
            DateField(
              label: l.expectedDueDate,
              value: _draft.dueDate,
              firstDate: today.subtract(const Duration(days: 30)),
              lastDate: today.add(const Duration(days: 300)),
              onChanged: (d) =>
                  setState(() => _draft = _draft.copyWith(dueDate: d)),
            ),
            gap,
            Text(
              l.numberOfBabies,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: [
                for (final n in [1, 2, 3, 4])
                  ButtonSegment(
                    value: n,
                    label: Text(
                      l.babiesCount(n == 4 ? '4+' : '$n'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
              selected: {_draft.babies.clamp(1, 4)},
              showSelectedIcon: false,
              onSelectionChanged: (s) =>
                  setState(() => _draft = _draft.copyWith(babies: s.first)),
            ),
          ],
          SectionTitle(l.activityLevel),
          SegmentedButton<ActivityLevel>(
            segments: [
              for (final a in ActivityLevel.values)
                ButtonSegment(value: a, label: Text(l.activity(a))),
            ],
            selected: {_draft.activity},
            showSelectedIcon: false,
            onSelectionChanged: (s) =>
                setState(() => _draft = _draft.copyWith(activity: s.first)),
          ),
          gap,
          TextFormField(
            controller: _calorie,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: l.customCalorieTarget),
            validator: _range(800, 5000),
          ),
          const SizedBox(height: 24),
          FilledButton(onPressed: _save, child: Text(l.saveProfile)),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lock_outline, size: 18, color: AppColors.muted),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l.privacyNote,
                  style: const TextStyle(fontSize: 12, color: AppColors.muted),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
