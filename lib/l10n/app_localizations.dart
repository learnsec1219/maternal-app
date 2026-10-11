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

  /// No description provided for @aboutRegulatory.
  ///
  /// In en, this message translates to:
  /// **'Development build for clinical workflow design. Not a registered medical device under the Medical Device Act 2012 (Act 737).'**
  String get aboutRegulatory;

  /// No description provided for @accessLogExplainer.
  ///
  /// In en, this message translates to:
  /// **'Every time you open a patient record it is logged. Patients and administrators can review this.'**
  String get accessLogExplainer;

  /// No description provided for @accessLogTitle.
  ///
  /// In en, this message translates to:
  /// **'My access log'**
  String get accessLogTitle;

  /// No description provided for @accessLogViewed.
  ///
  /// In en, this message translates to:
  /// **'Viewed record {id}'**
  String accessLogViewed(String id);

  /// No description provided for @actionAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get actionAccept;

  /// No description provided for @actionAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get actionAdd;

  /// No description provided for @actionBabyDelivered.
  ///
  /// In en, this message translates to:
  /// **'Baby delivered'**
  String get actionBabyDelivered;

  /// No description provided for @actionBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get actionBack;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get actionConfirm;

  /// No description provided for @actionConnect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get actionConnect;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @actionCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get actionCopy;

  /// No description provided for @actionDecline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get actionDecline;

  /// No description provided for @actionDecrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get actionDecrease;

  /// No description provided for @actionDisconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get actionDisconnect;

  /// No description provided for @actionEndPostpartum.
  ///
  /// In en, this message translates to:
  /// **'Move to general care'**
  String get actionEndPostpartum;

  /// No description provided for @actionFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get actionFinish;

  /// No description provided for @actionGoHome.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get actionGoHome;

  /// No description provided for @actionImPregnant.
  ///
  /// In en, this message translates to:
  /// **'I\'m pregnant'**
  String get actionImPregnant;

  /// No description provided for @actionIncrease.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get actionIncrease;

  /// No description provided for @actionNextDay.
  ///
  /// In en, this message translates to:
  /// **'Next day'**
  String get actionNextDay;

  /// No description provided for @actionNextMonth.
  ///
  /// In en, this message translates to:
  /// **'Next month'**
  String get actionNextMonth;

  /// No description provided for @actionNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get actionNotNow;

  /// No description provided for @actionOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get actionOk;

  /// No description provided for @actionPreviousDay.
  ///
  /// In en, this message translates to:
  /// **'Previous day'**
  String get actionPreviousDay;

  /// No description provided for @actionPreviousMonth.
  ///
  /// In en, this message translates to:
  /// **'Previous month'**
  String get actionPreviousMonth;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get actionRetry;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionScan.
  ///
  /// In en, this message translates to:
  /// **'Scan for devices'**
  String get actionScan;

  /// No description provided for @actionSendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get actionSendCode;

  /// No description provided for @actionSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get actionSignOut;

  /// No description provided for @actionToday.
  ///
  /// In en, this message translates to:
  /// **'Back to today'**
  String get actionToday;

  /// No description provided for @actionUnderstood.
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get actionUnderstood;

  /// No description provided for @actionUndoLast.
  ///
  /// In en, this message translates to:
  /// **'Undo last'**
  String get actionUndoLast;

  /// No description provided for @actionVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get actionVerify;

  /// No description provided for @activityActive.
  ///
  /// In en, this message translates to:
  /// **'Very active'**
  String get activityActive;

  /// No description provided for @activityEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your recent records will appear here.'**
  String get activityEmpty;

  /// No description provided for @activityLight.
  ///
  /// In en, this message translates to:
  /// **'Lightly active'**
  String get activityLight;

  /// No description provided for @activityModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderately active'**
  String get activityModerate;

  /// No description provided for @activitySedentary.
  ///
  /// In en, this message translates to:
  /// **'Mostly sitting'**
  String get activitySedentary;

  /// No description provided for @addAppointmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Add appointment'**
  String get addAppointmentTitle;

  /// No description provided for @addDocumentTitle.
  ///
  /// In en, this message translates to:
  /// **'Add document'**
  String get addDocumentTitle;

  /// No description provided for @addFoodTitle.
  ///
  /// In en, this message translates to:
  /// **'Add food'**
  String get addFoodTitle;

  /// No description provided for @addHealthLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Add health log'**
  String get addHealthLogTitle;

  /// No description provided for @addMilestoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Add milestone'**
  String get addMilestoneTitle;

  /// No description provided for @addNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a note'**
  String get addNoteTitle;

  /// No description provided for @addUltrasoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Add scan results'**
  String get addUltrasoundTitle;

  /// No description provided for @ageYears.
  ///
  /// In en, this message translates to:
  /// **'{age} years'**
  String ageYears(int age);

  /// No description provided for @alertCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 alert} other{{count} alerts}}'**
  String alertCount(int count);

  /// No description provided for @alertWarningSign.
  ///
  /// In en, this message translates to:
  /// **'Warning sign: {name}'**
  String alertWarningSign(String name);

  /// No description provided for @alertsExplainer.
  ///
  /// In en, this message translates to:
  /// **'Readings outside the configured ranges and warning signs logged in the last {days} days.'**
  String alertsExplainer(int days);

  /// No description provided for @alertsNone.
  ///
  /// In en, this message translates to:
  /// **'Nothing needs review right now.'**
  String get alertsNone;

  /// No description provided for @alertsToReview.
  ///
  /// In en, this message translates to:
  /// **'Alerts to review'**
  String get alertsToReview;

  /// No description provided for @answerNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get answerNo;

  /// No description provided for @answerYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get answerYes;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Maternal Care'**
  String get appName;

  /// No description provided for @appearanceDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get appearanceDark;

  /// No description provided for @appearanceExplainer.
  ///
  /// In en, this message translates to:
  /// **'Light mode is the default. Choose Dark for night use, or follow your phone setting.'**
  String get appearanceExplainer;

  /// No description provided for @appearanceLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get appearanceLight;

  /// No description provided for @appearanceSystem.
  ///
  /// In en, this message translates to:
  /// **'Same as phone'**
  String get appearanceSystem;

  /// No description provided for @appointmentDefaultPurpose.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointmentDefaultPurpose;

  /// No description provided for @appointmentsNoneToday.
  ///
  /// In en, this message translates to:
  /// **'No appointments today.'**
  String get appointmentsNoneToday;

  /// No description provided for @appointmentsNoneUpcoming.
  ///
  /// In en, this message translates to:
  /// **'No upcoming appointments.'**
  String get appointmentsNoneUpcoming;

  /// No description provided for @appointmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointmentsTitle;

  /// No description provided for @assistantBadKey.
  ///
  /// In en, this message translates to:
  /// **'The AI service refused the app\'s key. Please contact the app\'s administrator.'**
  String get assistantBadKey;

  /// No description provided for @assistantBlocked.
  ///
  /// In en, this message translates to:
  /// **'The AI service did not answer this question. Please ask it another way.'**
  String get assistantBlocked;

  /// No description provided for @assistantEducational.
  ///
  /// In en, this message translates to:
  /// **'Educational information'**
  String get assistantEducational;

  /// No description provided for @assistantFailed.
  ///
  /// In en, this message translates to:
  /// **'The answer could not be loaded. Please try again.'**
  String get assistantFailed;

  /// No description provided for @assistantHomeHint.
  ///
  /// In en, this message translates to:
  /// **'AI answers in English, BM, 中文 or தமிழ். Educational, not a diagnosis.'**
  String get assistantHomeHint;

  /// No description provided for @assistantInputHint.
  ///
  /// In en, this message translates to:
  /// **'Type your question'**
  String get assistantInputHint;

  /// No description provided for @assistantLanguage.
  ///
  /// In en, this message translates to:
  /// **'Answer in'**
  String get assistantLanguage;

  /// No description provided for @assistantNetwork.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the AI service. Check your internet connection and try again.'**
  String get assistantNetwork;

  /// No description provided for @assistantNewChat.
  ///
  /// In en, this message translates to:
  /// **'New conversation'**
  String get assistantNewChat;

  /// No description provided for @assistantNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'The AI assistant is not set up in this version of the app yet. Please contact the app\'s administrator.'**
  String get assistantNotConfigured;

  /// No description provided for @assistantSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get assistantSend;

  /// No description provided for @assistantThinking.
  ///
  /// In en, this message translates to:
  /// **'Thinking...'**
  String get assistantThinking;

  /// No description provided for @assistantTitle.
  ///
  /// In en, this message translates to:
  /// **'Ask a question'**
  String get assistantTitle;

  /// No description provided for @assistantUseDetails.
  ///
  /// In en, this message translates to:
  /// **'Use my pregnancy details'**
  String get assistantUseDetails;

  /// No description provided for @assistantUseDetailsHelp.
  ///
  /// In en, this message translates to:
  /// **'Off: nothing from your records is sent. On: only your stage (for example 32 weeks) is shared, never your name.'**
  String get assistantUseDetailsHelp;

  /// No description provided for @atGestation.
  ///
  /// In en, this message translates to:
  /// **'at {ga}'**
  String atGestation(String ga);

  /// No description provided for @authAuthenticatorHelp.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code that your authenticator app shows for Maternal.'**
  String get authAuthenticatorHelp;

  /// No description provided for @authEmailNotSetUp.
  ///
  /// In en, this message translates to:
  /// **'Email codes are not set up in this version of the app yet.'**
  String get authEmailNotSetUp;

  /// No description provided for @authInvalidCode.
  ///
  /// In en, this message translates to:
  /// **'That code is not right. Please check and try again.'**
  String get authInvalidCode;

  /// No description provided for @authInvalidIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get authInvalidIdentifier;

  /// No description provided for @authNoAccountYet.
  ///
  /// In en, this message translates to:
  /// **'Verified. There is no account yet, so let\'s create one.'**
  String get authNoAccountYet;

  /// No description provided for @authSendCodeInstead.
  ///
  /// In en, this message translates to:
  /// **'Send a code by email instead'**
  String get authSendCodeInstead;

  /// No description provided for @authSendFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not send or check the code. {reason}'**
  String authSendFailed(String reason);

  /// No description provided for @babiesMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get babiesMore;

  /// No description provided for @babiesSingle.
  ///
  /// In en, this message translates to:
  /// **'Single'**
  String get babiesSingle;

  /// No description provided for @babiesTriplets.
  ///
  /// In en, this message translates to:
  /// **'Triplets'**
  String get babiesTriplets;

  /// No description provided for @babiesTwins.
  ///
  /// In en, this message translates to:
  /// **'Twins'**
  String get babiesTwins;

  /// No description provided for @babyParameters.
  ///
  /// In en, this message translates to:
  /// **'Baby\'s measurements'**
  String get babyParameters;

  /// No description provided for @bluetoothBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery {level}%'**
  String bluetoothBattery(int level);

  /// No description provided for @bluetoothConnectFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not connect. Keep the watch close to the phone and try again.'**
  String get bluetoothConnectFailed;

  /// No description provided for @bluetoothDenied.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth permission was not given. Allow \"Nearby devices\" for Maternal in your phone\'s Settings > Apps, then try again.'**
  String get bluetoothDenied;

  /// No description provided for @bluetoothFindWatch.
  ///
  /// In en, this message translates to:
  /// **'Turn on Bluetooth and find my watch'**
  String get bluetoothFindWatch;

  /// No description provided for @bluetoothHasHeartRate.
  ///
  /// In en, this message translates to:
  /// **'Shares heart rate'**
  String get bluetoothHasHeartRate;

  /// No description provided for @bluetoothHeartRate.
  ///
  /// In en, this message translates to:
  /// **'{bpm} bpm'**
  String bluetoothHeartRate(int bpm);

  /// No description provided for @bluetoothLost.
  ///
  /// In en, this message translates to:
  /// **'The watch disconnected.'**
  String get bluetoothLost;

  /// No description provided for @bluetoothNoHeartRate.
  ///
  /// In en, this message translates to:
  /// **'This device does not share heart rate over Bluetooth. On many watches you can turn on \"Broadcast heart rate\" (HR broadcast) in the watch settings.'**
  String get bluetoothNoHeartRate;

  /// No description provided for @bluetoothNoneFound.
  ///
  /// In en, this message translates to:
  /// **'No devices found yet.'**
  String get bluetoothNoneFound;

  /// No description provided for @bluetoothOff.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth is off. Turn it on and try again.'**
  String get bluetoothOff;

  /// No description provided for @bluetoothReconnect.
  ///
  /// In en, this message translates to:
  /// **'Reconnect {name}'**
  String bluetoothReconnect(String name);

  /// No description provided for @bluetoothScanHelp.
  ///
  /// In en, this message translates to:
  /// **'Keep the watch awake and close to the phone. Devices that share heart rate are listed first.'**
  String get bluetoothScanHelp;

  /// No description provided for @bluetoothTitle.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth devices'**
  String get bluetoothTitle;

  /// No description provided for @bluetoothUnsupported.
  ///
  /// In en, this message translates to:
  /// **'This phone does not support Bluetooth Low Energy.'**
  String get bluetoothUnsupported;

  /// No description provided for @bluetoothWaitingForReading.
  ///
  /// In en, this message translates to:
  /// **'Waiting for a reading…'**
  String get bluetoothWaitingForReading;

  /// No description provided for @bluetoothWatchBody.
  ///
  /// In en, this message translates to:
  /// **'Pair a watch or fitness band over Bluetooth. Heart-rate readings sync straight into your Health log.'**
  String get bluetoothWatchBody;

  /// No description provided for @callDoctor.
  ///
  /// In en, this message translates to:
  /// **'Call {name}'**
  String callDoctor(String name);

  /// No description provided for @callEmergency.
  ///
  /// In en, this message translates to:
  /// **'Call {number}'**
  String callEmergency(String number);

  /// No description provided for @callManually.
  ///
  /// In en, this message translates to:
  /// **'Could not open the dialer. Please call {number}.'**
  String callManually(String number);

  /// No description provided for @calorieAnalysis.
  ///
  /// In en, this message translates to:
  /// **'On the {days} days you logged, you ate {average} kcal on average, about {percent}% of your target. Ask your care team what is right for you.'**
  String calorieAnalysis(int days, String average, String percent);

  /// No description provided for @calorieAnalysisNoTarget.
  ///
  /// In en, this message translates to:
  /// **'On the {days} days you logged, you ate {average} kcal on average.'**
  String calorieAnalysisNoTarget(int days, String average);

  /// No description provided for @calorieAnalysisTooFew.
  ///
  /// In en, this message translates to:
  /// **'Log at least three days to see a summary.'**
  String get calorieAnalysisTooFew;

  /// No description provided for @calorieChartSummary.
  ///
  /// In en, this message translates to:
  /// **'Calories per day for the last {range} days; {logged} days logged.'**
  String calorieChartSummary(int range, int logged);

  /// No description provided for @calorieHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get calorieHistory;

  /// No description provided for @calorieNoData.
  ///
  /// In en, this message translates to:
  /// **'No food logged in this period. Start logging food or connect your watch.'**
  String get calorieNoData;

  /// No description provided for @calorieNoTargetBody.
  ///
  /// In en, this message translates to:
  /// **'Add your date of birth, height and weight to see an estimated daily target.'**
  String get calorieNoTargetBody;

  /// No description provided for @calorieNoTargetTitle.
  ///
  /// In en, this message translates to:
  /// **'No target yet'**
  String get calorieNoTargetTitle;

  /// No description provided for @calorieTarget.
  ///
  /// In en, this message translates to:
  /// **'Daily target'**
  String get calorieTarget;

  /// No description provided for @careTeamEmpty.
  ///
  /// In en, this message translates to:
  /// **'No doctors linked yet.'**
  String get careTeamEmpty;

  /// No description provided for @careTeamIntro.
  ///
  /// In en, this message translates to:
  /// **'Doctors here can see the records you share. Remove access at any time.'**
  String get careTeamIntro;

  /// No description provided for @chartBandNote.
  ///
  /// In en, this message translates to:
  /// **'The shaded band is the typical range from your care team\'s settings.'**
  String get chartBandNote;

  /// No description provided for @chartSummary.
  ///
  /// In en, this message translates to:
  /// **'Chart of {name}: {count} readings, latest {latest}.'**
  String chartSummary(String name, int count, String latest);

  /// No description provided for @chartTargetLineNote.
  ///
  /// In en, this message translates to:
  /// **'The dashed line is your daily target.'**
  String get chartTargetLineNote;

  /// No description provided for @clinicalSummary.
  ///
  /// In en, this message translates to:
  /// **'Clinical summary'**
  String get clinicalSummary;

  /// No description provided for @colGestation.
  ///
  /// In en, this message translates to:
  /// **'Gestation'**
  String get colGestation;

  /// No description provided for @colScan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get colScan;

  /// No description provided for @contentPendingReview.
  ///
  /// In en, this message translates to:
  /// **'This schedule is demo content pending review by a qualified clinician against Malaysian guidance. Always follow your care team.'**
  String get contentPendingReview;

  /// No description provided for @contentVersion.
  ///
  /// In en, this message translates to:
  /// **'Clinical content version {version}'**
  String contentVersion(String version);

  /// No description provided for @contractionAvgDuration.
  ///
  /// In en, this message translates to:
  /// **'Average length'**
  String get contractionAvgDuration;

  /// No description provided for @contractionAvgInterval.
  ///
  /// In en, this message translates to:
  /// **'Average time apart'**
  String get contractionAvgInterval;

  /// No description provided for @contractionDuration.
  ///
  /// In en, this message translates to:
  /// **'Lasted {duration}'**
  String contractionDuration(String duration);

  /// No description provided for @contractionEmpty.
  ///
  /// In en, this message translates to:
  /// **'Contractions you time will appear here.'**
  String get contractionEmpty;

  /// No description provided for @contractionGap.
  ///
  /// In en, this message translates to:
  /// **'{gap} after the previous one'**
  String contractionGap(String gap);

  /// No description provided for @contractionHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get contractionHistory;

  /// No description provided for @contractionLastHour.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No contractions in the last hour} =1{1 contraction in the last hour} other{{count} contractions in the last hour}}'**
  String contractionLastHour(int count);

  /// No description provided for @contractionStart.
  ///
  /// In en, this message translates to:
  /// **'Contraction started'**
  String get contractionStart;

  /// No description provided for @contractionStop.
  ///
  /// In en, this message translates to:
  /// **'Contraction ended'**
  String get contractionStop;

  /// No description provided for @contractionTapToStop.
  ///
  /// In en, this message translates to:
  /// **'Tap when it ends'**
  String get contractionTapToStop;

  /// No description provided for @contractionTitle.
  ///
  /// In en, this message translates to:
  /// **'Contraction timer'**
  String get contractionTitle;

  /// No description provided for @contractionTooShort.
  ///
  /// In en, this message translates to:
  /// **'That was only a few seconds, so it was not saved.'**
  String get contractionTooShort;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @createAppointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get createAppointment;

  /// No description provided for @createAskAi.
  ///
  /// In en, this message translates to:
  /// **'Ask AI'**
  String get createAskAi;

  /// No description provided for @createContractions.
  ///
  /// In en, this message translates to:
  /// **'Contractions'**
  String get createContractions;

  /// No description provided for @createDocument.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get createDocument;

  /// No description provided for @createFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get createFood;

  /// No description provided for @createGroupCare.
  ///
  /// In en, this message translates to:
  /// **'Care'**
  String get createGroupCare;

  /// No description provided for @createGroupHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get createGroupHealth;

  /// No description provided for @createGroupNutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get createGroupNutrition;

  /// No description provided for @createGroupPregnancy.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy'**
  String get createGroupPregnancy;

  /// No description provided for @createHealthLog.
  ///
  /// In en, this message translates to:
  /// **'Health log'**
  String get createHealthLog;

  /// No description provided for @createKickCounter.
  ///
  /// In en, this message translates to:
  /// **'Kick counter'**
  String get createKickCounter;

  /// No description provided for @createMedication.
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get createMedication;

  /// No description provided for @createMilestone.
  ///
  /// In en, this message translates to:
  /// **'Milestone'**
  String get createMilestone;

  /// No description provided for @createPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get createPeriod;

  /// No description provided for @createSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get createSymptoms;

  /// No description provided for @createTitle.
  ///
  /// In en, this message translates to:
  /// **'What would you like to add?'**
  String get createTitle;

  /// No description provided for @createUltrasound.
  ///
  /// In en, this message translates to:
  /// **'Scan results'**
  String get createUltrasound;

  /// No description provided for @createVaccine.
  ///
  /// In en, this message translates to:
  /// **'Vaccine'**
  String get createVaccine;

  /// No description provided for @createWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get createWater;

  /// No description provided for @cycleAverageLength.
  ///
  /// In en, this message translates to:
  /// **'Cycle about {days} days'**
  String cycleAverageLength(int days);

  /// No description provided for @cycleBasedOnRecords.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{Based on the {count} periods you recorded. Each new record updates the following months.}}'**
  String cycleBasedOnRecords(int count);

  /// No description provided for @cycleBasedOnTypical.
  ///
  /// In en, this message translates to:
  /// **'Based on a typical cycle'**
  String get cycleBasedOnTypical;

  /// No description provided for @cycleDaysLate.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{1 day later than expected} other{{days} days later than expected}}'**
  String cycleDaysLate(int days);

  /// No description provided for @cycleFertileWindow.
  ///
  /// In en, this message translates to:
  /// **'Estimated fertile window: {start} – {end}'**
  String cycleFertileWindow(String start, String end);

  /// No description provided for @cycleInDays.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =0{Expected today} =1{In 1 day} other{In {days} days}}'**
  String cycleInDays(int days);

  /// No description provided for @cycleIrregularWarning.
  ///
  /// In en, this message translates to:
  /// **'Your cycles have varied a lot, so these estimates may be less accurate.'**
  String get cycleIrregularWarning;

  /// No description provided for @cycleLogToday.
  ///
  /// In en, this message translates to:
  /// **'Log period'**
  String get cycleLogToday;

  /// No description provided for @cycleNeedSecondPeriod.
  ///
  /// In en, this message translates to:
  /// **'Based on a typical 28-day cycle. Record your next period and predictions will follow your own rhythm.'**
  String get cycleNeedSecondPeriod;

  /// No description provided for @cycleNextPeriod.
  ///
  /// In en, this message translates to:
  /// **'Next period'**
  String get cycleNextPeriod;

  /// No description provided for @cycleNoData.
  ///
  /// In en, this message translates to:
  /// **'Log the days of your period. After two periods we can estimate your next one.'**
  String get cycleNoData;

  /// No description provided for @cycleNoEstimate.
  ///
  /// In en, this message translates to:
  /// **'Log your period to see an estimate.'**
  String get cycleNoEstimate;

  /// No description provided for @cycleOvulation.
  ///
  /// In en, this message translates to:
  /// **'Estimated ovulation: {date}'**
  String cycleOvulation(String date);

  /// No description provided for @cyclePausedInPregnancy.
  ///
  /// In en, this message translates to:
  /// **'Cycle predictions are paused during pregnancy. Your period history is kept.'**
  String get cyclePausedInPregnancy;

  /// No description provided for @cyclePeriodLength.
  ///
  /// In en, this message translates to:
  /// **'Period about {days} days'**
  String cyclePeriodLength(int days);

  /// No description provided for @cycleShiftEarlier.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{Your last period started 1 day earlier than predicted, so the next dates moved.} other{Your last period started {days} days earlier than predicted, so the next dates moved.}}'**
  String cycleShiftEarlier(int days);

  /// No description provided for @cycleShiftLater.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{Your last period started 1 day later than predicted, so the next dates moved.} other{Your last period started {days} days later than predicted, so the next dates moved.}}'**
  String cycleShiftLater(int days);

  /// No description provided for @cycleStale.
  ///
  /// In en, this message translates to:
  /// **'Your expected period is more than a cycle late. Log your latest period to update the estimates.'**
  String get cycleStale;

  /// No description provided for @cycleUpcomingTitle.
  ///
  /// In en, this message translates to:
  /// **'Following periods (estimate)'**
  String get cycleUpcomingTitle;

  /// No description provided for @dayAppointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get dayAppointments;

  /// No description provided for @dayHealthLogs.
  ///
  /// In en, this message translates to:
  /// **'Health logs'**
  String get dayHealthLogs;

  /// No description provided for @dayNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get dayNotes;

  /// No description provided for @dayPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get dayPeriod;

  /// No description provided for @daySymptoms.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get daySymptoms;

  /// No description provided for @daysPastDue.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{1 day past the due date} other{{days} days past the due date}}'**
  String daysPastDue(int days);

  /// No description provided for @daysToGo.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =0{Due today} =1{1 day to go} other{{days} days to go}}'**
  String daysToGo(int days);

  /// No description provided for @deliveredConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'We will close this pregnancy on {date} and start postpartum care. Your pregnancy records stay in your history.'**
  String deliveredConfirmBody(String date);

  /// No description provided for @deliveredConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get deliveredConfirmTitle;

  /// No description provided for @deliveredOn.
  ///
  /// In en, this message translates to:
  /// **'Delivered on {date}'**
  String deliveredOn(String date);

  /// No description provided for @deliveredSaved.
  ///
  /// In en, this message translates to:
  /// **'Postpartum care started.'**
  String get deliveredSaved;

  /// No description provided for @demoModeBody.
  ///
  /// In en, this message translates to:
  /// **'You are seeing clearly labelled demo data. Nothing is sent to a server, and records reset when the app restarts.'**
  String get demoModeBody;

  /// No description provided for @demoModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Demo mode'**
  String get demoModeTitle;

  /// No description provided for @demoUseCyclePatient.
  ///
  /// In en, this message translates to:
  /// **'Aina (cycle)'**
  String get demoUseCyclePatient;

  /// No description provided for @demoUseDoctor.
  ///
  /// In en, this message translates to:
  /// **'Dr. Chua (doctor)'**
  String get demoUseDoctor;

  /// No description provided for @demoUsePatient.
  ///
  /// In en, this message translates to:
  /// **'Gwen (pregnant)'**
  String get demoUsePatient;

  /// No description provided for @devicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Connected devices'**
  String get devicesTitle;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'This app supports, but does not replace, care from your doctor. It does not diagnose. Clinical content is pending review by a qualified clinician.'**
  String get disclaimer;

  /// No description provided for @docBloodTest.
  ///
  /// In en, this message translates to:
  /// **'Blood test'**
  String get docBloodTest;

  /// No description provided for @docHospital.
  ///
  /// In en, this message translates to:
  /// **'Hospital document'**
  String get docHospital;

  /// No description provided for @docOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get docOther;

  /// No description provided for @docPrescription.
  ///
  /// In en, this message translates to:
  /// **'Prescription'**
  String get docPrescription;

  /// No description provided for @docUltrasound.
  ///
  /// In en, this message translates to:
  /// **'Ultrasound'**
  String get docUltrasound;

  /// No description provided for @docVaccination.
  ///
  /// In en, this message translates to:
  /// **'Vaccination record'**
  String get docVaccination;

  /// No description provided for @doctorGreeting.
  ///
  /// In en, this message translates to:
  /// **'Good day, {name}'**
  String doctorGreeting(String name);

  /// No description provided for @doctorNavDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get doctorNavDashboard;

  /// No description provided for @doctorNavPatients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get doctorNavPatients;

  /// No description provided for @doctorPendingBody.
  ///
  /// In en, this message translates to:
  /// **'An administrator is checking your MMC registration. You will be able to see linked patients once it is approved.'**
  String get doctorPendingBody;

  /// No description provided for @doctorPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Waiting for verification'**
  String get doctorPendingTitle;

  /// No description provided for @documentSearchEmpty.
  ///
  /// In en, this message translates to:
  /// **'No documents match.'**
  String get documentSearchEmpty;

  /// No description provided for @documentSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search titles and text in documents'**
  String get documentSearchHint;

  /// No description provided for @documentStorageNote.
  ///
  /// In en, this message translates to:
  /// **'In this demo the file stays on your phone. In the full app it is encrypted and stored privately, and only your linked doctors can open it.'**
  String get documentStorageNote;

  /// No description provided for @documentsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No documents yet.'**
  String get documentsEmpty;

  /// No description provided for @documentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Medical documents'**
  String get documentsTitle;

  /// No description provided for @dueDateGaPreview.
  ///
  /// In en, this message translates to:
  /// **'That means you are {ga} today.'**
  String dueDateGaPreview(String ga);

  /// No description provided for @dueDateHelper.
  ///
  /// In en, this message translates to:
  /// **'From your doctor or scan report.'**
  String get dueDateHelper;

  /// No description provided for @dueDateInvalidBody.
  ///
  /// In en, this message translates to:
  /// **'The saved due date ({date}) does not match an ongoing pregnancy, so we are not showing weeks or a countdown.'**
  String dueDateInvalidBody(String date);

  /// No description provided for @dueDateInvalidTitle.
  ///
  /// In en, this message translates to:
  /// **'Please check your due date'**
  String get dueDateInvalidTitle;

  /// No description provided for @dueDateTooFarFuture.
  ///
  /// In en, this message translates to:
  /// **'This date is more than 40 weeks away. Please check it.'**
  String get dueDateTooFarFuture;

  /// No description provided for @dueDateTooFarPast.
  ///
  /// In en, this message translates to:
  /// **'This date is too far in the past for an ongoing pregnancy. Please check it.'**
  String get dueDateTooFarPast;

  /// No description provided for @dueOn.
  ///
  /// In en, this message translates to:
  /// **'Due {date}'**
  String dueOn(String date);

  /// No description provided for @emergencyNumberNote.
  ///
  /// In en, this message translates to:
  /// **'In an emergency in Malaysia, call {number}.'**
  String emergencyNumberNote(String number);

  /// No description provided for @errorEnterNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a number.'**
  String get errorEnterNumber;

  /// No description provided for @errorOutOfRange.
  ///
  /// In en, this message translates to:
  /// **'Please enter a value between {min} and {max}.'**
  String errorOutOfRange(String min, String max);

  /// No description provided for @errorRequired.
  ///
  /// In en, this message translates to:
  /// **'Please fill this in.'**
  String get errorRequired;

  /// No description provided for @estimateLabel.
  ///
  /// In en, this message translates to:
  /// **'Estimate'**
  String get estimateLabel;

  /// No description provided for @fetalAc.
  ///
  /// In en, this message translates to:
  /// **'Abdominal circumference'**
  String get fetalAc;

  /// No description provided for @fetalAfi.
  ///
  /// In en, this message translates to:
  /// **'Amniotic fluid index'**
  String get fetalAfi;

  /// No description provided for @fetalBpd.
  ///
  /// In en, this message translates to:
  /// **'Biparietal diameter'**
  String get fetalBpd;

  /// No description provided for @fetalCrl.
  ///
  /// In en, this message translates to:
  /// **'Crown-rump length'**
  String get fetalCrl;

  /// No description provided for @fetalEfw.
  ///
  /// In en, this message translates to:
  /// **'Estimated weight'**
  String get fetalEfw;

  /// No description provided for @fetalFhr.
  ///
  /// In en, this message translates to:
  /// **'Fetal heart rate'**
  String get fetalFhr;

  /// No description provided for @fetalFl.
  ///
  /// In en, this message translates to:
  /// **'Femur length'**
  String get fetalFl;

  /// No description provided for @fetalHc.
  ///
  /// In en, this message translates to:
  /// **'Head circumference'**
  String get fetalHc;

  /// No description provided for @fetalNt.
  ///
  /// In en, this message translates to:
  /// **'Nuchal translucency'**
  String get fetalNt;

  /// No description provided for @fieldActivityLevel.
  ///
  /// In en, this message translates to:
  /// **'Activity level'**
  String get fieldActivityLevel;

  /// No description provided for @fieldAllergies.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get fieldAllergies;

  /// No description provided for @fieldBloodGroup.
  ///
  /// In en, this message translates to:
  /// **'Blood group'**
  String get fieldBloodGroup;

  /// No description provided for @fieldCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get fieldCalories;

  /// No description provided for @fieldCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get fieldCategory;

  /// No description provided for @fieldClinic.
  ///
  /// In en, this message translates to:
  /// **'Clinic or hospital'**
  String get fieldClinic;

  /// No description provided for @fieldClinicHospital.
  ///
  /// In en, this message translates to:
  /// **'Clinic or hospital'**
  String get fieldClinicHospital;

  /// No description provided for @fieldDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get fieldDate;

  /// No description provided for @fieldDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get fieldDateOfBirth;

  /// No description provided for @fieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get fieldDescription;

  /// No description provided for @fieldDiastolic.
  ///
  /// In en, this message translates to:
  /// **'Diastolic (lower)'**
  String get fieldDiastolic;

  /// No description provided for @fieldDoctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get fieldDoctor;

  /// No description provided for @fieldDocumentDate.
  ///
  /// In en, this message translates to:
  /// **'Date on the document'**
  String get fieldDocumentDate;

  /// No description provided for @fieldDueDate.
  ///
  /// In en, this message translates to:
  /// **'Expected due date'**
  String get fieldDueDate;

  /// No description provided for @fieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldEmail;

  /// No description provided for @fieldFlow.
  ///
  /// In en, this message translates to:
  /// **'Flow'**
  String get fieldFlow;

  /// No description provided for @fieldFoodName.
  ///
  /// In en, this message translates to:
  /// **'Food or drink'**
  String get fieldFoodName;

  /// No description provided for @fieldFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fieldFullName;

  /// No description provided for @fieldGlucoseContext.
  ///
  /// In en, this message translates to:
  /// **'When was it measured?'**
  String get fieldGlucoseContext;

  /// No description provided for @fieldHeight.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get fieldHeight;

  /// No description provided for @fieldMeal.
  ///
  /// In en, this message translates to:
  /// **'Meal'**
  String get fieldMeal;

  /// No description provided for @fieldMeasurement.
  ///
  /// In en, this message translates to:
  /// **'What are you recording?'**
  String get fieldMeasurement;

  /// No description provided for @fieldMedicalHistory.
  ///
  /// In en, this message translates to:
  /// **'Medical history'**
  String get fieldMedicalHistory;

  /// No description provided for @fieldMilestone.
  ///
  /// In en, this message translates to:
  /// **'Milestone'**
  String get fieldMilestone;

  /// No description provided for @fieldMmcHelper.
  ///
  /// In en, this message translates to:
  /// **'Checked by an administrator before you can see patient data.'**
  String get fieldMmcHelper;

  /// No description provided for @fieldMmcNumber.
  ///
  /// In en, this message translates to:
  /// **'MMC registration number'**
  String get fieldMmcNumber;

  /// No description provided for @fieldNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get fieldNote;

  /// No description provided for @fieldNotesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get fieldNotesOptional;

  /// No description provided for @fieldNumberOfBabies.
  ///
  /// In en, this message translates to:
  /// **'Number of babies'**
  String get fieldNumberOfBabies;

  /// No description provided for @fieldOtp.
  ///
  /// In en, this message translates to:
  /// **'One-time code'**
  String get fieldOtp;

  /// No description provided for @fieldPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get fieldPhone;

  /// No description provided for @fieldPortion.
  ///
  /// In en, this message translates to:
  /// **'Portion'**
  String get fieldPortion;

  /// No description provided for @fieldPrePregnancyWeight.
  ///
  /// In en, this message translates to:
  /// **'Pre-pregnancy weight'**
  String get fieldPrePregnancyWeight;

  /// No description provided for @fieldPreferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Preferred language'**
  String get fieldPreferredLanguage;

  /// No description provided for @fieldPurpose.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get fieldPurpose;

  /// No description provided for @fieldScanType.
  ///
  /// In en, this message translates to:
  /// **'Scan type'**
  String get fieldScanType;

  /// No description provided for @fieldSeverity.
  ///
  /// In en, this message translates to:
  /// **'How strong?'**
  String get fieldSeverity;

  /// No description provided for @fieldSystolic.
  ///
  /// In en, this message translates to:
  /// **'Systolic (upper)'**
  String get fieldSystolic;

  /// No description provided for @fieldTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get fieldTime;

  /// No description provided for @fieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get fieldTitle;

  /// No description provided for @filterPending.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get filterPending;

  /// No description provided for @flowHeavy.
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get flowHeavy;

  /// No description provided for @flowLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get flowLight;

  /// No description provided for @flowMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get flowMedium;

  /// No description provided for @flowNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get flowNone;

  /// No description provided for @flowSpotting.
  ///
  /// In en, this message translates to:
  /// **'Spotting'**
  String get flowSpotting;

  /// No description provided for @gaWeeksDays.
  ///
  /// In en, this message translates to:
  /// **'{weeks, plural, =1{1 week} other{{weeks} weeks}} {days, plural, =0{0 days} =1{1 day} other{{days} days}}'**
  String gaWeeksDays(int weeks, int days);

  /// No description provided for @glucoseAfterMeal.
  ///
  /// In en, this message translates to:
  /// **'After a meal'**
  String get glucoseAfterMeal;

  /// No description provided for @glucoseFasting.
  ///
  /// In en, this message translates to:
  /// **'Fasting'**
  String get glucoseFasting;

  /// No description provided for @glucoseRandom.
  ///
  /// In en, this message translates to:
  /// **'Other time'**
  String get glucoseRandom;

  /// No description provided for @googleConsentAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow and continue'**
  String get googleConsentAllow;

  /// No description provided for @googleConsentBody.
  ///
  /// In en, this message translates to:
  /// **'Maternal will copy these from your Google account into your profile. You can change them later in Personal information.'**
  String get googleConsentBody;

  /// No description provided for @googleConsentManual.
  ///
  /// In en, this message translates to:
  /// **'I\'ll enter my details myself'**
  String get googleConsentManual;

  /// No description provided for @googleConsentTitle.
  ///
  /// In en, this message translates to:
  /// **'Use your Google details?'**
  String get googleConsentTitle;

  /// No description provided for @googleContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get googleContinue;

  /// No description provided for @googleFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in didn\'t work: {detail}'**
  String googleFailed(String detail);

  /// No description provided for @googleNotSetUp.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in is not set up in this build yet. Please use your email.'**
  String get googleNotSetUp;

  /// No description provided for @googlePhoto.
  ///
  /// In en, this message translates to:
  /// **'Profile photo'**
  String get googlePhoto;

  /// No description provided for @googlePhotoValue.
  ///
  /// In en, this message translates to:
  /// **'Your Google photo'**
  String get googlePhotoValue;

  /// No description provided for @gravidaPara.
  ///
  /// In en, this message translates to:
  /// **'Gravida / para'**
  String get gravidaPara;

  /// No description provided for @growthCompareScans.
  ///
  /// In en, this message translates to:
  /// **'Compare scans'**
  String get growthCompareScans;

  /// No description provided for @growthNoScans.
  ///
  /// In en, this message translates to:
  /// **'No scans recorded yet.'**
  String get growthNoScans;

  /// No description provided for @healthConnectBody.
  ///
  /// In en, this message translates to:
  /// **'Bring in steps, heart rate, sleep and other data your phone or watch already records.'**
  String get healthConnectBody;

  /// No description provided for @healthConnectDemoNote.
  ///
  /// In en, this message translates to:
  /// **'Health Connect below still uses demo readings in this build. Bluetooth above is real.'**
  String get healthConnectDemoNote;

  /// No description provided for @healthConnectRationale.
  ///
  /// In en, this message translates to:
  /// **'We read only the data types you allow, and only after you agree. You can disconnect at any time.'**
  String get healthConnectRationale;

  /// No description provided for @healthConnectTitle.
  ///
  /// In en, this message translates to:
  /// **'Health Connect'**
  String get healthConnectTitle;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name}'**
  String homeGreeting(String name);

  /// No description provided for @homeNextAppointment.
  ///
  /// In en, this message translates to:
  /// **'Upcoming appointment'**
  String get homeNextAppointment;

  /// No description provided for @homeRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'Latest health activity'**
  String get homeRecentActivity;

  /// No description provided for @homeTabBaby.
  ///
  /// In en, this message translates to:
  /// **'Baby'**
  String get homeTabBaby;

  /// No description provided for @homeTabMother.
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get homeTabMother;

  /// No description provided for @homeTodaysHealth.
  ///
  /// In en, this message translates to:
  /// **'Today\'s health'**
  String get homeTodaysHealth;

  /// No description provided for @homeTodaysTasks.
  ///
  /// In en, this message translates to:
  /// **'Today\'s tasks'**
  String get homeTodaysTasks;

  /// No description provided for @intimacyPrivateNote.
  ///
  /// In en, this message translates to:
  /// **'Private: only you can see this unless you choose to share it in Privacy.'**
  String get intimacyPrivateNote;

  /// No description provided for @journeyGeneral.
  ///
  /// In en, this message translates to:
  /// **'Women\'s health'**
  String get journeyGeneral;

  /// No description provided for @journeyPostpartum.
  ///
  /// In en, this message translates to:
  /// **'Postpartum'**
  String get journeyPostpartum;

  /// No description provided for @journeyPregnancy.
  ///
  /// In en, this message translates to:
  /// **'Pregnant'**
  String get journeyPregnancy;

  /// No description provided for @kcalBurntNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Calories burnt: connect a watch or Health Connect'**
  String get kcalBurntNotConnected;

  /// No description provided for @kcalConsumed.
  ///
  /// In en, this message translates to:
  /// **'eaten'**
  String get kcalConsumed;

  /// No description provided for @kcalOver.
  ///
  /// In en, this message translates to:
  /// **'{kcal} kcal over target'**
  String kcalOver(String kcal);

  /// No description provided for @kcalRemaining.
  ///
  /// In en, this message translates to:
  /// **'{kcal} kcal remaining'**
  String kcalRemaining(String kcal);

  /// No description provided for @kickCounterTitle.
  ///
  /// In en, this message translates to:
  /// **'Kick counter'**
  String get kickCounterTitle;

  /// No description provided for @kickGuarded.
  ///
  /// In en, this message translates to:
  /// **'Counted as the same movement as your last tap.'**
  String get kickGuarded;

  /// No description provided for @kickTapButton.
  ///
  /// In en, this message translates to:
  /// **'Tap for each movement'**
  String get kickTapButton;

  /// No description provided for @kicksChartSummary.
  ///
  /// In en, this message translates to:
  /// **'Bar chart of movements per hour today. Total {count}.'**
  String kicksChartSummary(int count);

  /// No description provided for @kicksCount.
  ///
  /// In en, this message translates to:
  /// **'{count}'**
  String kicksCount(int count);

  /// No description provided for @kicksPastDays.
  ///
  /// In en, this message translates to:
  /// **'Previous days'**
  String get kicksPastDays;

  /// No description provided for @kicksPerHourTitle.
  ///
  /// In en, this message translates to:
  /// **'Movements per hour today'**
  String get kicksPerHourTitle;

  /// No description provided for @kicksTodayCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No movements counted today} =1{1 movement today} other{{count} movements today}}'**
  String kicksTodayCount(int count);

  /// No description provided for @languageSwitchLabel.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get languageSwitchLabel;

  /// No description provided for @lastKickAt.
  ///
  /// In en, this message translates to:
  /// **'Last movement at {time}'**
  String lastKickAt(String time);

  /// No description provided for @lastNDays.
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String lastNDays(int days);

  /// No description provided for @legendAppointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get legendAppointment;

  /// No description provided for @legendFertile.
  ///
  /// In en, this message translates to:
  /// **'Fertile window (estimate)'**
  String get legendFertile;

  /// No description provided for @legendLogged.
  ///
  /// In en, this message translates to:
  /// **'Health log'**
  String get legendLogged;

  /// No description provided for @legendMedication.
  ///
  /// In en, this message translates to:
  /// **'Medication taken'**
  String get legendMedication;

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

  /// No description provided for @linkActive.
  ///
  /// In en, this message translates to:
  /// **'Can see your shared records'**
  String get linkActive;

  /// No description provided for @linkPending.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the doctor to accept'**
  String get linkPending;

  /// No description provided for @loginChangeIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Use a different email'**
  String get loginChangeIdentifier;

  /// No description provided for @loginIntro.
  ///
  /// In en, this message translates to:
  /// **'Enter your email. We will send you a one-time code.'**
  String get loginIntro;

  /// No description provided for @loginRecoveryHint.
  ///
  /// In en, this message translates to:
  /// **'Can\'t receive codes at this email? Contact your clinic to recover your account.'**
  String get loginRecoveryHint;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginTitle;

  /// No description provided for @macroCarbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get macroCarbs;

  /// No description provided for @macroFat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get macroFat;

  /// No description provided for @macroProtein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get macroProtein;

  /// No description provided for @macroSummary.
  ///
  /// In en, this message translates to:
  /// **'P {protein} g · C {carbs} g · F {fat} g'**
  String macroSummary(String protein, String carbs, String fat);

  /// No description provided for @mealBreakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get mealBreakfast;

  /// No description provided for @mealDinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get mealDinner;

  /// No description provided for @mealDrinks.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get mealDrinks;

  /// No description provided for @mealLunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get mealLunch;

  /// No description provided for @mealSnacks.
  ///
  /// In en, this message translates to:
  /// **'Snacks'**
  String get mealSnacks;

  /// No description provided for @medicationSafetyNote.
  ///
  /// In en, this message translates to:
  /// **'Only add medicines as prescribed by your doctor. This list is a reminder, not medical advice.'**
  String get medicationSafetyNote;

  /// No description provided for @medicationsNoneToday.
  ///
  /// In en, this message translates to:
  /// **'No doses scheduled today.'**
  String get medicationsNoneToday;

  /// No description provided for @medicationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Medications'**
  String get medicationsTitle;

  /// No description provided for @medicationsToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get medicationsToday;

  /// No description provided for @menuAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get menuAbout;

  /// No description provided for @menuAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get menuAppearance;

  /// No description provided for @menuCareTeam.
  ///
  /// In en, this message translates to:
  /// **'My care team'**
  String get menuCareTeam;

  /// No description provided for @menuEmergencyContact.
  ///
  /// In en, this message translates to:
  /// **'Emergency contact'**
  String get menuEmergencyContact;

  /// No description provided for @menuNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get menuNotifications;

  /// No description provided for @menuPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get menuPersonalInfo;

  /// No description provided for @menuPregnancyInfo.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy information'**
  String get menuPregnancyInfo;

  /// No description provided for @menuPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy and data'**
  String get menuPrivacy;

  /// No description provided for @milestoneHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Felt first kicks'**
  String get milestoneHint;

  /// No description provided for @moodGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get moodGood;

  /// No description provided for @moodGreat.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get moodGreat;

  /// No description provided for @moodLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get moodLow;

  /// No description provided for @moodOkay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get moodOkay;

  /// No description provided for @moodVeryLow.
  ///
  /// In en, this message translates to:
  /// **'Very low'**
  String get moodVeryLow;

  /// No description provided for @navCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get navCalendar;

  /// No description provided for @navCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get navCalories;

  /// No description provided for @navCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get navCreate;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get noData;

  /// No description provided for @noDataTapToAdd.
  ///
  /// In en, this message translates to:
  /// **'No data yet. Tap to add.'**
  String get noDataTapToAdd;

  /// No description provided for @noReadingsInPeriod.
  ///
  /// In en, this message translates to:
  /// **'No readings in this period.'**
  String get noReadingsInPeriod;

  /// No description provided for @noReadingsYet.
  ///
  /// In en, this message translates to:
  /// **'No readings yet.'**
  String get noReadingsYet;

  /// No description provided for @nothingLogged.
  ///
  /// In en, this message translates to:
  /// **'Nothing recorded.'**
  String get nothingLogged;

  /// No description provided for @notifAppointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get notifAppointments;

  /// No description provided for @notifDoctorMessages.
  ///
  /// In en, this message translates to:
  /// **'Messages from my doctor'**
  String get notifDoctorMessages;

  /// No description provided for @notifHealthLogs.
  ///
  /// In en, this message translates to:
  /// **'Health log reminders'**
  String get notifHealthLogs;

  /// No description provided for @notifLockScreenDetails.
  ///
  /// In en, this message translates to:
  /// **'Show details on lock screen'**
  String get notifLockScreenDetails;

  /// No description provided for @notifLockScreenHelp.
  ///
  /// In en, this message translates to:
  /// **'Off by default to protect your privacy.'**
  String get notifLockScreenHelp;

  /// No description provided for @notifMedication.
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get notifMedication;

  /// No description provided for @notifMilestones.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy milestones'**
  String get notifMilestones;

  /// No description provided for @notifVaccines.
  ///
  /// In en, this message translates to:
  /// **'Vaccines'**
  String get notifVaccines;

  /// No description provided for @notificationsRationale.
  ///
  /// In en, this message translates to:
  /// **'We use notifications to remind you about appointments, health logs and important pregnancy milestones.'**
  String get notificationsRationale;

  /// No description provided for @obsActivity.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get obsActivity;

  /// No description provided for @obsBloodGlucose.
  ///
  /// In en, this message translates to:
  /// **'Blood glucose'**
  String get obsBloodGlucose;

  /// No description provided for @obsBloodPressure.
  ///
  /// In en, this message translates to:
  /// **'Blood pressure'**
  String get obsBloodPressure;

  /// No description provided for @obsHeartRate.
  ///
  /// In en, this message translates to:
  /// **'Heart rate'**
  String get obsHeartRate;

  /// No description provided for @obsMood.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get obsMood;

  /// No description provided for @obsSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get obsSleep;

  /// No description provided for @obsSpo2.
  ///
  /// In en, this message translates to:
  /// **'Oxygen (SpO2)'**
  String get obsSpo2;

  /// No description provided for @obsTemperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get obsTemperature;

  /// No description provided for @obsWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get obsWater;

  /// No description provided for @obsWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get obsWeight;

  /// No description provided for @onboardingBodySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Used for weight and calorie estimates. You can change it later.'**
  String get onboardingBodySubtitle;

  /// No description provided for @onboardingBodyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your body'**
  String get onboardingBodyTitle;

  /// No description provided for @onboardingDemoCode.
  ///
  /// In en, this message translates to:
  /// **'Demo build: use code {code}.'**
  String onboardingDemoCode(String code);

  /// No description provided for @onboardingDoctorDoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'An administrator will verify your registration before you can see any patient data.'**
  String get onboardingDoctorDoneSubtitle;

  /// No description provided for @onboardingDoctorDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Almost there'**
  String get onboardingDoctorDoneTitle;

  /// No description provided for @onboardingDoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Everything you record from now on is kept together in one place.'**
  String get onboardingDoneSubtitle;

  /// No description provided for @onboardingDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Your profile is ready'**
  String get onboardingDoneTitle;

  /// No description provided for @onboardingNotPregnantInfo.
  ///
  /// In en, this message translates to:
  /// **'We will set up cycle tracking and general women\'s health. You can start a pregnancy later from your profile.'**
  String get onboardingNotPregnantInfo;

  /// No description provided for @onboardingPersonalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This helps us personalize your care.'**
  String get onboardingPersonalSubtitle;

  /// No description provided for @onboardingPersonalTitle.
  ///
  /// In en, this message translates to:
  /// **'About you'**
  String get onboardingPersonalTitle;

  /// No description provided for @onboardingPregnancySubtitle.
  ///
  /// In en, this message translates to:
  /// **'This shapes your home screen. You can change it any time.'**
  String get onboardingPregnancySubtitle;

  /// No description provided for @onboardingPregnancyTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you currently pregnant?'**
  String get onboardingPregnancyTitle;

  /// No description provided for @onboardingRoleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose one. You can only see what your role allows.'**
  String get onboardingRoleSubtitle;

  /// No description provided for @onboardingRoleTitle.
  ///
  /// In en, this message translates to:
  /// **'Who is using the app?'**
  String get onboardingRoleTitle;

  /// No description provided for @onboardingStepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String onboardingStepOf(int current, int total);

  /// No description provided for @onboardingVerifySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we will send a one-time code.'**
  String get onboardingVerifySubtitle;

  /// No description provided for @onboardingVerifyTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your account'**
  String get onboardingVerifyTitle;

  /// No description provided for @otpExpired.
  ///
  /// In en, this message translates to:
  /// **'This code has expired. Please send a new one.'**
  String get otpExpired;

  /// No description provided for @otpExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'Code expires in {time}'**
  String otpExpiresIn(String time);

  /// No description provided for @otpResend.
  ///
  /// In en, this message translates to:
  /// **'Send a new code'**
  String get otpResend;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'Code sent to {destination}'**
  String otpSentTo(String destination);

  /// No description provided for @outsideRangeBody.
  ///
  /// In en, this message translates to:
  /// **'Your reading is saved. It is outside the typical range in your care team\'s settings. If you feel unwell or notice any warning signs, contact your care team. This is not a diagnosis.'**
  String get outsideRangeBody;

  /// No description provided for @outsideRangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Reading outside the typical range'**
  String get outsideRangeTitle;

  /// No description provided for @painMild.
  ///
  /// In en, this message translates to:
  /// **'Mild'**
  String get painMild;

  /// No description provided for @painModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get painModerate;

  /// No description provided for @painSevere.
  ///
  /// In en, this message translates to:
  /// **'Severe'**
  String get painSevere;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @patientId.
  ///
  /// In en, this message translates to:
  /// **'Patient ID'**
  String get patientId;

  /// No description provided for @patientSearchEmpty.
  ///
  /// In en, this message translates to:
  /// **'No patients match.'**
  String get patientSearchEmpty;

  /// No description provided for @patientSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search name, ID, phone or due date'**
  String get patientSearchHint;

  /// No description provided for @percentileFromReport.
  ///
  /// In en, this message translates to:
  /// **'Percentile {value} (from report)'**
  String percentileFromReport(String value);

  /// No description provided for @periodDayTitle.
  ///
  /// In en, this message translates to:
  /// **'Period and cycle log'**
  String get periodDayTitle;

  /// No description provided for @permissionsBody.
  ///
  /// In en, this message translates to:
  /// **'The app asks for notifications, Bluetooth, camera or photos only when you first use a feature that needs them. You can change these at any time in your phone settings.'**
  String get permissionsBody;

  /// No description provided for @permissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permissionsTitle;

  /// No description provided for @photoChange.
  ///
  /// In en, this message translates to:
  /// **'Change profile photo'**
  String get photoChange;

  /// No description provided for @photoChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get photoChoose;

  /// No description provided for @photoRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get photoRemove;

  /// No description provided for @photoSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile photo updated'**
  String get photoSaved;

  /// No description provided for @portionHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 1 plate, 250 ml'**
  String get portionHint;

  /// No description provided for @postpartumSince.
  ///
  /// In en, this message translates to:
  /// **'{weeks} weeks {days} days since delivery'**
  String postpartumSince(int weeks, int days);

  /// No description provided for @pregnancyStartInfo.
  ///
  /// In en, this message translates to:
  /// **'Saving will start a new pregnancy in your record. Your earlier history stays.'**
  String get pregnancyStartInfo;

  /// No description provided for @privacyIntro.
  ///
  /// In en, this message translates to:
  /// **'Your health records belong to you. Only doctors you link with can see them, and only the parts you choose to share.'**
  String get privacyIntro;

  /// No description provided for @purposeHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Antenatal check'**
  String get purposeHint;

  /// No description provided for @rangeAbove.
  ///
  /// In en, this message translates to:
  /// **'Above range'**
  String get rangeAbove;

  /// No description provided for @rangeBelow.
  ///
  /// In en, this message translates to:
  /// **'Below range'**
  String get rangeBelow;

  /// No description provided for @rangeWithin.
  ///
  /// In en, this message translates to:
  /// **'In range'**
  String get rangeWithin;

  /// No description provided for @readingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Readings'**
  String get readingsTitle;

  /// No description provided for @recentFoods.
  ///
  /// In en, this message translates to:
  /// **'Recent foods'**
  String get recentFoods;

  /// No description provided for @reminderAppointmentToday.
  ///
  /// In en, this message translates to:
  /// **'Your appointment ({purpose}) is today at {time}.'**
  String reminderAppointmentToday(String purpose, String time);

  /// No description provided for @reminderAppointmentTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Your appointment ({purpose}) is tomorrow at {time}.'**
  String reminderAppointmentTomorrow(String purpose, String time);

  /// No description provided for @reminderLogBloodPressure.
  ///
  /// In en, this message translates to:
  /// **'Remember to record today\'s blood pressure.'**
  String get reminderLogBloodPressure;

  /// No description provided for @reminderMedication.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 dose still to take today.} other{{count} doses still to take today.}}'**
  String reminderMedication(int count);

  /// No description provided for @reminderVaccineDue.
  ///
  /// In en, this message translates to:
  /// **'Your next vaccination may be due: {name}. Check with your care team.'**
  String reminderVaccineDue(String name);

  /// No description provided for @remindersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No reminders right now.'**
  String get remindersEmpty;

  /// No description provided for @remindersPushNote.
  ///
  /// In en, this message translates to:
  /// **'Phone notifications use general wording, such as \"You have a new reminder\", so health details never show on your lock screen.'**
  String get remindersPushNote;

  /// No description provided for @remindersTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get remindersTitle;

  /// No description provided for @riskFactors.
  ///
  /// In en, this message translates to:
  /// **'Risk factors'**
  String get riskFactors;

  /// No description provided for @roleDoctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor / Admin'**
  String get roleDoctor;

  /// No description provided for @roleDoctorHint.
  ///
  /// In en, this message translates to:
  /// **'Review your patients after verification'**
  String get roleDoctorHint;

  /// No description provided for @rolePatient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get rolePatient;

  /// No description provided for @rolePatientHint.
  ///
  /// In en, this message translates to:
  /// **'Track pregnancy, cycle and health'**
  String get rolePatientHint;

  /// No description provided for @savedMessage.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get savedMessage;

  /// No description provided for @scanTypeDefault.
  ///
  /// In en, this message translates to:
  /// **'Ultrasound'**
  String get scanTypeDefault;

  /// No description provided for @scanTypeHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Growth scan'**
  String get scanTypeHint;

  /// No description provided for @scanning.
  ///
  /// In en, this message translates to:
  /// **'Scanning…'**
  String get scanning;

  /// No description provided for @securityTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign-in & security'**
  String get securityTitle;

  /// No description provided for @shareCycle.
  ///
  /// In en, this message translates to:
  /// **'Period and cycle'**
  String get shareCycle;

  /// No description provided for @shareDocuments.
  ///
  /// In en, this message translates to:
  /// **'Medical documents'**
  String get shareDocuments;

  /// No description provided for @shareIntimacy.
  ///
  /// In en, this message translates to:
  /// **'Sexual activity'**
  String get shareIntimacy;

  /// No description provided for @shareNutrition.
  ///
  /// In en, this message translates to:
  /// **'Food and calories'**
  String get shareNutrition;

  /// No description provided for @sharePregnancy.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy and scans'**
  String get sharePregnancy;

  /// No description provided for @shareVitals.
  ///
  /// In en, this message translates to:
  /// **'Health logs and vital signs'**
  String get shareVitals;

  /// No description provided for @sharingTitle.
  ///
  /// In en, this message translates to:
  /// **'Shared with my doctors'**
  String get sharingTitle;

  /// No description provided for @signOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Sign out of this device?'**
  String get signOutConfirm;

  /// No description provided for @ssoOr.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get ssoOr;

  /// No description provided for @statAlerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts to review'**
  String get statAlerts;

  /// No description provided for @statAverage.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get statAverage;

  /// No description provided for @statHighest.
  ///
  /// In en, this message translates to:
  /// **'Highest'**
  String get statHighest;

  /// No description provided for @statLowest.
  ///
  /// In en, this message translates to:
  /// **'Lowest'**
  String get statLowest;

  /// No description provided for @statNewRequests.
  ///
  /// In en, this message translates to:
  /// **'New patient requests'**
  String get statNewRequests;

  /// No description provided for @statTodaysAppointments.
  ///
  /// In en, this message translates to:
  /// **'Today\'s appointments'**
  String get statTodaysAppointments;

  /// No description provided for @statTotalPatients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get statTotalPatients;

  /// No description provided for @statusConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get statusConnected;

  /// No description provided for @statusNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Not connected'**
  String get statusNotConnected;

  /// No description provided for @symptomLogged.
  ///
  /// In en, this message translates to:
  /// **'Symptom'**
  String get symptomLogged;

  /// No description provided for @symptomsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No symptoms recorded.'**
  String get symptomsEmpty;

  /// No description provided for @symptomsHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent symptoms'**
  String get symptomsHistoryTitle;

  /// No description provided for @symptomsLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Log symptoms'**
  String get symptomsLogTitle;

  /// No description provided for @symptomsTitle.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get symptomsTitle;

  /// No description provided for @syncedReadings.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No new readings} =1{1 reading synced} other{{count} readings synced}}'**
  String syncedReadings(int count);

  /// No description provided for @tabCycle.
  ///
  /// In en, this message translates to:
  /// **'Menstrual cycle'**
  String get tabCycle;

  /// No description provided for @tabGrowth.
  ///
  /// In en, this message translates to:
  /// **'Growth'**
  String get tabGrowth;

  /// No description provided for @tabPregnancyTimeline.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy'**
  String get tabPregnancyTimeline;

  /// No description provided for @tabSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get tabSummary;

  /// No description provided for @tabTimeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get tabTimeline;

  /// No description provided for @tabVitals.
  ///
  /// In en, this message translates to:
  /// **'Vitals'**
  String get tabVitals;

  /// No description provided for @targetSetByClinician.
  ///
  /// In en, this message translates to:
  /// **'Set by your care team'**
  String get targetSetByClinician;

  /// No description provided for @taskCountKicks.
  ///
  /// In en, this message translates to:
  /// **'Count baby movements'**
  String get taskCountKicks;

  /// No description provided for @taskDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get taskDone;

  /// No description provided for @taskDrinkWater.
  ///
  /// In en, this message translates to:
  /// **'Drink water'**
  String get taskDrinkWater;

  /// No description provided for @taskNotDone.
  ///
  /// In en, this message translates to:
  /// **'Not done'**
  String get taskNotDone;

  /// No description provided for @taskTakeMedication.
  ///
  /// In en, this message translates to:
  /// **'Take {name} {dose}'**
  String taskTakeMedication(String name, String dose);

  /// No description provided for @timelineDueDate.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get timelineDueDate;

  /// No description provided for @timelineStart.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy dated from'**
  String get timelineStart;

  /// No description provided for @timelineTrimesterStarts.
  ///
  /// In en, this message translates to:
  /// **'{name} begins'**
  String timelineTrimesterStarts(String name);

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @totpBody.
  ///
  /// In en, this message translates to:
  /// **'Sign in with the 6-digit code from Google Authenticator, Microsoft Authenticator or a similar app. It works without email or internet.'**
  String get totpBody;

  /// No description provided for @totpCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Authenticator code'**
  String get totpCodeLabel;

  /// No description provided for @totpEnable.
  ///
  /// In en, this message translates to:
  /// **'Verify and turn on'**
  String get totpEnable;

  /// No description provided for @totpKeyLabel.
  ///
  /// In en, this message translates to:
  /// **'Setup key'**
  String get totpKeyLabel;

  /// No description provided for @totpNoApp.
  ///
  /// In en, this message translates to:
  /// **'No authenticator app found. Install Google Authenticator, then try again or type the setup key.'**
  String get totpNoApp;

  /// No description provided for @totpOn.
  ///
  /// In en, this message translates to:
  /// **'Authenticator app is on. When you sign in, enter the code it shows.'**
  String get totpOn;

  /// No description provided for @totpOpenApp.
  ///
  /// In en, this message translates to:
  /// **'Open authenticator app'**
  String get totpOpenApp;

  /// No description provided for @totpSetup.
  ///
  /// In en, this message translates to:
  /// **'Set up authenticator app'**
  String get totpSetup;

  /// No description provided for @totpStep1.
  ///
  /// In en, this message translates to:
  /// **'1. Tap \"Open authenticator app\", or scan this QR code with another phone, or type the setup key into the app.'**
  String get totpStep1;

  /// No description provided for @totpStep2.
  ///
  /// In en, this message translates to:
  /// **'2. Enter the 6-digit code the app shows.'**
  String get totpStep2;

  /// No description provided for @totpTitle.
  ///
  /// In en, this message translates to:
  /// **'Authenticator app'**
  String get totpTitle;

  /// No description provided for @totpTurnOff.
  ///
  /// In en, this message translates to:
  /// **'Turn off'**
  String get totpTurnOff;

  /// No description provided for @trimesterFirst.
  ///
  /// In en, this message translates to:
  /// **'First trimester'**
  String get trimesterFirst;

  /// No description provided for @trimesterLabel.
  ///
  /// In en, this message translates to:
  /// **'Trimester'**
  String get trimesterLabel;

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

  /// No description provided for @ultrasoundCopyHint.
  ///
  /// In en, this message translates to:
  /// **'Copy the numbers from your scan report. Leave blank anything the report does not include.'**
  String get ultrasoundCopyHint;

  /// No description provided for @ultrasoundNeedOneValue.
  ///
  /// In en, this message translates to:
  /// **'Please enter at least one measurement.'**
  String get ultrasoundNeedOneValue;

  /// No description provided for @unitBpm.
  ///
  /// In en, this message translates to:
  /// **'bpm'**
  String get unitBpm;

  /// No description provided for @unitHours.
  ///
  /// In en, this message translates to:
  /// **'h'**
  String get unitHours;

  /// No description provided for @unitSteps.
  ///
  /// In en, this message translates to:
  /// **'steps'**
  String get unitSteps;

  /// No description provided for @unitWeeksShort.
  ///
  /// In en, this message translates to:
  /// **'weeks'**
  String get unitWeeksShort;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @uploadedBy.
  ///
  /// In en, this message translates to:
  /// **'Added by {name}'**
  String uploadedBy(String name);

  /// No description provided for @vaccinationPurpose.
  ///
  /// In en, this message translates to:
  /// **'Vaccination: {name}'**
  String vaccinationPurpose(String name);

  /// No description provided for @vaccineAlreadyHad.
  ///
  /// In en, this message translates to:
  /// **'I have already had it – record it'**
  String get vaccineAlreadyHad;

  /// No description provided for @vaccineBook.
  ///
  /// In en, this message translates to:
  /// **'Book vaccination appointment'**
  String get vaccineBook;

  /// No description provided for @vaccineBookHint.
  ///
  /// In en, this message translates to:
  /// **'Tick the box above to book.'**
  String get vaccineBookHint;

  /// No description provided for @vaccineConfirmRead.
  ///
  /// In en, this message translates to:
  /// **'I have read what this vaccine does and its price.'**
  String get vaccineConfirmRead;

  /// No description provided for @vaccineDemoPrice.
  ///
  /// In en, this message translates to:
  /// **'Demo price, for illustration only.'**
  String get vaccineDemoPrice;

  /// No description provided for @vaccineDoctorConfirms.
  ///
  /// In en, this message translates to:
  /// **'Your doctor will confirm at the appointment whether this vaccine is right for you.'**
  String get vaccineDoctorConfirms;

  /// No description provided for @vaccineDueNow.
  ///
  /// In en, this message translates to:
  /// **'Due now'**
  String get vaccineDueNow;

  /// No description provided for @vaccineGiven.
  ///
  /// In en, this message translates to:
  /// **'Given'**
  String get vaccineGiven;

  /// No description provided for @vaccineGivenOn.
  ///
  /// In en, this message translates to:
  /// **'Given on {date}'**
  String vaccineGivenOn(String date);

  /// No description provided for @vaccineHistory.
  ///
  /// In en, this message translates to:
  /// **'Vaccination history'**
  String get vaccineHistory;

  /// No description provided for @vaccineHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No vaccinations recorded.'**
  String get vaccineHistoryEmpty;

  /// No description provided for @vaccineNoDescription.
  ///
  /// In en, this message translates to:
  /// **'Your clinic has not added a description yet.'**
  String get vaccineNoDescription;

  /// No description provided for @vaccinePending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get vaccinePending;

  /// No description provided for @vaccinePriceAt.
  ///
  /// In en, this message translates to:
  /// **'At {clinic}'**
  String vaccinePriceAt(String clinic);

  /// No description provided for @vaccinePriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get vaccinePriceLabel;

  /// No description provided for @vaccinePriceUnknown.
  ///
  /// In en, this message translates to:
  /// **'Ask your clinic for the price.'**
  String get vaccinePriceUnknown;

  /// No description provided for @vaccineTapForDetails.
  ///
  /// In en, this message translates to:
  /// **'Details and price'**
  String get vaccineTapForDetails;

  /// No description provided for @vaccineWhatItDoes.
  ///
  /// In en, this message translates to:
  /// **'What it does'**
  String get vaccineWhatItDoes;

  /// No description provided for @vaccineWhen.
  ///
  /// In en, this message translates to:
  /// **'When'**
  String get vaccineWhen;

  /// No description provided for @vaccinesTitle.
  ///
  /// In en, this message translates to:
  /// **'Vaccines'**
  String get vaccinesTitle;

  /// No description provided for @verificationStatus.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verificationStatus;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionLabel(String version);

  /// No description provided for @warningSignLogNow.
  ///
  /// In en, this message translates to:
  /// **'I have this now — log it'**
  String get warningSignLogNow;

  /// No description provided for @warningSignsIntro.
  ///
  /// In en, this message translates to:
  /// **'If you have any of these, get help now. Do not wait for your next appointment.'**
  String get warningSignsIntro;

  /// No description provided for @warningSignsTitle.
  ///
  /// In en, this message translates to:
  /// **'Warning signs'**
  String get warningSignsTitle;

  /// No description provided for @waterTodayMl.
  ///
  /// In en, this message translates to:
  /// **'{amount} ml today'**
  String waterTodayMl(String amount);

  /// No description provided for @welcomeCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get welcomeCreateAccount;

  /// No description provided for @welcomeDemoHint.
  ///
  /// In en, this message translates to:
  /// **'Demo build: sign in as demo.patient@example.com (Gwen, pregnant), demo.cycle@example.com (Aina, cycle tracking) or demo.doctor@example.com, with code {code}. Demo data resets when the app restarts.'**
  String welcomeDemoHint(String code);

  /// No description provided for @welcomeSignIn.
  ///
  /// In en, this message translates to:
  /// **'I already have an account'**
  String get welcomeSignIn;

  /// No description provided for @welcomeTagline.
  ///
  /// In en, this message translates to:
  /// **'Your pregnancy, cycle and women\'s health record, shared with your care team.'**
  String get welcomeTagline;

  /// No description provided for @yourDoctors.
  ///
  /// In en, this message translates to:
  /// **'Your doctors'**
  String get yourDoctors;
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
