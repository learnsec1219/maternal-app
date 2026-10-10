import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/util/clock.dart';
import '../../core/util/l10n.dart';
import '../../core/util/labels.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../../data/models.dart';
import '../patient/patient_data.dart';
import '../records/health_pages.dart';

class FoodFormPage extends ConsumerStatefulWidget {
  const FoodFormPage({super.key, this.meal, this.day});
  final Meal? meal;
  final DateTime? day;

  @override
  ConsumerState<FoodFormPage> createState() => _FoodFormPageState();
}

class _FoodFormPageState extends ConsumerState<FoodFormPage> {
  late Meal _meal = widget.meal ?? Meal.lunch;
  final _name = TextEditingController(),
      _portion = TextEditingController(),
      _kcal = TextEditingController(),
      _p = TextEditingController(),
      _c = TextEditingController(),
      _f = TextEditingController();
  String? _error;

  @override
  void dispose() {
    for (final c in [_name, _portion, _kcal, _p, _c, _f]) {
      c.dispose();
    }
    super.dispose();
  }

  String _n(double v) => v % 1 == 0 ? v.toStringAsFixed(0) : v.toString();

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final m = mineOf(ref);
    final recent = <String, FoodEntry>{};
    for (final f in m.of(m.data.foods).reversed) {
      recent.putIfAbsent(f.name, () => f);
    }
    const numeric = TextInputType.numberWithOptions(decimal: true);
    return PageScaffold(
      title: l.addFoodTitle,
      bottom: PrimaryButton(
        l.actionSave,
        key: const Key('food-save'),
        onPressed: () {
          final kcal = parseNumber(_kcal.text);
          if (_name.text.trim().isEmpty || kcal == null) {
            setState(() => _error = l.errorRequired);
            return;
          }
          final DateTime d = widget.day ?? ref.read(todayProvider);
          final now = DateTime.now();
          ref
              .read(demoStoreProvider.notifier)
              .addFood(
                FoodEntry(
                  m.me.id,
                  DateTime(d.year, d.month, d.day, now.hour, now.minute),
                  _meal,
                  _name.text.trim(),
                  kcal.roundToDouble(),
                  protein: parseNumber(_p.text) ?? 0,
                  carbs: parseNumber(_c.text) ?? 0,
                  fat: parseNumber(_f.text) ?? 0,
                  portion: _portion.text.trim().isEmpty
                      ? null
                      : _portion.text.trim(),
                ),
              );
          showToast(context, l.savedMessage);
          Navigator.pop(context);
        },
      ),
      children: [
        LabeledField(
          label: l.fieldMeal,
          child: ChoiceChips<Meal>(
            options: [for (final x in Meal.values) (x, l.meal(x))],
            selected: _meal,
            onSelected: (x) => setState(() => _meal = x),
          ),
        ),
        if (recent.isNotEmpty)
          LabeledField(
            label: l.recentFoods,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final f in recent.values.take(6))
                  SelectChip(
                    label: f.name,
                    selected: false,
                    onTap: () => setState(() {
                      _name.text = f.name;
                      _kcal.text = _n(f.kcal);
                      _p.text = _n(f.protein);
                      _c.text = _n(f.carbs);
                      _f.text = _n(f.fat);
                    }),
                  ),
              ],
            ),
          ),
        AppTextField(
          fieldKey: const Key('food-name'),
          label: l.fieldFoodName,
          controller: _name,
        ),
        AppTextField(
          label: l.fieldPortion,
          controller: _portion,
          hint: l.portionHint,
        ),
        AppTextField(
          fieldKey: const Key('food-kcal'),
          label: '${l.fieldCalories} (kcal)',
          controller: _kcal,
          keyboardType: numeric,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTextField(
                label: '${l.macroProtein} g',
                controller: _p,
                keyboardType: numeric,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTextField(
                label: '${l.macroCarbs} g',
                controller: _c,
                keyboardType: numeric,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTextField(
                label: '${l.macroFat} g',
                controller: _f,
                keyboardType: numeric,
              ),
            ),
          ],
        ),
        if (_error != null) InfoBanner(_error!, tone: Tone.alert),
      ],
    );
  }
}
