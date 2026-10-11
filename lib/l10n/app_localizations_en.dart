// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get aboutRegulatory =>
      'Development build for clinical workflow design. Not a registered medical device under the Medical Device Act 2012 (Act 737).';

  @override
  String get accessLogExplainer =>
      'Every time you open a patient record it is logged. Patients and administrators can review this.';

  @override
  String get accessLogTitle => 'My access log';

  @override
  String accessLogViewed(String id) {
    return 'Viewed record $id';
  }

  @override
  String get actionAccept => 'Accept';

  @override
  String get actionAdd => 'Add';

  @override
  String get actionBabyDelivered => 'Baby delivered';

  @override
  String get actionBack => 'Back';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionConfirm => 'Confirm';

  @override
  String get actionConnect => 'Connect';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionCopy => 'Copy';

  @override
  String get actionDecline => 'Decline';

  @override
  String get actionDecrease => 'Decrease';

  @override
  String get actionDisconnect => 'Disconnect';

  @override
  String get actionEndPostpartum => 'Move to general care';

  @override
  String get actionFinish => 'Finish';

  @override
  String get actionGoHome => 'Go to Home';

  @override
  String get actionImPregnant => 'I\'m pregnant';

  @override
  String get actionIncrease => 'Increase';

  @override
  String get actionNextDay => 'Next day';

  @override
  String get actionNextMonth => 'Next month';

  @override
  String get actionNotNow => 'Not now';

  @override
  String get actionOk => 'OK';

  @override
  String get actionPreviousDay => 'Previous day';

  @override
  String get actionPreviousMonth => 'Previous month';

  @override
  String get actionRetry => 'Try again';

  @override
  String get actionSave => 'Save';

  @override
  String get actionScan => 'Scan for devices';

  @override
  String get actionSendCode => 'Send code';

  @override
  String get actionSignOut => 'Sign out';

  @override
  String get actionToday => 'Back to today';

  @override
  String get actionUnderstood => 'I understand';

  @override
  String get actionUndoLast => 'Undo last';

  @override
  String get actionVerify => 'Verify';

  @override
  String get activityActive => 'Very active';

  @override
  String get activityEmpty => 'Your recent records will appear here.';

  @override
  String get activityLight => 'Lightly active';

  @override
  String get activityModerate => 'Moderately active';

  @override
  String get activitySedentary => 'Mostly sitting';

  @override
  String get addAppointmentTitle => 'Add appointment';

  @override
  String get addDocumentTitle => 'Add document';

  @override
  String get addFoodTitle => 'Add food';

  @override
  String get addHealthLogTitle => 'Add health log';

  @override
  String get addMilestoneTitle => 'Add milestone';

  @override
  String get addNoteTitle => 'Add a note';

  @override
  String get addUltrasoundTitle => 'Add scan results';

  @override
  String ageYears(int age) {
    return '$age years';
  }

  @override
  String alertCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alerts',
      one: '1 alert',
    );
    return '$_temp0';
  }

  @override
  String alertWarningSign(String name) {
    return 'Warning sign: $name';
  }

  @override
  String alertsExplainer(int days) {
    return 'Readings outside the configured ranges and warning signs logged in the last $days days.';
  }

  @override
  String get alertsNone => 'Nothing needs review right now.';

  @override
  String get alertsToReview => 'Alerts to review';

  @override
  String get answerNo => 'No';

  @override
  String get answerYes => 'Yes';

  @override
  String get appName => 'Maternal Care';

  @override
  String get appearanceDark => 'Dark';

  @override
  String get appearanceExplainer =>
      'Light mode is the default. Choose Dark for night use, or follow your phone setting.';

  @override
  String get appearanceLight => 'Light';

  @override
  String get appearanceSystem => 'Same as phone';

  @override
  String get appointmentDefaultPurpose => 'Appointment';

  @override
  String get appointmentsNoneToday => 'No appointments today.';

  @override
  String get appointmentsNoneUpcoming => 'No upcoming appointments.';

  @override
  String get appointmentsTitle => 'Appointments';

  @override
  String get assistantBadKey =>
      'The AI service refused the Gemini API key. Check the key in Profile > Connections.';

  @override
  String get assistantBlocked =>
      'The AI service did not answer this question. Please ask it another way.';

  @override
  String get assistantEducational => 'Educational information';

  @override
  String get assistantFailed =>
      'The answer could not be loaded. Please try again.';

  @override
  String get assistantHomeHint =>
      'AI answers in English, BM, 中文 or தமிழ். Educational, not a diagnosis.';

  @override
  String get assistantInputHint => 'Type your question';

  @override
  String get assistantLanguage => 'Answer in';

  @override
  String get assistantNetwork =>
      'Could not reach the AI service. Check your internet connection and try again.';

  @override
  String get assistantNewChat => 'New conversation';

  @override
  String get assistantNotConfigured =>
      'The AI assistant needs a Gemini API key before it can answer. Add one in Profile > Connections, or ask the app\'s administrator to build it into the app.';

  @override
  String get assistantSend => 'Send';

  @override
  String get assistantThinking => 'Thinking...';

  @override
  String get assistantTitle => 'Ask a question';

  @override
  String get assistantUseDetails => 'Use my pregnancy details';

  @override
  String get assistantUseDetailsHelp =>
      'Off: nothing from your records is sent. On: only your stage (for example 32 weeks) is shared, never your name.';

  @override
  String atGestation(String ga) {
    return 'at $ga';
  }

  @override
  String get authAuthenticatorHelp =>
      'Enter the 6-digit code that your authenticator app shows for Maternal.';

  @override
  String get authCancelled => 'Sign-in was cancelled.';

  @override
  String get authEmailNotSetUp =>
      'Real email codes are not set up yet (Connections).';

  @override
  String get authInvalidCode =>
      'That code is not right. Please check and try again.';

  @override
  String get authInvalidIdentifier =>
      'Please enter a valid phone number or email.';

  @override
  String get authNoAccountYet =>
      'Verified. There is no account yet, so let\'s create one.';

  @override
  String get authSendCodeInstead => 'Send a code by SMS or email instead';

  @override
  String authSendFailed(String reason) {
    return 'Could not send or check the code. $reason';
  }

  @override
  String get authSmsNotSetUp =>
      'Real SMS codes and Google sign-in are not set up yet (Connections).';

  @override
  String get babiesMore => 'More';

  @override
  String get babiesSingle => 'Single';

  @override
  String get babiesTriplets => 'Triplets';

  @override
  String get babiesTwins => 'Twins';

  @override
  String get babyParameters => 'Baby\'s measurements';

  @override
  String bluetoothBattery(int level) {
    return 'Battery $level%';
  }

  @override
  String get bluetoothConnectFailed =>
      'Could not connect. Keep the watch close to the phone and try again.';

  @override
  String get bluetoothDenied =>
      'Bluetooth permission was not given. Allow \"Nearby devices\" for Maternal in your phone\'s Settings > Apps, then try again.';

  @override
  String get bluetoothFindWatch => 'Turn on Bluetooth and find my watch';

  @override
  String get bluetoothHasHeartRate => 'Shares heart rate';

  @override
  String bluetoothHeartRate(int bpm) {
    return '$bpm bpm';
  }

  @override
  String get bluetoothLost => 'The watch disconnected.';

  @override
  String get bluetoothNoHeartRate =>
      'This device does not share heart rate over Bluetooth. On many watches you can turn on \"Broadcast heart rate\" (HR broadcast) in the watch settings.';

  @override
  String get bluetoothNoneFound => 'No devices found yet.';

  @override
  String get bluetoothOff => 'Bluetooth is off. Turn it on and try again.';

  @override
  String get bluetoothPromptTitle => 'Connect your watch?';

  @override
  String get bluetoothRationale =>
      'To find nearby devices the app needs Bluetooth permission. It is used only to connect health devices you choose.';

  @override
  String bluetoothReconnect(String name) {
    return 'Reconnect $name';
  }

  @override
  String get bluetoothScanHelp =>
      'Keep the watch awake and close to the phone. Devices that share heart rate are listed first.';

  @override
  String get bluetoothTitle => 'Bluetooth devices';

  @override
  String get bluetoothUnsupported =>
      'This phone does not support Bluetooth Low Energy.';

  @override
  String get bluetoothWaitingForReading => 'Waiting for a reading…';

  @override
  String get bluetoothWatchBody =>
      'Pair a watch or fitness band over Bluetooth. Heart-rate readings sync straight into your Health log.';

  @override
  String callDoctor(String name) {
    return 'Call $name';
  }

  @override
  String callEmergency(String number) {
    return 'Call $number';
  }

  @override
  String callManually(String number) {
    return 'Could not open the dialer. Please call $number.';
  }

  @override
  String calorieAnalysis(int days, String average, String percent) {
    return 'On the $days days you logged, you ate $average kcal on average, about $percent% of your target. Ask your care team what is right for you.';
  }

  @override
  String calorieAnalysisNoTarget(int days, String average) {
    return 'On the $days days you logged, you ate $average kcal on average.';
  }

  @override
  String get calorieAnalysisTooFew =>
      'Log at least three days to see a summary.';

  @override
  String calorieChartSummary(int range, int logged) {
    return 'Calories per day for the last $range days; $logged days logged.';
  }

  @override
  String get calorieHistory => 'History';

  @override
  String get calorieNoData =>
      'No food logged in this period. Start logging food or connect your watch.';

  @override
  String get calorieNoTargetBody =>
      'Add your date of birth, height and weight to see an estimated daily target.';

  @override
  String get calorieNoTargetTitle => 'No target yet';

  @override
  String get calorieTarget => 'Daily target';

  @override
  String get careTeamEmpty => 'No doctors linked yet.';

  @override
  String get careTeamIntro =>
      'Doctors here can see the records you share. Remove access at any time.';

  @override
  String get channelEmail => 'Email';

  @override
  String get channelPhone => 'Phone';

  @override
  String get chartBandNote =>
      'The shaded band is the typical range from your care team\'s settings.';

  @override
  String chartSummary(String name, int count, String latest) {
    return 'Chart of $name: $count readings, latest $latest.';
  }

  @override
  String get chartTargetLineNote => 'The dashed line is your daily target.';

  @override
  String get clinicalSummary => 'Clinical summary';

  @override
  String get colGestation => 'Gestation';

  @override
  String get colScan => 'Scan';

  @override
  String get connectionsAiBody =>
      'Create a free key at aistudio.google.com > Get API key. The model can stay as gemini-flash-latest.';

  @override
  String get connectionsAiTitle => 'AI assistant (Google Gemini)';

  @override
  String get connectionsBuiltIn => 'Built into this app';

  @override
  String get connectionsEmailBody =>
      'In EmailJS, add a Gmail service and an email template whose \"To\" is to_email and whose message shows passcode. Turn on \"Allow EmailJS API for non-browser applications\" under Account > Security, and copy the private key too.';

  @override
  String get connectionsEmailTitle => 'Email codes (EmailJS + Gmail)';

  @override
  String get connectionsFirebaseBody =>
      'In the Firebase console, add an Android app with the package and fingerprints below, turn on Phone and Google under Authentication > Sign-in method, then copy the values from Project settings.';

  @override
  String get connectionsFirebaseTitle =>
      'SMS codes and Google sign-in (Firebase)';

  @override
  String get connectionsIntro =>
      'Keys for the AI assistant, email codes, SMS codes and Google sign-in. Keys typed here stay on this phone and replace the ones built into the app. Leave a box empty to use the built-in key.';

  @override
  String get connectionsMissing => 'Not set';

  @override
  String get connectionsRestartNote =>
      'After changing the Firebase values, close and reopen the app.';

  @override
  String get connectionsSetHere => 'Set on this phone';

  @override
  String get connectionsTitle => 'Connections';

  @override
  String get contentPendingReview =>
      'This schedule is demo content pending review by a qualified clinician against Malaysian guidance. Always follow your care team.';

  @override
  String contentVersion(String version) {
    return 'Clinical content version $version';
  }

  @override
  String get contractionAvgDuration => 'Average length';

  @override
  String get contractionAvgInterval => 'Average time apart';

  @override
  String contractionDuration(String duration) {
    return 'Lasted $duration';
  }

  @override
  String get contractionEmpty => 'Contractions you time will appear here.';

  @override
  String contractionGap(String gap) {
    return '$gap after the previous one';
  }

  @override
  String get contractionHistory => 'History';

  @override
  String contractionLastHour(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count contractions in the last hour',
      one: '1 contraction in the last hour',
      zero: 'No contractions in the last hour',
    );
    return '$_temp0';
  }

  @override
  String get contractionStart => 'Contraction started';

  @override
  String get contractionStop => 'Contraction ended';

  @override
  String get contractionTapToStop => 'Tap when it ends';

  @override
  String get contractionTitle => 'Contraction timer';

  @override
  String get contractionTooShort =>
      'That was only a few seconds, so it was not saved.';

  @override
  String get copied => 'Copied';

  @override
  String get createAppointment => 'Appointment';

  @override
  String get createAskAi => 'Ask AI';

  @override
  String get createContractions => 'Contractions';

  @override
  String get createDocument => 'Document';

  @override
  String get createFood => 'Food';

  @override
  String get createGroupCare => 'Care';

  @override
  String get createGroupHealth => 'Health';

  @override
  String get createGroupNutrition => 'Nutrition';

  @override
  String get createGroupPregnancy => 'Pregnancy';

  @override
  String get createHealthLog => 'Health log';

  @override
  String get createKickCounter => 'Kick counter';

  @override
  String get createMedication => 'Medication';

  @override
  String get createMilestone => 'Milestone';

  @override
  String get createPeriod => 'Period';

  @override
  String get createSymptoms => 'Symptoms';

  @override
  String get createTitle => 'What would you like to add?';

  @override
  String get createUltrasound => 'Scan results';

  @override
  String get createVaccine => 'Vaccine';

  @override
  String get createWater => 'Water';

  @override
  String cycleAverageLength(int days) {
    return 'Cycle about $days days';
  }

  @override
  String cycleBasedOnRecords(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Based on the $count periods you recorded. Each new record updates the following months.',
    );
    return '$_temp0';
  }

  @override
  String get cycleBasedOnTypical => 'Based on a typical cycle';

  @override
  String cycleDaysLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days later than expected',
      one: '1 day later than expected',
    );
    return '$_temp0';
  }

  @override
  String cycleFertileWindow(String start, String end) {
    return 'Estimated fertile window: $start – $end';
  }

  @override
  String cycleInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'In $days days',
      one: 'In 1 day',
      zero: 'Expected today',
    );
    return '$_temp0';
  }

  @override
  String get cycleIrregularWarning =>
      'Your cycles have varied a lot, so these estimates may be less accurate.';

  @override
  String get cycleLogToday => 'Log period';

  @override
  String get cycleNeedSecondPeriod =>
      'Based on a typical 28-day cycle. Record your next period and predictions will follow your own rhythm.';

  @override
  String get cycleNextPeriod => 'Next period';

  @override
  String get cycleNoData =>
      'Log the days of your period. After two periods we can estimate your next one.';

  @override
  String get cycleNoEstimate => 'Log your period to see an estimate.';

  @override
  String cycleOvulation(String date) {
    return 'Estimated ovulation: $date';
  }

  @override
  String get cyclePausedInPregnancy =>
      'Cycle predictions are paused during pregnancy. Your period history is kept.';

  @override
  String cyclePeriodLength(int days) {
    return 'Period about $days days';
  }

  @override
  String cycleShiftEarlier(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Your last period started $days days earlier than predicted, so the next dates moved.',
      one: 'Your last period started 1 day earlier than predicted, so the next dates moved.',
    );
    return '$_temp0';
  }

  @override
  String cycleShiftLater(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Your last period started $days days later than predicted, so the next dates moved.',
      one: 'Your last period started 1 day later than predicted, so the next dates moved.',
    );
    return '$_temp0';
  }

  @override
  String get cycleStale =>
      'Your expected period is more than a cycle late. Log your latest period to update the estimates.';

  @override
  String get cycleUpcomingTitle => 'Following periods (estimate)';

  @override
  String get dayAppointments => 'Appointments';

  @override
  String get dayHealthLogs => 'Health logs';

  @override
  String get dayNotes => 'Notes';

  @override
  String get dayPeriod => 'Period';

  @override
  String get daySymptoms => 'Symptoms';

  @override
  String daysPastDue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days past the due date',
      one: '1 day past the due date',
    );
    return '$_temp0';
  }

  @override
  String daysToGo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days to go',
      one: '1 day to go',
      zero: 'Due today',
    );
    return '$_temp0';
  }

  @override
  String deliveredConfirmBody(String date) {
    return 'We will close this pregnancy on $date and start postpartum care. Your pregnancy records stay in your history.';
  }

  @override
  String get deliveredConfirmTitle => 'Congratulations!';

  @override
  String deliveredOn(String date) {
    return 'Delivered on $date';
  }

  @override
  String get deliveredSaved => 'Postpartum care started.';

  @override
  String get demoModeBody =>
      'You are seeing clearly labelled demo data. Nothing is sent to a server, and records reset when the app restarts.';

  @override
  String get demoModeTitle => 'Demo mode';

  @override
  String get demoUseCyclePatient => 'Aina (cycle)';

  @override
  String get demoUseDoctor => 'Dr. Chua (doctor)';

  @override
  String get demoUsePatient => 'Gwen (pregnant)';

  @override
  String get devicesTitle => 'Connected devices';

  @override
  String get disclaimer =>
      'This app supports, but does not replace, care from your doctor. It does not diagnose. Clinical content is pending review by a qualified clinician.';

  @override
  String get docBloodTest => 'Blood test';

  @override
  String get docHospital => 'Hospital document';

  @override
  String get docOther => 'Other';

  @override
  String get docPrescription => 'Prescription';

  @override
  String get docUltrasound => 'Ultrasound';

  @override
  String get docVaccination => 'Vaccination record';

  @override
  String doctorGreeting(String name) {
    return 'Good day, $name';
  }

  @override
  String get doctorNavDashboard => 'Dashboard';

  @override
  String get doctorNavPatients => 'Patients';

  @override
  String get doctorPendingBody =>
      'An administrator is checking your MMC registration. You will be able to see linked patients once it is approved.';

  @override
  String get doctorPendingTitle => 'Waiting for verification';

  @override
  String get documentSearchEmpty => 'No documents match.';

  @override
  String get documentSearchHint => 'Search titles and text in documents';

  @override
  String get documentStorageNote =>
      'In this demo the file stays on your phone. In the full app it is encrypted and stored privately, and only your linked doctors can open it.';

  @override
  String get documentsEmpty => 'No documents yet.';

  @override
  String get documentsTitle => 'Medical documents';

  @override
  String dueDateGaPreview(String ga) {
    return 'That means you are $ga today.';
  }

  @override
  String get dueDateHelper => 'From your doctor or scan report.';

  @override
  String dueDateInvalidBody(String date) {
    return 'The saved due date ($date) does not match an ongoing pregnancy, so we are not showing weeks or a countdown.';
  }

  @override
  String get dueDateInvalidTitle => 'Please check your due date';

  @override
  String get dueDateTooFarFuture =>
      'This date is more than 40 weeks away. Please check it.';

  @override
  String get dueDateTooFarPast =>
      'This date is too far in the past for an ongoing pregnancy. Please check it.';

  @override
  String dueOn(String date) {
    return 'Due $date';
  }

  @override
  String emergencyNumberNote(String number) {
    return 'In an emergency in Malaysia, call $number.';
  }

  @override
  String get errorEnterNumber => 'Please enter a number.';

  @override
  String errorOutOfRange(String min, String max) {
    return 'Please enter a value between $min and $max.';
  }

  @override
  String get errorRequired => 'Please fill this in.';

  @override
  String get estimateLabel => 'Estimate';

  @override
  String get fetalAc => 'Abdominal circumference';

  @override
  String get fetalAfi => 'Amniotic fluid index';

  @override
  String get fetalBpd => 'Biparietal diameter';

  @override
  String get fetalCrl => 'Crown-rump length';

  @override
  String get fetalEfw => 'Estimated weight';

  @override
  String get fetalFhr => 'Fetal heart rate';

  @override
  String get fetalFl => 'Femur length';

  @override
  String get fetalHc => 'Head circumference';

  @override
  String get fetalNt => 'Nuchal translucency';

  @override
  String get fieldActivityLevel => 'Activity level';

  @override
  String get fieldAllergies => 'Allergies';

  @override
  String get fieldBloodGroup => 'Blood group';

  @override
  String get fieldCalories => 'Calories';

  @override
  String get fieldCategory => 'Category';

  @override
  String get fieldClinic => 'Clinic or hospital';

  @override
  String get fieldClinicHospital => 'Clinic or hospital';

  @override
  String get fieldDate => 'Date';

  @override
  String get fieldDateOfBirth => 'Date of birth';

  @override
  String get fieldDescription => 'Description';

  @override
  String get fieldDiastolic => 'Diastolic (lower)';

  @override
  String get fieldDoctor => 'Doctor';

  @override
  String get fieldDocumentDate => 'Date on the document';

  @override
  String get fieldDueDate => 'Expected due date';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldFlow => 'Flow';

  @override
  String get fieldFoodName => 'Food or drink';

  @override
  String get fieldFullName => 'Full name';

  @override
  String get fieldGlucoseContext => 'When was it measured?';

  @override
  String get fieldHeight => 'Height';

  @override
  String get fieldMeal => 'Meal';

  @override
  String get fieldMeasurement => 'What are you recording?';

  @override
  String get fieldMedicalHistory => 'Medical history';

  @override
  String get fieldMilestone => 'Milestone';

  @override
  String get fieldMmcHelper =>
      'Checked by an administrator before you can see patient data.';

  @override
  String get fieldMmcNumber => 'MMC registration number';

  @override
  String get fieldNote => 'Note';

  @override
  String get fieldNotesOptional => 'Notes (optional)';

  @override
  String get fieldNumberOfBabies => 'Number of babies';

  @override
  String get fieldOtp => 'One-time code';

  @override
  String get fieldPhone => 'Phone number';

  @override
  String get fieldPhoneOrEmail => 'Phone or email';

  @override
  String get fieldPortion => 'Portion';

  @override
  String get fieldPrePregnancyWeight => 'Pre-pregnancy weight';

  @override
  String get fieldPreferredLanguage => 'Preferred language';

  @override
  String get fieldPurpose => 'Purpose';

  @override
  String get fieldScanType => 'Scan type';

  @override
  String get fieldSeverity => 'How strong?';

  @override
  String get fieldSystolic => 'Systolic (upper)';

  @override
  String get fieldTime => 'Time';

  @override
  String get fieldTitle => 'Title';

  @override
  String get filterPending => 'Request';

  @override
  String get flowHeavy => 'Heavy';

  @override
  String get flowLight => 'Light';

  @override
  String get flowMedium => 'Medium';

  @override
  String get flowNone => 'None';

  @override
  String get flowSpotting => 'Spotting';

  @override
  String gaWeeksDays(int weeks, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks weeks',
      one: '1 week',
    );
    String _temp1 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days',
      one: '1 day',
      zero: '0 days',
    );
    return '$_temp0 $_temp1';
  }

  @override
  String get glucoseAfterMeal => 'After a meal';

  @override
  String get glucoseFasting => 'Fasting';

  @override
  String get glucoseRandom => 'Other time';

  @override
  String get gravidaPara => 'Gravida / para';

  @override
  String get growthCompareScans => 'Compare scans';

  @override
  String get growthNoScans => 'No scans recorded yet.';

  @override
  String get healthConnectBody =>
      'Bring in steps, heart rate, sleep and other data your phone or watch already records.';

  @override
  String get healthConnectDemoNote =>
      'Health Connect below still uses demo readings in this build. Bluetooth above is real.';

  @override
  String get healthConnectRationale =>
      'We read only the data types you allow, and only after you agree. You can disconnect at any time.';

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String homeGreeting(String name) {
    return 'Hi, $name';
  }

  @override
  String get homeNextAppointment => 'Upcoming appointment';

  @override
  String get homeRecentActivity => 'Latest health activity';

  @override
  String get homeTabBaby => 'Baby';

  @override
  String get homeTabMother => 'Mother';

  @override
  String get homeTodaysHealth => 'Today\'s health';

  @override
  String get homeTodaysTasks => 'Today\'s tasks';

  @override
  String get intimacyPrivateNote =>
      'Private: only you can see this unless you choose to share it in Privacy.';

  @override
  String get journeyGeneral => 'Women\'s health';

  @override
  String get journeyPostpartum => 'Postpartum';

  @override
  String get journeyPregnancy => 'Pregnant';

  @override
  String get kcalBurntNotConnected =>
      'Calories burnt: connect a watch or Health Connect';

  @override
  String get kcalConsumed => 'eaten';

  @override
  String kcalOver(String kcal) {
    return '$kcal kcal over target';
  }

  @override
  String kcalRemaining(String kcal) {
    return '$kcal kcal remaining';
  }

  @override
  String get kickCounterTitle => 'Kick counter';

  @override
  String get kickGuarded => 'Counted as the same movement as your last tap.';

  @override
  String get kickTapButton => 'Tap for each movement';

  @override
  String kicksChartSummary(int count) {
    return 'Bar chart of movements per hour today. Total $count.';
  }

  @override
  String kicksCount(int count) {
    return '$count';
  }

  @override
  String get kicksPastDays => 'Previous days';

  @override
  String get kicksPerHourTitle => 'Movements per hour today';

  @override
  String kicksTodayCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count movements today',
      one: '1 movement today',
      zero: 'No movements counted today',
    );
    return '$_temp0';
  }

  @override
  String get languageSwitchLabel => 'App language';

  @override
  String lastKickAt(String time) {
    return 'Last movement at $time';
  }

  @override
  String lastNDays(int days) {
    return '$days days';
  }

  @override
  String get legendAppointment => 'Appointment';

  @override
  String get legendFertile => 'Fertile window (estimate)';

  @override
  String get legendLogged => 'Health log';

  @override
  String get legendMedication => 'Medication taken';

  @override
  String get legendPeriod => 'Period';

  @override
  String get legendPredicted => 'Predicted period';

  @override
  String get linkActive => 'Can see your shared records';

  @override
  String get linkPending => 'Waiting for the doctor to accept';

  @override
  String get loginChangeIdentifier => 'Use a different phone or email';

  @override
  String get loginIntro =>
      'Enter your phone number or email. We will send you a one-time code.';

  @override
  String get loginRecoveryHint =>
      'Can\'t receive codes on this phone or email? Contact your clinic to recover your account.';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get macroCarbs => 'Carbs';

  @override
  String get macroFat => 'Fat';

  @override
  String get macroProtein => 'Protein';

  @override
  String macroSummary(String protein, String carbs, String fat) {
    return 'P $protein g · C $carbs g · F $fat g';
  }

  @override
  String get mealBreakfast => 'Breakfast';

  @override
  String get mealDinner => 'Dinner';

  @override
  String get mealDrinks => 'Drinks';

  @override
  String get mealLunch => 'Lunch';

  @override
  String get mealSnacks => 'Snacks';

  @override
  String get medicationSafetyNote =>
      'Only add medicines as prescribed by your doctor. This list is a reminder, not medical advice.';

  @override
  String get medicationsNoneToday => 'No doses scheduled today.';

  @override
  String get medicationsTitle => 'Medications';

  @override
  String get medicationsToday => 'Today';

  @override
  String get menuAbout => 'About';

  @override
  String get menuAppearance => 'Appearance';

  @override
  String get menuCareTeam => 'My care team';

  @override
  String get menuEmergencyContact => 'Emergency contact';

  @override
  String get menuNotifications => 'Notifications';

  @override
  String get menuPersonalInfo => 'Personal information';

  @override
  String get menuPregnancyInfo => 'Pregnancy information';

  @override
  String get menuPrivacy => 'Privacy and data';

  @override
  String get milestoneHint => 'e.g. Felt first kicks';

  @override
  String get moodGood => 'Good';

  @override
  String get moodGreat => 'Great';

  @override
  String get moodLow => 'Low';

  @override
  String get moodOkay => 'Okay';

  @override
  String get moodVeryLow => 'Very low';

  @override
  String get navCalendar => 'Calendar';

  @override
  String get navCalories => 'Calories';

  @override
  String get navCreate => 'Create';

  @override
  String get navHome => 'Home';

  @override
  String get navProfile => 'Profile';

  @override
  String get noData => 'No data yet';

  @override
  String get noDataTapToAdd => 'No data yet. Tap to add.';

  @override
  String get noReadingsInPeriod => 'No readings in this period.';

  @override
  String get noReadingsYet => 'No readings yet.';

  @override
  String get nothingLogged => 'Nothing recorded.';

  @override
  String get notifAppointments => 'Appointments';

  @override
  String get notifDoctorMessages => 'Messages from my doctor';

  @override
  String get notifHealthLogs => 'Health log reminders';

  @override
  String get notifLockScreenDetails => 'Show details on lock screen';

  @override
  String get notifLockScreenHelp => 'Off by default to protect your privacy.';

  @override
  String get notifMedication => 'Medication';

  @override
  String get notifMilestones => 'Pregnancy milestones';

  @override
  String get notifVaccines => 'Vaccines';

  @override
  String get notificationsRationale =>
      'We use notifications to remind you about appointments, health logs and important pregnancy milestones.';

  @override
  String get obsActivity => 'Steps';

  @override
  String get obsBloodGlucose => 'Blood glucose';

  @override
  String get obsBloodPressure => 'Blood pressure';

  @override
  String get obsHeartRate => 'Heart rate';

  @override
  String get obsMood => 'Mood';

  @override
  String get obsSleep => 'Sleep';

  @override
  String get obsSpo2 => 'Oxygen (SpO2)';

  @override
  String get obsTemperature => 'Temperature';

  @override
  String get obsWater => 'Water';

  @override
  String get obsWeight => 'Weight';

  @override
  String get onboardingBodySubtitle =>
      'Used for weight and calorie estimates. You can change it later.';

  @override
  String get onboardingBodyTitle => 'Your body';

  @override
  String onboardingDemoCode(String code) {
    return 'Demo build: use code $code.';
  }

  @override
  String get onboardingDoctorDoneSubtitle =>
      'An administrator will verify your registration before you can see any patient data.';

  @override
  String get onboardingDoctorDoneTitle => 'Almost there';

  @override
  String get onboardingDoneSubtitle =>
      'Everything you record from now on is kept together in one place.';

  @override
  String get onboardingDoneTitle => 'Your profile is ready';

  @override
  String get onboardingNotPregnantInfo =>
      'We will set up cycle tracking and general women\'s health. You can start a pregnancy later from your profile.';

  @override
  String get onboardingPersonalSubtitle =>
      'This helps us personalize your care.';

  @override
  String get onboardingPersonalTitle => 'About you';

  @override
  String get onboardingPregnancySubtitle =>
      'This shapes your home screen. You can change it any time.';

  @override
  String get onboardingPregnancyTitle => 'Are you currently pregnant?';

  @override
  String get onboardingRoleSubtitle =>
      'Choose one. You can only see what your role allows.';

  @override
  String get onboardingRoleTitle => 'Who is using the app?';

  @override
  String onboardingStepOf(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get onboardingVerifySubtitle =>
      'Choose phone or email and we will send a one-time code.';

  @override
  String get onboardingVerifyTitle => 'Verify your account';

  @override
  String otpSentTo(String destination) {
    return 'Code sent to $destination';
  }

  @override
  String get outsideRangeBody =>
      'Your reading is saved. It is outside the typical range in your care team\'s settings. If you feel unwell or notice any warning signs, contact your care team. This is not a diagnosis.';

  @override
  String get outsideRangeTitle => 'Reading outside the typical range';

  @override
  String get painMild => 'Mild';

  @override
  String get painModerate => 'Moderate';

  @override
  String get painSevere => 'Severe';

  @override
  String get past => 'Past';

  @override
  String get patientId => 'Patient ID';

  @override
  String get patientSearchEmpty => 'No patients match.';

  @override
  String get patientSearchHint => 'Search name, ID, phone or due date';

  @override
  String percentileFromReport(String value) {
    return 'Percentile $value (from report)';
  }

  @override
  String get periodDayTitle => 'Period and cycle log';

  @override
  String get permissionsBody =>
      'The app asks for notifications, Bluetooth, camera or photos only when you first use a feature that needs them. You can change these at any time in your phone settings.';

  @override
  String get permissionsTitle => 'Permissions';

  @override
  String get portionHint => 'e.g. 1 plate, 250 ml';

  @override
  String postpartumSince(int weeks, int days) {
    return '$weeks weeks $days days since delivery';
  }

  @override
  String get pregnancyStartInfo =>
      'Saving will start a new pregnancy in your record. Your earlier history stays.';

  @override
  String get privacyIntro =>
      'Your health records belong to you. Only doctors you link with can see them, and only the parts you choose to share.';

  @override
  String get purposeHint => 'e.g. Antenatal check';

  @override
  String get rangeAbove => 'Above range';

  @override
  String get rangeBelow => 'Below range';

  @override
  String get rangeWithin => 'In range';

  @override
  String get readingsTitle => 'Readings';

  @override
  String get recentFoods => 'Recent foods';

  @override
  String reminderAppointmentToday(String purpose, String time) {
    return 'Your appointment ($purpose) is today at $time.';
  }

  @override
  String reminderAppointmentTomorrow(String purpose, String time) {
    return 'Your appointment ($purpose) is tomorrow at $time.';
  }

  @override
  String get reminderLogBloodPressure =>
      'Remember to record today\'s blood pressure.';

  @override
  String reminderMedication(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count doses still to take today.',
      one: '1 dose still to take today.',
    );
    return '$_temp0';
  }

  @override
  String reminderVaccineDue(String name) {
    return 'Your next vaccination may be due: $name. Check with your care team.';
  }

  @override
  String get remindersEmpty => 'No reminders right now.';

  @override
  String get remindersPushNote =>
      'Phone notifications use general wording, such as \"You have a new reminder\", so health details never show on your lock screen.';

  @override
  String get remindersTitle => 'Reminders';

  @override
  String get riskFactors => 'Risk factors';

  @override
  String get roleDoctor => 'Doctor / Admin';

  @override
  String get roleDoctorHint => 'Review your patients after verification';

  @override
  String get rolePatient => 'Patient';

  @override
  String get rolePatientHint => 'Track pregnancy, cycle and health';

  @override
  String get savedMessage => 'Saved';

  @override
  String get scanTypeDefault => 'Ultrasound';

  @override
  String get scanTypeHint => 'e.g. Growth scan';

  @override
  String get scanning => 'Scanning…';

  @override
  String get securityTitle => 'Sign-in & security';

  @override
  String get shareCycle => 'Period and cycle';

  @override
  String get shareDocuments => 'Medical documents';

  @override
  String get shareIntimacy => 'Sexual activity';

  @override
  String get shareNutrition => 'Food and calories';

  @override
  String get sharePregnancy => 'Pregnancy and scans';

  @override
  String get shareVitals => 'Health logs and vital signs';

  @override
  String get sharingTitle => 'Shared with my doctors';

  @override
  String get signOutConfirm => 'Sign out of this device?';

  @override
  String ssoContinueWith(String provider) {
    return 'Continue with $provider';
  }

  @override
  String ssoDemoBody(String provider) {
    return '$provider sign-in is not set up in this demo build. In the real app this opens the $provider sign-in page. Choose a demo account:';
  }

  @override
  String get ssoDemoNewPerson => 'New person (creates an account)';

  @override
  String ssoDemoTitle(String provider) {
    return 'Demo: $provider sign-in';
  }

  @override
  String get ssoNote =>
      'We only receive your name and email. Your health records stay in this app.';

  @override
  String get ssoOr => 'or';

  @override
  String get statAlerts => 'Alerts to review';

  @override
  String get statAverage => 'Average';

  @override
  String get statHighest => 'Highest';

  @override
  String get statLowest => 'Lowest';

  @override
  String get statNewRequests => 'New patient requests';

  @override
  String get statTodaysAppointments => 'Today\'s appointments';

  @override
  String get statTotalPatients => 'Patients';

  @override
  String get statusConnected => 'Connected';

  @override
  String get statusNotConnected => 'Not connected';

  @override
  String get symptomLogged => 'Symptom';

  @override
  String get symptomsEmpty => 'No symptoms recorded.';

  @override
  String get symptomsHistoryTitle => 'Recent symptoms';

  @override
  String get symptomsLogTitle => 'Log symptoms';

  @override
  String get symptomsTitle => 'Symptoms';

  @override
  String syncedReadings(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count readings synced',
      one: '1 reading synced',
      zero: 'No new readings',
    );
    return '$_temp0';
  }

  @override
  String get tabCycle => 'Menstrual cycle';

  @override
  String get tabGrowth => 'Growth';

  @override
  String get tabPregnancyTimeline => 'Pregnancy';

  @override
  String get tabSummary => 'Summary';

  @override
  String get tabTimeline => 'Timeline';

  @override
  String get tabVitals => 'Vitals';

  @override
  String get targetSetByClinician => 'Set by your care team';

  @override
  String get taskCountKicks => 'Count baby movements';

  @override
  String get taskDone => 'Done';

  @override
  String get taskDrinkWater => 'Drink water';

  @override
  String get taskNotDone => 'Not done';

  @override
  String taskTakeMedication(String name, String dose) {
    return 'Take $name $dose';
  }

  @override
  String get timelineDueDate => 'Due date';

  @override
  String get timelineStart => 'Pregnancy dated from';

  @override
  String timelineTrimesterStarts(String name) {
    return '$name begins';
  }

  @override
  String get today => 'Today';

  @override
  String get totpBody =>
      'Sign in with the 6-digit code from Google Authenticator, Microsoft Authenticator or a similar app. It works without SMS or internet.';

  @override
  String get totpCodeLabel => 'Authenticator code';

  @override
  String get totpEnable => 'Verify and turn on';

  @override
  String get totpKeyLabel => 'Setup key';

  @override
  String get totpNoApp =>
      'No authenticator app found. Install Google Authenticator, then try again or type the setup key.';

  @override
  String get totpOn =>
      'Authenticator app is on. When you sign in, enter the code it shows.';

  @override
  String get totpOpenApp => 'Open authenticator app';

  @override
  String get totpSetup => 'Set up authenticator app';

  @override
  String get totpStep1 =>
      '1. Tap \"Open authenticator app\", or scan this QR code with another phone, or type the setup key into the app.';

  @override
  String get totpStep2 => '2. Enter the 6-digit code the app shows.';

  @override
  String get totpTitle => 'Authenticator app';

  @override
  String get totpTurnOff => 'Turn off';

  @override
  String get trimesterFirst => 'First trimester';

  @override
  String get trimesterLabel => 'Trimester';

  @override
  String get trimesterSecond => 'Second trimester';

  @override
  String get trimesterThird => 'Third trimester';

  @override
  String get ultrasoundCopyHint =>
      'Copy the numbers from your scan report. Leave blank anything the report does not include.';

  @override
  String get ultrasoundNeedOneValue => 'Please enter at least one measurement.';

  @override
  String get unitBpm => 'bpm';

  @override
  String get unitHours => 'h';

  @override
  String get unitSteps => 'steps';

  @override
  String get unitWeeksShort => 'weeks';

  @override
  String get upcoming => 'Upcoming';

  @override
  String uploadedBy(String name) {
    return 'Added by $name';
  }

  @override
  String vaccinationPurpose(String name) {
    return 'Vaccination: $name';
  }

  @override
  String get vaccineAlreadyHad => 'I have already had it – record it';

  @override
  String get vaccineBook => 'Book vaccination appointment';

  @override
  String get vaccineBookHint => 'Tick the box above to book.';

  @override
  String get vaccineConfirmRead =>
      'I have read what this vaccine does and its price.';

  @override
  String get vaccineDemoPrice => 'Demo price, for illustration only.';

  @override
  String get vaccineDoctorConfirms =>
      'Your doctor will confirm at the appointment whether this vaccine is right for you.';

  @override
  String get vaccineDueNow => 'Due now';

  @override
  String get vaccineGiven => 'Given';

  @override
  String vaccineGivenOn(String date) {
    return 'Given on $date';
  }

  @override
  String get vaccineHistory => 'Vaccination history';

  @override
  String get vaccineHistoryEmpty => 'No vaccinations recorded.';

  @override
  String get vaccineNoDescription =>
      'Your clinic has not added a description yet.';

  @override
  String get vaccinePending => 'Pending';

  @override
  String vaccinePriceAt(String clinic) {
    return 'At $clinic';
  }

  @override
  String get vaccinePriceLabel => 'Price';

  @override
  String get vaccinePriceUnknown => 'Ask your clinic for the price.';

  @override
  String get vaccineTapForDetails => 'Details and price';

  @override
  String get vaccineWhatItDoes => 'What it does';

  @override
  String get vaccineWhen => 'When';

  @override
  String get vaccinesTitle => 'Vaccines';

  @override
  String get verificationStatus => 'Verification';

  @override
  String get verified => 'Verified';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get warningSignLogNow => 'I have this now — log it';

  @override
  String get warningSignsIntro =>
      'If you have any of these, get help now. Do not wait for your next appointment.';

  @override
  String get warningSignsTitle => 'Warning signs';

  @override
  String waterTodayMl(String amount) {
    return '$amount ml today';
  }

  @override
  String get welcomeCreateAccount => 'Create an account';

  @override
  String welcomeDemoHint(String code) {
    return 'Demo build: sign in as demo.patient@example.com (Gwen, pregnant), demo.cycle@example.com (Aina, cycle tracking) or demo.doctor@example.com, with code $code. Demo data resets when the app restarts.';
  }

  @override
  String get welcomeSignIn => 'I already have an account';

  @override
  String get welcomeTagline =>
      'Your pregnancy, cycle and women\'s health record, shared with your care team.';

  @override
  String get yourDoctors => 'Your doctors';
}
