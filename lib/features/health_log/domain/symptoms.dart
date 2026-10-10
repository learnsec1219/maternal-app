/// Symptoms the user can log. Warning symptoms show predefined guidance to
/// seek care; the app never diagnoses.
enum SymptomKind {
  nausea,
  fatigue,
  backPain,
  heartburn,
  cramps,
  headache,
  reducedMovements(warning: true),
  bleeding(warning: true),
  severeHeadacheVision(warning: true),
  suddenSwelling(warning: true),
  severeAbdominalPain(warning: true),
  fluidLeak(warning: true),
  feverUnwell(warning: true);

  const SymptomKind({this.warning = false});
  final bool warning;

  static List<SymptomKind> get warnings =>
      values.where((s) => s.warning).toList();
}
