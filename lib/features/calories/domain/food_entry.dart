enum Meal { breakfast, lunch, dinner, snack, drink }

class FoodEntry {
  const FoodEntry({
    required this.id,
    required this.date,
    required this.meal,
    required this.name,
    required this.kcal,
    this.portion,
    this.proteinG = 0,
    this.carbsG = 0,
    this.fatG = 0,
  });

  final String id;
  final DateTime date;
  final Meal meal;
  final String name;
  final String? portion;
  final int kcal;
  final double proteinG;
  final double carbsG;
  final double fatG;

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'meal': meal.name,
    'name': name,
    if (portion != null) 'portion': portion,
    'kcal': kcal,
    'proteinG': proteinG,
    'carbsG': carbsG,
    'fatG': fatG,
  };

  factory FoodEntry.fromJson(Map<String, dynamic> j) => FoodEntry(
    id: j['id'] as String,
    date: DateTime.parse(j['date'] as String),
    meal: Meal.values.asNameMap()[j['meal']] ?? Meal.snack,
    name: j['name'] as String,
    portion: j['portion'] as String?,
    kcal: (j['kcal'] as num).toInt(),
    proteinG: (j['proteinG'] as num?)?.toDouble() ?? 0,
    carbsG: (j['carbsG'] as num?)?.toDouble() ?? 0,
    fatG: (j['fatG'] as num?)?.toDouble() ?? 0,
  );
}

class DayTotals {
  const DayTotals(this.kcal, this.proteinG, this.carbsG, this.fatG);

  factory DayTotals.of(Iterable<FoodEntry> entries) => entries.fold(
    const DayTotals(0, 0, 0, 0),
    (t, e) => DayTotals(
      t.kcal + e.kcal,
      t.proteinG + e.proteinG,
      t.carbsG + e.carbsG,
      t.fatG + e.fatG,
    ),
  );

  final int kcal;
  final double proteinG;
  final double carbsG;
  final double fatG;
}
