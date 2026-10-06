import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/util/ids.dart';
import '../../../core/util/l10n.dart';
import '../../../core/util/labels.dart';
import '../../../core/widgets/common.dart';
import '../application/calories_controller.dart';
import '../domain/food_entry.dart';

class FoodForm extends ConsumerStatefulWidget {
  const FoodForm({super.key, this.meal});

  final Meal? meal;

  @override
  ConsumerState<FoodForm> createState() => _FoodFormState();
}

class _FoodFormState extends ConsumerState<FoodForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _portion = TextEditingController();
  final _kcal = TextEditingController();
  final _protein = TextEditingController();
  final _carbs = TextEditingController();
  final _fat = TextEditingController();
  late Meal _meal = widget.meal ?? _mealForNow();

  static Meal _mealForNow() {
    final h = DateTime.now().hour;
    if (h < 11) return Meal.breakfast;
    if (h < 16) return Meal.lunch;
    return Meal.dinner;
  }

  @override
  void dispose() {
    for (final c in [_name, _portion, _kcal, _protein, _carbs, _fat]) {
      c.dispose();
    }
    super.dispose();
  }

  double _num(TextEditingController c) =>
      double.tryParse(c.text.trim().replaceAll(',', '.')) ?? 0;

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    ref
        .read(foodEntriesProvider.notifier)
        .add(
          FoodEntry(
            id: newId(),
            date: DateTime.now(),
            meal: _meal,
            name: _name.text.trim(),
            portion: _portion.text.trim().isEmpty ? null : _portion.text.trim(),
            kcal: _num(_kcal).round(),
            proteinG: _num(_protein),
            carbsG: _num(_carbs),
            fatG: _num(_fat),
          ),
        );
    showSavedSnack(context, context.l10n.saved);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final numeric = [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))];
    String? optionalNumber(String? v) {
      if (v == null || v.trim().isEmpty) return null;
      final n = double.tryParse(v.trim().replaceAll(',', '.'));
      return n == null || n < 0 || n > 1000 ? l.invalidNumber : null;
    }

    Widget macro(TextEditingController c, String label) => Expanded(
      child: TextFormField(
        controller: c,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: numeric,
        decoration: InputDecoration(labelText: label),
        validator: optionalNumber,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l.addFood)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final m in Meal.values)
                  ChoiceChip(
                    label: Text(l.meal(m)),
                    selected: m == _meal,
                    onSelected: (_) => setState(() => _meal = m),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: l.foodName),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? l.required : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _portion,
                    decoration: InputDecoration(labelText: l.portion),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _kcal,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(labelText: l.caloriesKcal),
                    validator: (v) {
                      final n = int.tryParse(v?.trim() ?? '');
                      if (n == null) return l.required;
                      return n > 5000 ? l.invalidNumber : null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                macro(_protein, l.proteinG),
                const SizedBox(width: 10),
                macro(_carbs, l.carbsG),
                const SizedBox(width: 10),
                macro(_fat, l.fatG),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _save, child: Text(l.save)),
          ],
        ),
      ),
    );
  }
}
