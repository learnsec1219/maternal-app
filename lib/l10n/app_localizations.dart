import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ms'),
    Locale('ta'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Maternal'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get navCalendar;

  /// No description provided for @navCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get navCreate;

  /// No description provided for @navCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get navCalories;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @createTitle.
  ///
  /// In en, this message translates to:
  /// **'What would you like to add?'**
  String get createTitle;

  /// No description provided for @createHealthLog.
  ///
  /// In en, this message translates to:
  /// **'Health log'**
  String get createHealthLog;

  /// No description provided for @createSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get createSymptoms;

  /// No description provided for @createPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get createPeriod;

  /// No description provided for @createMeal.
  ///
  /// In en, this message translates to:
  /// **'Meal'**
  String get createMeal;

  /// No description provided for @createPregnancyRecord.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy record'**
  String get createPregnancyRecord;

  /// No description provided for @createVaccine.
  ///
  /// In en, this message translates to:
  /// **'Vaccine'**
  String get createVaccine;

  /// No description provided for @createAppointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get createAppointment;

  /// No description provided for @createDocument.
  ///
  /// In en, this message translates to:
  /// **'Medical document'**
  String get createDocument;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon. This part is planned for a later step.'**
  String get comingSoon;

  /// No description provided for @soonBadge.
  ///
  /// In en, this message translates to:
  /// **'Soon'**
  String get soonBadge;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String homeGreeting(String name);

  /// No description provided for @homeGreetingNoName.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get homeGreetingNoName;

  /// No description provided for @pregnancyOverview.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy overview'**
  String get pregnancyOverview;

  /// No description provided for @weeksDays.
  ///
  /// In en, this message translates to:
  /// **'{weeks} weeks {days} days'**
  String weeksDays(int weeks, int days);

  /// No description provided for @dueDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Due date {date}'**
  String dueDateLabel(String date);

  /// No description provided for @daysToGo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Due today} =1{1 day to go} other{{count} days to go}}'**
  String daysToGo(int count);

  /// No description provided for @daysPastDue.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day past due date} other{{count} days past due date}}'**
  String daysPastDue(int count);

  /// No description provided for @trimesterFirst.
  ///
  /// In en, this message translates to:
  /// **'First trimester'**
  String get trimesterFirst;

  /// No description provided for @trimesterSecond.
  ///
  /// In en, this message translates to:
  /// **'Second trimester'**
  String get trimesterSecond;

  /// No description provided for @trimesterThird.
  ///
  /// In en, this message translates to:
  /// **'Third trimester'**
  String get trimesterThird;

  /// No description provided for @babiesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, select, 1{Single} 2{Twins} 3{Triplets} other{{count} babies}}'**
  String babiesCount(String count);

  /// No description provided for @setDueDatePrompt.
  ///
  /// In en, this message translates to:
  /// **'Add your due date in Profile to see your pregnancy progress.'**
  String get setDueDatePrompt;

  /// No description provided for @cycleOverview.
  ///
  /// In en, this message translates to:
  /// **'Cycle overview'**
  String get cycleOverview;

  /// No description provided for @nextPeriodEstimate.
  ///
  /// In en, this message translates to:
  /// **'Next period (estimate): {date}'**
  String nextPeriodEstimate(String date);

  /// No description provided for @noCycleData.
  ///
  /// In en, this message translates to:
  /// **'Log a period from Create to start cycle estimates.'**
  String get noCycleData;

  /// No description provided for @todaysHealth.
  ///
  /// In en, this message translates to:
  /// **'Today\'s health'**
  String get todaysHealth;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @metricWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get metricWeight;

  /// No description provided for @metricBloodPressure.
  ///
  /// In en, this message translates to:
  /// **'Blood pressure'**
  String get metricBloodPressure;

  /// No description provided for @metricHeartRate.
  ///
  /// In en, this message translates to:
  /// **'Heart rate'**
  String get metricHeartRate;

  /// No description provided for @metricGlucose.
  ///
  /// In en, this message translates to:
  /// **'Blood glucose'**
  String get metricGlucose;

  /// No description provided for @metricTemperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get metricTemperature;

  /// No description provided for @metricSpo2.
  ///
  /// In en, this message translates to:
  /// **'SpO2'**
  String get metricSpo2;

  /// No description provided for @metricSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get metricSleep;

  /// No description provided for @metricWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get metricWater;

  /// No description provided for @metricFetalMovement.
  ///
  /// In en, this message translates to:
  /// **'Fetal movements'**
  String get metricFetalMovement;

  /// No description provided for @metricSymptom.
  ///
  /// In en, this message translates to:
  /// **'Symptom'**
  String get metricSymptom;

  /// No description provided for @statusLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get statusLow;

  /// No description provided for @statusNormal.
  ///
  /// In en, this message translates to:
  /// **'Typical'**
  String get statusNormal;

  /// No description provided for @statusHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get statusHigh;

  /// No description provided for @todaysTasks.
  ///
  /// In en, this message translates to:
  /// **'Today\'s tasks'**
  String get todaysTasks;

  /// No description provided for @taskLogBp.
  ///
  /// In en, this message translates to:
  /// **'Record blood pressure'**
  String get taskLogBp;

  /// No description provided for @taskKicks.
  ///
  /// In en, this message translates to:
  /// **'Record fetal movements'**
  String get taskKicks;

  /// No description provided for @taskWater.
  ///
  /// In en, this message translates to:
  /// **'Drink 8 glasses of water'**
  String get taskWater;

  /// No description provided for @taskLogMeal.
  ///
  /// In en, this message translates to:
  /// **'Log your meals'**
  String get taskLogMeal;

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Latest health activity'**
  String get recentActivity;

  /// No description provided for @noActivity.
  ///
  /// In en, this message translates to:
  /// **'Nothing logged yet. Tap Create to add your first entry.'**
  String get noActivity;

  /// No description provided for @warningSigns.
  ///
  /// In en, this message translates to:
  /// **'Warning signs'**
  String get warningSigns;

  /// No description provided for @warningSignsIntro.
  ///
  /// In en, this message translates to:
  /// **'Seek medical advice if you notice any of these. This app does not diagnose.'**
  String get warningSignsIntro;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Prototype for clinical workflow design. Not a registered medical device.'**
  String get disclaimer;

  /// No description provided for @healthLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Add health log'**
  String get healthLogTitle;

  /// No description provided for @measurement.
  ///
  /// In en, this message translates to:
  /// **'Measurement'**
  String get measurement;

  /// No description provided for @systolic.
  ///
  /// In en, this message translates to:
  /// **'Systolic (mmHg)'**
  String get systolic;

  /// No description provided for @diastolic.
  ///
  /// In en, this message translates to:
  /// **'Diastolic (mmHg)'**
  String get diastolic;

  /// No description provided for @valueWithUnit.
  ///
  /// In en, this message translates to:
  /// **'Value ({unit})'**
  String valueWithUnit(String unit);

  /// No description provided for @noteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteOptional;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get invalidNumber;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @quickKick.
  ///
  /// In en, this message translates to:
  /// **'Add 1 kick'**
  String get quickKick;

  /// No description provided for @kicksToday.
  ///
  /// In en, this message translates to:
  /// **'{count} kicks today'**
  String kicksToday(int count);

  /// No description provided for @symptomTitle.
  ///
  /// In en, this message translates to:
  /// **'Log a symptom'**
  String get symptomTitle;

  /// No description provided for @symptomCommon.
  ///
  /// In en, this message translates to:
  /// **'Common'**
  String get symptomCommon;

  /// No description provided for @symptomWarning.
  ///
  /// In en, this message translates to:
  /// **'Needs medical attention'**
  String get symptomWarning;

  /// No description provided for @symptomLogged.
  ///
  /// In en, this message translates to:
  /// **'Symptom logged'**
  String get symptomLogged;

  /// No description provided for @sym_nausea.
  ///
  /// In en, this message translates to:
  /// **'Nausea'**
  String get sym_nausea;

  /// No description provided for @sym_fatigue.
  ///
  /// In en, this message translates to:
  /// **'Fatigue'**
  String get sym_fatigue;

  /// No description provided for @sym_backPain.
  ///
  /// In en, this message translates to:
  /// **'Back pain'**
  String get sym_backPain;

  /// No description provided for @sym_heartburn.
  ///
  /// In en, this message translates to:
  /// **'Heartburn'**
  String get sym_heartburn;

  /// No description provided for @sym_cramps.
  ///
  /// In en, this message translates to:
  /// **'Cramps'**
  String get sym_cramps;

  /// No description provided for @sym_headache.
  ///
  /// In en, this message translates to:
  /// **'Headache'**
  String get sym_headache;

  /// No description provided for @sym_reducedMovements.
  ///
  /// In en, this message translates to:
  /// **'Reduced or no fetal movements'**
  String get sym_reducedMovements;

  /// No description provided for @sym_bleeding.
  ///
  /// In en, this message translates to:
  /// **'Vaginal bleeding'**
  String get sym_bleeding;

  /// No description provided for @sym_severeHeadacheVision.
  ///
  /// In en, this message translates to:
  /// **'Severe headache with vision changes'**
  String get sym_severeHeadacheVision;

  /// No description provided for @sym_suddenSwelling.
  ///
  /// In en, this message translates to:
  /// **'Sudden swelling of face, hands or feet'**
  String get sym_suddenSwelling;

  /// No description provided for @sym_severeAbdominalPain.
  ///
  /// In en, this message translates to:
  /// **'Severe or persistent abdominal pain'**
  String get sym_severeAbdominalPain;

  /// No description provided for @sym_fluidLeak.
  ///
  /// In en, this message translates to:
  /// **'Watery vaginal discharge or fluid leak'**
  String get sym_fluidLeak;

  /// No description provided for @sym_feverUnwell.
  ///
  /// In en, this message translates to:
  /// **'Fever or feeling very unwell'**
  String get sym_feverUnwell;

  /// No description provided for @act_reducedMovements.
  ///
  /// In en, this message translates to:
  /// **'Contact your hospital labour ward or obstetric team immediately.'**
  String get act_reducedMovements;

  /// No description provided for @act_bleeding.
  ///
  /// In en, this message translates to:
  /// **'Go to the nearest hospital emergency department or labour ward now.'**
  String get act_bleeding;

  /// No description provided for @act_severeHeadacheVision.
  ///
  /// In en, this message translates to:
  /// **'Seek urgent medical review today.'**
  String get act_severeHeadacheVision;

  /// No description provided for @act_suddenSwelling.
  ///
  /// In en, this message translates to:
  /// **'Contact your care team today for a blood pressure and urine check.'**
  String get act_suddenSwelling;

  /// No description provided for @act_severeAbdominalPain.
  ///
  /// In en, this message translates to:
  /// **'Seek urgent medical attention.'**
  String get act_severeAbdominalPain;

  /// No description provided for @act_fluidLeak.
  ///
  /// In en, this message translates to:
  /// **'Contact your hospital labour ward immediately.'**
  String get act_fluidLeak;

  /// No description provided for @act_feverUnwell.
  ///
  /// In en, this message translates to:
  /// **'Contact your care team the same day.'**
  String get act_feverUnwell;

  /// No description provided for @periodTitle.
  ///
  /// In en, this message translates to:
  /// **'Log period'**
  String get periodTitle;

  /// No description provided for @periodStart.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get periodStart;

  /// No description provided for @periodEnd.
  ///
  /// In en, this message translates to:
  /// **'End date (optional)'**
  String get periodEnd;

  /// No description provided for @flow.
  ///
  /// In en, this message translates to:
  /// **'FlowLevel'**
  String get flow;

  /// No description provided for @flow_spotting.
  ///
  /// In en, this message translates to:
  /// **'Spotting'**
  String get flow_spotting;

  /// No description provided for @flow_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get flow_light;

  /// No description provided for @flow_medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get flow_medium;

  /// No description provided for @flow_heavy.
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get flow_heavy;

  /// No description provided for @endBeforeStart.
  ///
  /// In en, this message translates to:
  /// **'End date can\'t be before the start date'**
  String get endBeforeStart;

  /// No description provided for @legendPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get legendPeriod;

  /// No description provided for @legendPredicted.
  ///
  /// In en, this message translates to:
  /// **'Predicted period'**
  String get legendPredicted;

  /// No description provided for @legendFertile.
  ///
  /// In en, this message translates to:
  /// **'Fertile window'**
  String get legendFertile;

  /// No description provided for @legendOvulation.
  ///
  /// In en, this message translates to:
  /// **'Ovulation'**
  String get legendOvulation;

  /// No description provided for @avgCycle.
  ///
  /// In en, this message translates to:
  /// **'Average cycle {days} days'**
  String avgCycle(int days);

  /// No description provided for @avgPeriod.
  ///
  /// In en, this message translates to:
  /// **'Average period {days} days'**
  String avgPeriod(int days);

  /// No description provided for @estimatesNote.
  ///
  /// In en, this message translates to:
  /// **'Predictions are estimates, not medical facts. Don\'t rely on them for contraception.'**
  String get estimatesNote;

  /// No description provided for @irregularNote.
  ///
  /// In en, this message translates to:
  /// **'Your cycles have varied significantly. Predictions may be less accurate.'**
  String get irregularNote;

  /// No description provided for @dayEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing recorded on this day.'**
  String get dayEmpty;

  /// No description provided for @logPeriodThisDay.
  ///
  /// In en, this message translates to:
  /// **'Log period starting this day'**
  String get logPeriodThisDay;

  /// No description provided for @pregnancyTimeline.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy timeline'**
  String get pregnancyTimeline;

  /// No description provided for @milestoneWeek.
  ///
  /// In en, this message translates to:
  /// **'Week {week}'**
  String milestoneWeek(int week);

  /// No description provided for @ms_firstTrimesterEnds.
  ///
  /// In en, this message translates to:
  /// **'First trimester ends'**
  String get ms_firstTrimesterEnds;

  /// No description provided for @ms_halfway.
  ///
  /// In en, this message translates to:
  /// **'Halfway point'**
  String get ms_halfway;

  /// No description provided for @ms_thirdTrimester.
  ///
  /// In en, this message translates to:
  /// **'Third trimester begins'**
  String get ms_thirdTrimester;

  /// No description provided for @ms_fullTerm.
  ///
  /// In en, this message translates to:
  /// **'Full term'**
  String get ms_fullTerm;

  /// No description provided for @ms_dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get ms_dueDate;

  /// No description provided for @calorieTarget.
  ///
  /// In en, this message translates to:
  /// **'Daily target'**
  String get calorieTarget;

  /// No description provided for @consumed.
  ///
  /// In en, this message translates to:
  /// **'Consumed'**
  String get consumed;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @overBy.
  ///
  /// In en, this message translates to:
  /// **'Over by {kcal} kcal'**
  String overBy(int kcal);

  /// No description provided for @kcalValue.
  ///
  /// In en, this message translates to:
  /// **'{kcal} kcal'**
  String kcalValue(int kcal);

  /// No description provided for @meal_breakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get meal_breakfast;

  /// No description provided for @meal_lunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get meal_lunch;

  /// No description provided for @meal_dinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get meal_dinner;

  /// No description provided for @meal_snack.
  ///
  /// In en, this message translates to:
  /// **'Snacks'**
  String get meal_snack;

  /// No description provided for @meal_drink.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get meal_drink;

  /// No description provided for @addFood.
  ///
  /// In en, this message translates to:
  /// **'Add food'**
  String get addFood;

  /// No description provided for @foodName.
  ///
  /// In en, this message translates to:
  /// **'Food name'**
  String get foodName;

  /// No description provided for @portion.
  ///
  /// In en, this message translates to:
  /// **'Portion (optional)'**
  String get portion;

  /// No description provided for @caloriesKcal.
  ///
  /// In en, this message translates to:
  /// **'Calories (kcal)'**
  String get caloriesKcal;

  /// No description provided for @proteinG.
  ///
  /// In en, this message translates to:
  /// **'Protein (g)'**
  String get proteinG;

  /// No description provided for @carbsG.
  ///
  /// In en, this message translates to:
  /// **'Carbs (g)'**
  String get carbsG;

  /// No description provided for @fatG.
  ///
  /// In en, this message translates to:
  /// **'Fat (g)'**
  String get fatG;

  /// No description provided for @macros.
  ///
  /// In en, this message translates to:
  /// **'Protein {p} g · Carbs {c} g · Fat {f} g'**
  String macros(String p, String c, String f);

  /// No description provided for @targetEstimateNote.
  ///
  /// In en, this message translates to:
  /// **'This target is an estimate from your profile, not a medical prescription. Your doctor or dietitian can set your target in Profile.'**
  String get targetEstimateNote;

  /// No description provided for @targetCustomNote.
  ///
  /// In en, this message translates to:
  /// **'Target set by your care team.'**
  String get targetCustomNote;

  /// No description provided for @nothingLogged.
  ///
  /// In en, this message translates to:
  /// **'Nothing logged'**
  String get nothingLogged;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirth;

  /// No description provided for @heightCm.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get heightCm;

  /// No description provided for @preWeightKg.
  ///
  /// In en, this message translates to:
  /// **'Pre-pregnancy weight (kg)'**
  String get preWeightKg;

  /// No description provided for @pregnantQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you currently pregnant?'**
  String get pregnantQuestion;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @expectedDueDate.
  ///
  /// In en, this message translates to:
  /// **'Expected due date'**
  String get expectedDueDate;

  /// No description provided for @numberOfBabies.
  ///
  /// In en, this message translates to:
  /// **'Number of babies'**
  String get numberOfBabies;

  /// No description provided for @activityLevel.
  ///
  /// In en, this message translates to:
  /// **'Activity level'**
  String get activityLevel;

  /// No description provided for @act_low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get act_low;

  /// No description provided for @act_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get act_light;

  /// No description provided for @act_moderate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get act_moderate;

  /// No description provided for @act_high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get act_high;

  /// No description provided for @customCalorieTarget.
  ///
  /// In en, this message translates to:
  /// **'Calorie target from your care team (kcal, optional)'**
  String get customCalorieTarget;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @rolePatient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get rolePatient;

  /// No description provided for @roleDoctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor / Admin'**
  String get roleDoctor;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @saveProfile.
  ///
  /// In en, this message translates to:
  /// **'Save profile'**
  String get saveProfile;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @privacyNote.
  ///
  /// In en, this message translates to:
  /// **'In this early version your data stays only on this device and is not yet encrypted. Don\'t enter real patient data.'**
  String get privacyNote;

  /// No description provided for @doctorDashboard.
  ///
  /// In en, this message translates to:
  /// **'Doctor dashboard'**
  String get doctorDashboard;

  /// No description provided for @totalPatients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get totalPatients;

  /// No description provided for @todaysAppointments.
  ///
  /// In en, this message translates to:
  /// **'Today\'s appointments'**
  String get todaysAppointments;

  /// No description provided for @alertsToReview.
  ///
  /// In en, this message translates to:
  /// **'Alerts to review'**
  String get alertsToReview;

  /// No description provided for @patients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patients;

  /// No description provided for @searchPatients.
  ///
  /// In en, this message translates to:
  /// **'Search by name, ID or phone'**
  String get searchPatients;

  /// No description provided for @doctorDemoNote.
  ///
  /// In en, this message translates to:
  /// **'Demo data. Patient records will come from the clinic server in a later step.'**
  String get doctorDemoNote;

  /// No description provided for @noMatches.
  ///
  /// In en, this message translates to:
  /// **'No matching patients'**
  String get noMatches;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ms', 'ta', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ms':
      return AppLocalizationsMs();
    case 'ta':
      return AppLocalizationsTa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
