// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Maternal';

  @override
  String get navHome => 'Home';

  @override
  String get navCalendar => 'Calendar';

  @override
  String get navCreate => 'Create';

  @override
  String get navCalories => 'Calories';

  @override
  String get navProfile => 'Profile';

  @override
  String get createTitle => 'What would you like to add?';

  @override
  String get createHealthLog => 'Health log';

  @override
  String get createSymptoms => 'Symptoms';

  @override
  String get createPeriod => 'Period';

  @override
  String get createMeal => 'Meal';

  @override
  String get createPregnancyRecord => 'Pregnancy record';

  @override
  String get createVaccine => 'Vaccine';

  @override
  String get createAppointment => 'Appointment';

  @override
  String get createDocument => 'Medical document';

  @override
  String get comingSoon =>
      'Coming soon. This part is planned for a later step.';

  @override
  String get soonBadge => 'Soon';

  @override
  String homeGreeting(String name) {
    return 'Hello, $name';
  }

  @override
  String get homeGreetingNoName => 'Hello';

  @override
  String get pregnancyOverview => 'Pregnancy overview';

  @override
  String weeksDays(int weeks, int days) {
    return '$weeks weeks $days days';
  }

  @override
  String dueDateLabel(String date) {
    return 'Due date $date';
  }

  @override
  String daysToGo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days to go',
      one: '1 day to go',
      zero: 'Due today',
    );
    return '$_temp0';
  }

  @override
  String daysPastDue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days past due date',
      one: '1 day past due date',
    );
    return '$_temp0';
  }

  @override
  String get trimesterFirst => 'First trimester';

  @override
  String get trimesterSecond => 'Second trimester';

  @override
  String get trimesterThird => 'Third trimester';

  @override
  String babiesCount(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '1': 'Single',
      '2': 'Twins',
      '3': 'Triplets',
      'other': '$count babies',
    });
    return '$_temp0';
  }

  @override
  String get setDueDatePrompt =>
      'Add your due date in Profile to see your pregnancy progress.';

  @override
  String get cycleOverview => 'Cycle overview';

  @override
  String nextPeriodEstimate(String date) {
    return 'Next period (estimate): $date';
  }

  @override
  String get noCycleData =>
      'Log a period from Create to start cycle estimates.';

  @override
  String get todaysHealth => 'Today\'s health';

  @override
  String get noData => 'No data';

  @override
  String get metricWeight => 'Weight';

  @override
  String get metricBloodPressure => 'Blood pressure';

  @override
  String get metricHeartRate => 'Heart rate';

  @override
  String get metricGlucose => 'Blood glucose';

  @override
  String get metricTemperature => 'Temperature';

  @override
  String get metricSpo2 => 'SpO2';

  @override
  String get metricSleep => 'Sleep';

  @override
  String get metricWater => 'Water';

  @override
  String get metricFetalMovement => 'Fetal movements';

  @override
  String get metricSymptom => 'Symptom';

  @override
  String get statusLow => 'Low';

  @override
  String get statusNormal => 'Typical';

  @override
  String get statusHigh => 'High';

  @override
  String get todaysTasks => 'Today\'s tasks';

  @override
  String get taskLogBp => 'Record blood pressure';

  @override
  String get taskKicks => 'Record fetal movements';

  @override
  String get taskWater => 'Drink 8 glasses of water';

  @override
  String get taskLogMeal => 'Log your meals';

  @override
  String get recentActivity => 'Latest health activity';

  @override
  String get noActivity =>
      'Nothing logged yet. Tap Create to add your first entry.';

  @override
  String get warningSigns => 'Warning signs';

  @override
  String get warningSignsIntro =>
      'Seek medical advice if you notice any of these. This app does not diagnose.';

  @override
  String get disclaimer =>
      'Prototype for clinical workflow design. Not a registered medical device.';

  @override
  String get healthLogTitle => 'Add health log';

  @override
  String get measurement => 'Measurement';

  @override
  String get systolic => 'Systolic (mmHg)';

  @override
  String get diastolic => 'Diastolic (mmHg)';

  @override
  String valueWithUnit(String unit) {
    return 'Value ($unit)';
  }

  @override
  String get noteOptional => 'Note (optional)';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get invalidNumber => 'Enter a valid number';

  @override
  String get required => 'Required';

  @override
  String get saved => 'Saved';

  @override
  String get quickKick => 'Add 1 kick';

  @override
  String kicksToday(int count) {
    return '$count kicks today';
  }

  @override
  String get symptomTitle => 'Log a symptom';

  @override
  String get symptomCommon => 'Common';

  @override
  String get symptomWarning => 'Needs medical attention';

  @override
  String get symptomLogged => 'Symptom logged';

  @override
  String get sym_nausea => 'Nausea';

  @override
  String get sym_fatigue => 'Fatigue';

  @override
  String get sym_backPain => 'Back pain';

  @override
  String get sym_heartburn => 'Heartburn';

  @override
  String get sym_cramps => 'Cramps';

  @override
  String get sym_headache => 'Headache';

  @override
  String get sym_reducedMovements => 'Reduced or no fetal movements';

  @override
  String get sym_bleeding => 'Vaginal bleeding';

  @override
  String get sym_severeHeadacheVision => 'Severe headache with vision changes';

  @override
  String get sym_suddenSwelling => 'Sudden swelling of face, hands or feet';

  @override
  String get sym_severeAbdominalPain => 'Severe or persistent abdominal pain';

  @override
  String get sym_fluidLeak => 'Watery vaginal discharge or fluid leak';

  @override
  String get sym_feverUnwell => 'Fever or feeling very unwell';

  @override
  String get act_reducedMovements =>
      'Contact your hospital labour ward or obstetric team immediately.';

  @override
  String get act_bleeding =>
      'Go to the nearest hospital emergency department or labour ward now.';

  @override
  String get act_severeHeadacheVision => 'Seek urgent medical review today.';

  @override
  String get act_suddenSwelling =>
      'Contact your care team today for a blood pressure and urine check.';

  @override
  String get act_severeAbdominalPain => 'Seek urgent medical attention.';

  @override
  String get act_fluidLeak => 'Contact your hospital labour ward immediately.';

  @override
  String get act_feverUnwell => 'Contact your care team the same day.';

  @override
  String get periodTitle => 'Log period';

  @override
  String get periodStart => 'Start date';

  @override
  String get periodEnd => 'End date (optional)';

  @override
  String get flow => 'FlowLevel';

  @override
  String get flow_spotting => 'Spotting';

  @override
  String get flow_light => 'Light';

  @override
  String get flow_medium => 'Medium';

  @override
  String get flow_heavy => 'Heavy';

  @override
  String get endBeforeStart => 'End date can\'t be before the start date';

  @override
  String get legendPeriod => 'Period';

  @override
  String get legendPredicted => 'Predicted period';

  @override
  String get legendFertile => 'Fertile window';

  @override
  String get legendOvulation => 'Ovulation';

  @override
  String avgCycle(int days) {
    return 'Average cycle $days days';
  }

  @override
  String avgPeriod(int days) {
    return 'Average period $days days';
  }

  @override
  String get estimatesNote =>
      'Predictions are estimates, not medical facts. Don\'t rely on them for contraception.';

  @override
  String get irregularNote =>
      'Your cycles have varied significantly. Predictions may be less accurate.';

  @override
  String get dayEmpty => 'Nothing recorded on this day.';

  @override
  String get logPeriodThisDay => 'Log period starting this day';

  @override
  String get pregnancyTimeline => 'Pregnancy timeline';

  @override
  String milestoneWeek(int week) {
    return 'Week $week';
  }

  @override
  String get ms_firstTrimesterEnds => 'First trimester ends';

  @override
  String get ms_halfway => 'Halfway point';

  @override
  String get ms_thirdTrimester => 'Third trimester begins';

  @override
  String get ms_fullTerm => 'Full term';

  @override
  String get ms_dueDate => 'Due date';

  @override
  String get calorieTarget => 'Daily target';

  @override
  String get consumed => 'Consumed';

  @override
  String get remaining => 'Remaining';

  @override
  String overBy(int kcal) {
    return 'Over by $kcal kcal';
  }

  @override
  String kcalValue(int kcal) {
    return '$kcal kcal';
  }

  @override
  String get meal_breakfast => 'Breakfast';

  @override
  String get meal_lunch => 'Lunch';

  @override
  String get meal_dinner => 'Dinner';

  @override
  String get meal_snack => 'Snacks';

  @override
  String get meal_drink => 'Drinks';

  @override
  String get addFood => 'Add food';

  @override
  String get foodName => 'Food name';

  @override
  String get portion => 'Portion (optional)';

  @override
  String get caloriesKcal => 'Calories (kcal)';

  @override
  String get proteinG => 'Protein (g)';

  @override
  String get carbsG => 'Carbs (g)';

  @override
  String get fatG => 'Fat (g)';

  @override
  String macros(String p, String c, String f) {
    return 'Protein $p g · Carbs $c g · Fat $f g';
  }

  @override
  String get targetEstimateNote =>
      'This target is an estimate from your profile, not a medical prescription. Your doctor or dietitian can set your target in Profile.';

  @override
  String get targetCustomNote => 'Target set by your care team.';

  @override
  String get nothingLogged => 'Nothing logged';

  @override
  String get profileTitle => 'Profile';

  @override
  String get fullName => 'Full name';

  @override
  String get dateOfBirth => 'Date of birth';

  @override
  String get heightCm => 'Height (cm)';

  @override
  String get preWeightKg => 'Pre-pregnancy weight (kg)';

  @override
  String get pregnantQuestion => 'Are you currently pregnant?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get expectedDueDate => 'Expected due date';

  @override
  String get numberOfBabies => 'Number of babies';

  @override
  String get activityLevel => 'Activity level';

  @override
  String get act_low => 'Low';

  @override
  String get act_light => 'Light';

  @override
  String get act_moderate => 'Moderate';

  @override
  String get act_high => 'High';

  @override
  String get customCalorieTarget =>
      'Calorie target from your care team (kcal, optional)';

  @override
  String get role => 'Role';

  @override
  String get rolePatient => 'Patient';

  @override
  String get roleDoctor => 'Doctor / Admin';

  @override
  String get language => 'Language';

  @override
  String get saveProfile => 'Save profile';

  @override
  String get selectDate => 'Select date';

  @override
  String get privacyNote =>
      'In this early version your data stays only on this device and is not yet encrypted. Don\'t enter real patient data.';

  @override
  String get doctorDashboard => 'Doctor dashboard';

  @override
  String get totalPatients => 'Patients';

  @override
  String get todaysAppointments => 'Today\'s appointments';

  @override
  String get alertsToReview => 'Alerts to review';

  @override
  String get patients => 'Patients';

  @override
  String get searchPatients => 'Search by name, ID or phone';

  @override
  String get doctorDemoNote =>
      'Demo data. Patient records will come from the clinic server in a later step.';

  @override
  String get noMatches => 'No matching patients';
}
