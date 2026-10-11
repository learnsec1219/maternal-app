// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get aboutRegulatory =>
      'மருத்துவப் பணிமுறை வடிவமைப்புக்கான மேம்பாட்டுப் பதிப்பு. மருத்துவச் சாதனச் சட்டம் 2012 (சட்டம் 737)-இன் கீழ் பதிவுசெய்யப்பட்ட மருத்துவச் சாதனம் அல்ல.';

  @override
  String get accessLogExplainer =>
      'ஒவ்வொரு முறையும் நோயாளி பதிவைத் திறக்கும்போது அது பதிவு செய்யப்படும். நோயாளிகளும் நிர்வாகிகளும் இதைப் பார்க்கலாம்.';

  @override
  String get accessLogTitle => 'என் அணுகல் பதிவு';

  @override
  String accessLogViewed(String id) {
    return 'பதிவு $id பார்க்கப்பட்டது';
  }

  @override
  String get actionAccept => 'ஏற்கிறேன்';

  @override
  String get actionAdd => 'சேர்';

  @override
  String get actionBabyDelivered => 'குழந்தை பிறந்தது';

  @override
  String get actionBack => 'பின்செல்';

  @override
  String get actionCancel => 'ரத்துசெய்';

  @override
  String get actionConfirm => 'உறுதிசெய்';

  @override
  String get actionConnect => 'இணை';

  @override
  String get actionContinue => 'தொடர்';

  @override
  String get actionCopy => 'நகலெடு';

  @override
  String get actionDecline => 'மறு';

  @override
  String get actionDecrease => 'குறை';

  @override
  String get actionDisconnect => 'துண்டி';

  @override
  String get actionEndPostpartum => 'பொது பராமரிப்புக்கு மாறு';

  @override
  String get actionFinish => 'முடி';

  @override
  String get actionGoHome => 'முகப்புக்குச் செல்';

  @override
  String get actionImPregnant => 'நான் கர்ப்பமாக உள்ளேன்';

  @override
  String get actionIncrease => 'அதிகரி';

  @override
  String get actionNextDay => 'அடுத்த நாள்';

  @override
  String get actionNextMonth => 'அடுத்த மாதம்';

  @override
  String get actionNotNow => 'இப்போது வேண்டாம்';

  @override
  String get actionOk => 'சரி';

  @override
  String get actionPreviousDay => 'முந்தைய நாள்';

  @override
  String get actionPreviousMonth => 'முந்தைய மாதம்';

  @override
  String get actionRetry => 'மீண்டும் முயல்க';

  @override
  String get actionSave => 'சேமி';

  @override
  String get actionScan => 'சாதனங்களைத் தேடு';

  @override
  String get actionSendCode => 'குறியீட்டை அனுப்பு';

  @override
  String get actionSignOut => 'வெளியேறு';

  @override
  String get actionToday => 'இன்றைக்குத் திரும்பு';

  @override
  String get actionUnderstood => 'புரிந்தது';

  @override
  String get actionUndoLast => 'கடைசியை நீக்கு';

  @override
  String get actionVerify => 'சரிபார்';

  @override
  String get activityActive => 'மிகவும் சுறுசுறுப்பு';

  @override
  String get activityEmpty => 'உங்கள் சமீபத்திய பதிவுகள் இங்கே தோன்றும்.';

  @override
  String get activityLight => 'சிறிது சுறுசுறுப்பு';

  @override
  String get activityModerate => 'மிதமான சுறுசுறுப்பு';

  @override
  String get activitySedentary => 'பெரும்பாலும் அமர்ந்திருப்பேன்';

  @override
  String get addAppointmentTitle => 'சந்திப்பைச் சேர்';

  @override
  String get addDocumentTitle => 'ஆவணத்தைச் சேர்';

  @override
  String get addFoodTitle => 'உணவைச் சேர்';

  @override
  String get addHealthLogTitle => 'உடல்நலப் பதிவைச் சேர்';

  @override
  String get addMilestoneTitle => 'மைல்கல்லைச் சேர்';

  @override
  String get addNoteTitle => 'குறிப்பைச் சேர்';

  @override
  String get addUltrasoundTitle => 'ஸ்கேன் முடிவுகளைச் சேர்';

  @override
  String ageYears(int age) {
    return '$age வயது';
  }

  @override
  String alertCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count எச்சரிக்கைகள்',
      one: '1 எச்சரிக்கை',
    );
    return '$_temp0';
  }

  @override
  String alertWarningSign(String name) {
    return 'எச்சரிக்கை அறிகுறி: $name';
  }

  @override
  String alertsExplainer(int days) {
    return 'கடந்த $days நாட்களில் அமைக்கப்பட்ட வரம்புகளுக்கு வெளியே உள்ள அளவீடுகளும் பதிவான எச்சரிக்கை அறிகுறிகளும்.';
  }

  @override
  String get alertsNone => 'இப்போது மதிப்பாய்வு செய்ய எதுவும் இல்லை.';

  @override
  String get alertsToReview => 'மதிப்பாய்வுக்கான எச்சரிக்கைகள்';

  @override
  String get answerNo => 'இல்லை';

  @override
  String get answerYes => 'ஆம்';

  @override
  String get appName => 'Maternal Care';

  @override
  String get appearanceDark => 'இருண்ட';

  @override
  String get appearanceExplainer =>
      'வெளிர் முறை இயல்பானது. இரவில் பயன்படுத்த இருண்ட முறையைத் தேர்வுசெய்யவும், அல்லது தொலைபேசி அமைப்பைப் பின்பற்றவும்.';

  @override
  String get appearanceLight => 'வெளிர்';

  @override
  String get appearanceSystem => 'தொலைபேசியைப் போல';

  @override
  String get appointmentDefaultPurpose => 'சந்திப்பு';

  @override
  String get appointmentsNoneToday => 'இன்று சந்திப்புகள் இல்லை.';

  @override
  String get appointmentsNoneUpcoming => 'வரவிருக்கும் சந்திப்புகள் இல்லை.';

  @override
  String get appointmentsTitle => 'சந்திப்புகள்';

  @override
  String get assistantBadKey =>
      'AI சேவை Gemini API சாவியை ஏற்கவில்லை. சுயவிவரம் > இணைப்புகள் பகுதியில் சாவியைச் சரிபார்க்கவும்.';

  @override
  String get assistantBlocked =>
      'AI சேவை இந்தக் கேள்விக்குப் பதிலளிக்கவில்லை. வேறு விதமாகக் கேட்டுப் பாருங்கள்.';

  @override
  String get assistantEducational => 'கல்வித் தகவல்';

  @override
  String get assistantFailed => 'பதிலை ஏற்ற முடியவில்லை. மீண்டும் முயலவும்.';

  @override
  String get assistantHomeHint =>
      'AI ஆங்கிலம், BM, 中文 அல்லது தமிழில் பதில் தரும். கல்வித் தகவல் மட்டுமே, நோயறிதல் அல்ல.';

  @override
  String get assistantInputHint => 'உங்கள் கேள்வியைத் தட்டச்சு செய்யவும்';

  @override
  String get assistantLanguage => 'பதில் மொழி';

  @override
  String get assistantNetwork =>
      'AI சேவையை அணுக முடியவில்லை. உங்கள் இணைய இணைப்பைச் சரிபார்த்து மீண்டும் முயலவும்.';

  @override
  String get assistantNewChat => 'புதிய உரையாடல்';

  @override
  String get assistantNotConfigured =>
      'AI உதவியாளர் பதிலளிக்க Gemini API சாவி தேவை. சுயவிவரம் > இணைப்புகள் பகுதியில் சேர்க்கவும், அல்லது செயலி நிர்வாகியிடம் அதைச் செயலியில் சேர்க்கச் சொல்லவும்.';

  @override
  String get assistantSend => 'அனுப்பு';

  @override
  String get assistantThinking => 'யோசிக்கிறது...';

  @override
  String get assistantTitle => 'கேள்வி கேளுங்கள்';

  @override
  String get assistantUseDetails => 'என் கர்ப்ப விவரங்களைப் பயன்படுத்து';

  @override
  String get assistantUseDetailsHelp =>
      'முடக்கம்: உங்கள் பதிவுகளிலிருந்து எதுவும் அனுப்பப்படாது. இயக்கம்: உங்கள் நிலை (எ.கா. 32 வாரங்கள்) மட்டுமே பகிரப்படும், உங்கள் பெயர் ஒருபோதும் இல்லை.';

  @override
  String atGestation(String ga) {
    return '$ga-இல்';
  }

  @override
  String get authAuthenticatorHelp =>
      'உங்கள் அங்கீகரிப்புச் செயலி Maternal க்குக் காட்டும் 6 இலக்கக் குறியீட்டை உள்ளிடவும்.';

  @override
  String get authEmailNotSetUp =>
      'உண்மையான மின்னஞ்சல் குறியீடுகள் இன்னும் அமைக்கப்படவில்லை (இணைப்புகள்).';

  @override
  String get authInvalidCode =>
      'அந்தக் குறியீடு சரியில்லை. சரிபார்த்து மீண்டும் முயலவும்.';

  @override
  String get authInvalidIdentifier => 'சரியான மின்னஞ்சல் முகவரியை உள்ளிடவும்.';

  @override
  String get authNoAccountYet =>
      'சரிபார்க்கப்பட்டது. இன்னும் கணக்கு இல்லை, ஒன்றை உருவாக்குவோம்.';

  @override
  String get authSendCodeInstead => 'பதிலாக மின்னஞ்சலில் குறியீட்டை அனுப்பு';

  @override
  String authSendFailed(String reason) {
    return 'குறியீட்டை அனுப்பவோ சரிபார்க்கவோ முடியவில்லை. $reason';
  }

  @override
  String get babiesMore => 'மேலும்';

  @override
  String get babiesSingle => 'ஒன்று';

  @override
  String get babiesTriplets => 'மூவர்';

  @override
  String get babiesTwins => 'இரட்டையர்';

  @override
  String get babyParameters => 'குழந்தையின் அளவீடுகள்';

  @override
  String bluetoothBattery(int level) {
    return 'பேட்டரி $level%';
  }

  @override
  String get bluetoothConnectFailed =>
      'இணைக்க முடியவில்லை. கடிகாரத்தைத் தொலைபேசிக்கு அருகில் வைத்து மீண்டும் முயலவும்.';

  @override
  String get bluetoothDenied =>
      'Bluetooth அனுமதி வழங்கப்படவில்லை. உங்கள் தொலைபேசியின் அமைப்புகள் > செயலிகள் பகுதியில் Maternal க்கு \"அருகிலுள்ள சாதனங்கள்\" அனுமதியை வழங்கி மீண்டும் முயலவும்.';

  @override
  String get bluetoothFindWatch =>
      'Bluetooth ஐ இயக்கி என் கடிகாரத்தைக் கண்டுபிடி';

  @override
  String get bluetoothHasHeartRate => 'இதயத் துடிப்பைப் பகிர்கிறது';

  @override
  String bluetoothHeartRate(int bpm) {
    return 'நிமிடத்திற்கு $bpm துடிப்புகள்';
  }

  @override
  String get bluetoothLost => 'கடிகாரம் துண்டிக்கப்பட்டது.';

  @override
  String get bluetoothNoHeartRate =>
      'இந்தச் சாதனம் Bluetooth மூலம் இதயத் துடிப்பைப் பகிரவில்லை. பல கடிகாரங்களில் அமைப்புகளில் \"Broadcast heart rate\" (HR broadcast) ஐ இயக்கலாம்.';

  @override
  String get bluetoothNoneFound => 'இன்னும் சாதனங்கள் எதுவும் இல்லை.';

  @override
  String get bluetoothOff =>
      'Bluetooth அணைக்கப்பட்டுள்ளது. அதை இயக்கி மீண்டும் முயலவும்.';

  @override
  String bluetoothReconnect(String name) {
    return '$name ஐ மீண்டும் இணை';
  }

  @override
  String get bluetoothScanHelp =>
      'கடிகாரத்தை விழிப்பு நிலையில் தொலைபேசிக்கு அருகில் வைத்திருங்கள். இதயத் துடிப்பைப் பகிரும் சாதனங்கள் முதலில் காட்டப்படும்.';

  @override
  String get bluetoothTitle => 'Bluetooth சாதனங்கள்';

  @override
  String get bluetoothUnsupported =>
      'இந்தத் தொலைபேசி Bluetooth Low Energy ஐ ஆதரிக்கவில்லை.';

  @override
  String get bluetoothWaitingForReading => 'அளவீட்டுக்காகக் காத்திருக்கிறது…';

  @override
  String get bluetoothWatchBody =>
      'Bluetooth மூலம் கடிகாரம் அல்லது உடற்பயிற்சிப் பட்டையை இணைக்கவும். இதயத் துடிப்பு அளவீடுகள் நேரடியாக உங்கள் உடல்நலப் பதிவில் ஒத்திசைக்கப்படும்.';

  @override
  String callDoctor(String name) {
    return '$name-ஐ அழை';
  }

  @override
  String callEmergency(String number) {
    return '$number அழை';
  }

  @override
  String callManually(String number) {
    return 'டயலரைத் திறக்க முடியவில்லை. $number எண்ணை அழைக்கவும்.';
  }

  @override
  String calorieAnalysis(int days, String average, String percent) {
    return 'நீங்கள் பதிவு செய்த $days நாட்களில் சராசரியாக $average kcal உண்டீர்கள்; இது உங்கள் இலக்கின் சுமார் $percent%. உங்களுக்கு எது சரி என உங்கள் மருத்துவக் குழுவிடம் கேளுங்கள்.';
  }

  @override
  String calorieAnalysisNoTarget(int days, String average) {
    return 'நீங்கள் பதிவு செய்த $days நாட்களில் சராசரியாக $average kcal உண்டீர்கள்.';
  }

  @override
  String get calorieAnalysisTooFew =>
      'சுருக்கத்தைக் காண குறைந்தது மூன்று நாட்கள் பதிவு செய்யவும்.';

  @override
  String calorieChartSummary(int range, int logged) {
    return 'கடந்த $range நாட்களுக்கான தினசரி கலோரி; $logged நாட்கள் பதிவு செய்யப்பட்டன.';
  }

  @override
  String get calorieHistory => 'வரலாறு';

  @override
  String get calorieNoData =>
      'இந்தக் காலத்தில் உணவு பதிவு இல்லை. உணவைப் பதிவு செய்யத் தொடங்குங்கள் அல்லது கடிகாரத்தை இணைக்கவும்.';

  @override
  String get calorieNoTargetBody =>
      'மதிப்பிடப்பட்ட தினசரி இலக்கைக் காண பிறந்த தேதி, உயரம், எடையைச் சேர்க்கவும்.';

  @override
  String get calorieNoTargetTitle => 'இன்னும் இலக்கு இல்லை';

  @override
  String get calorieTarget => 'தினசரி இலக்கு';

  @override
  String get careTeamEmpty => 'இன்னும் மருத்துவர்கள் இணைக்கப்படவில்லை.';

  @override
  String get careTeamIntro =>
      'இங்குள்ள மருத்துவர்கள் நீங்கள் பகிரும் பதிவுகளைப் பார்க்கலாம். எப்போது வேண்டுமானாலும் அனுமதியை நீக்கலாம்.';

  @override
  String get chartBandNote =>
      'நிழலிட்ட பட்டை உங்கள் மருத்துவக் குழுவின் அமைப்புகளில் உள்ள வழக்கமான வரம்பு.';

  @override
  String chartSummary(String name, int count, String latest) {
    return '$name வரைபடம்: $count அளவீடுகள், சமீபத்தியது $latest.';
  }

  @override
  String get chartTargetLineNote => 'புள்ளிக்கோடு உங்கள் தினசரி இலக்கு.';

  @override
  String get clinicalSummary => 'மருத்துவச் சுருக்கம்';

  @override
  String get colGestation => 'கர்ப்பக் காலம்';

  @override
  String get colScan => 'ஸ்கேன்';

  @override
  String get connectionsAiBody =>
      'aistudio.google.com > Get API key இல் இலவசச் சாவியை உருவாக்கவும். மாதிரியை gemini-flash-latest ஆகவே விடலாம்.';

  @override
  String get connectionsAiTitle => 'AI உதவியாளர் (Google Gemini)';

  @override
  String get connectionsBuiltIn => 'இந்தச் செயலியில் உள்ளமைந்தது';

  @override
  String get connectionsEmailBody =>
      'EmailJS இல் ஒரு Gmail சேவையைச் சேர்த்து, \"To\" இல் to_email உம் செய்தியில் passcode உம் உள்ள மின்னஞ்சல் வார்ப்புருவை உருவாக்கவும். Account > Security இல் \"Allow EmailJS API for non-browser applications\" ஐ இயக்கி, தனிப்பட்ட சாவியையும் நகலெடுக்கவும்.';

  @override
  String get connectionsEmailTitle =>
      'மின்னஞ்சல் குறியீடுகள் (EmailJS + Gmail)';

  @override
  String get connectionsGoogleBody =>
      'Google Cloud இலிருந்து Web client ID. உள்நுழைவுக்கு இந்தச் செயலியின் package பெயர் மற்றும் SHA-1 உடன் ஒரு Android client உம் அங்கே தேவை.';

  @override
  String get connectionsGoogleTitle => 'Google உள்நுழைவு';

  @override
  String get connectionsIntro =>
      'AI உதவியாளர், மின்னஞ்சல் குறியீடுகள் மற்றும் Google உள்நுழைவுக்கான சாவிகள். இங்கே தட்டச்சு செய்யும் சாவிகள் இந்தத் தொலைபேசியில் மட்டுமே இருக்கும்; செயலியில் உள்ளவற்றுக்குப் பதிலாகப் பயன்படும். உள்ளமைந்த சாவியைப் பயன்படுத்தப் பெட்டியைக் காலியாக விடவும்.';

  @override
  String get connectionsMissing => 'அமைக்கப்படவில்லை';

  @override
  String get connectionsSetHere => 'இந்தத் தொலைபேசியில் அமைக்கப்பட்டது';

  @override
  String get connectionsTitle => 'இணைப்புகள்';

  @override
  String get contentPendingReview =>
      'இந்த அட்டவணை மலேசிய வழிகாட்டுதல்களின்படி தகுதியுள்ள மருத்துவரின் மதிப்பாய்வுக்குக் காத்திருக்கும் டெமோ உள்ளடக்கம். எப்போதும் உங்கள் மருத்துவக் குழுவைப் பின்பற்றுங்கள்.';

  @override
  String contentVersion(String version) {
    return 'மருத்துவ உள்ளடக்கப் பதிப்பு $version';
  }

  @override
  String get contractionAvgDuration => 'சராசரி நீளம்';

  @override
  String get contractionAvgInterval => 'சராசரி இடைவெளி';

  @override
  String contractionDuration(String duration) {
    return '$duration நீடித்தது';
  }

  @override
  String get contractionEmpty =>
      'நீங்கள் அளக்கும் சுருக்கங்கள் இங்கே தோன்றும்.';

  @override
  String contractionGap(String gap) {
    return 'முந்தையதற்குப் பின் $gap';
  }

  @override
  String get contractionHistory => 'வரலாறு';

  @override
  String contractionLastHour(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'கடந்த ஒரு மணிநேரத்தில் $count சுருக்கங்கள்',
      one: 'கடந்த ஒரு மணிநேரத்தில் 1 சுருக்கம்',
      zero: 'கடந்த ஒரு மணிநேரத்தில் சுருக்கங்கள் இல்லை',
    );
    return '$_temp0';
  }

  @override
  String get contractionStart => 'சுருக்கம் தொடங்கியது';

  @override
  String get contractionStop => 'சுருக்கம் முடிந்தது';

  @override
  String get contractionTapToStop => 'முடியும்போது தட்டவும்';

  @override
  String get contractionTitle => 'சுருக்க நேரமானி';

  @override
  String get contractionTooShort =>
      'சில வினாடிகள் மட்டுமே இருந்ததால் சேமிக்கப்படவில்லை.';

  @override
  String get copied => 'நகலெடுக்கப்பட்டது';

  @override
  String get createAppointment => 'சந்திப்பு';

  @override
  String get createAskAi => 'AI-யிடம் கேள்';

  @override
  String get createContractions => 'சுருக்கங்கள்';

  @override
  String get createDocument => 'ஆவணம்';

  @override
  String get createFood => 'உணவு';

  @override
  String get createGroupCare => 'பராமரிப்பு';

  @override
  String get createGroupHealth => 'உடல்நலம்';

  @override
  String get createGroupNutrition => 'ஊட்டச்சத்து';

  @override
  String get createGroupPregnancy => 'கர்ப்பம்';

  @override
  String get createHealthLog => 'உடல்நலப் பதிவு';

  @override
  String get createKickCounter => 'உதை எண்ணி';

  @override
  String get createMedication => 'மருந்து';

  @override
  String get createMilestone => 'மைல்கல்';

  @override
  String get createPeriod => 'மாதவிடாய்';

  @override
  String get createSymptoms => 'அறிகுறிகள்';

  @override
  String get createTitle => 'எதைச் சேர்க்க விரும்புகிறீர்கள்?';

  @override
  String get createUltrasound => 'ஸ்கேன் முடிவுகள்';

  @override
  String get createVaccine => 'தடுப்பூசி';

  @override
  String get createWater => 'தண்ணீர்';

  @override
  String cycleAverageLength(int days) {
    return 'சுழற்சி சுமார் $days நாட்கள்';
  }

  @override
  String cycleBasedOnRecords(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'நீங்கள் பதிவு செய்த $count மாதவிடாய்களை அடிப்படையாகக் கொண்டது. ஒவ்வொரு புதிய பதிவும் அடுத்த மாதங்களைப் புதுப்பிக்கும்.',
    );
    return '$_temp0';
  }

  @override
  String get cycleBasedOnTypical => 'வழக்கமான சுழற்சியை அடிப்படையாகக் கொண்டது';

  @override
  String cycleDaysLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'எதிர்பார்த்ததைவிட $days நாட்கள் தாமதம்',
      one: 'எதிர்பார்த்ததைவிட 1 நாள் தாமதம்',
    );
    return '$_temp0';
  }

  @override
  String cycleFertileWindow(String start, String end) {
    return 'மதிப்பிடப்பட்ட கருவுறும் காலம்: $start – $end';
  }

  @override
  String cycleInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days நாட்களில்',
      one: '1 நாளில்',
      zero: 'இன்று எதிர்பார்க்கப்படுகிறது',
    );
    return '$_temp0';
  }

  @override
  String get cycleIrregularWarning =>
      'உங்கள் சுழற்சிகள் அதிகம் மாறுபட்டுள்ளதால் இந்த மதிப்பீடுகள் குறைவான துல்லியமாக இருக்கலாம்.';

  @override
  String get cycleLogToday => 'மாதவிடாயைப் பதிவு செய்';

  @override
  String get cycleNeedSecondPeriod =>
      'வழக்கமான 28 நாள் சுழற்சியை அடிப்படையாகக் கொண்டது. உங்கள் அடுத்த மாதவிடாயைப் பதிவு செய்தால், கணிப்புகள் உங்கள் சொந்தச் சுழற்சியைப் பின்பற்றும்.';

  @override
  String get cycleNextPeriod => 'அடுத்த மாதவிடாய்';

  @override
  String get cycleNoData =>
      'உங்கள் மாதவிடாய் நாட்களைப் பதிவு செய்யவும். இரண்டு மாதவிடாய்களுக்குப் பின் அடுத்ததை மதிப்பிடலாம்.';

  @override
  String get cycleNoEstimate =>
      'மதிப்பீட்டைக் காண உங்கள் மாதவிடாயைப் பதிவு செய்யவும்.';

  @override
  String cycleOvulation(String date) {
    return 'மதிப்பிடப்பட்ட கருமுட்டை வெளியீடு: $date';
  }

  @override
  String get cyclePausedInPregnancy =>
      'கர்ப்ப காலத்தில் சுழற்சி கணிப்புகள் நிறுத்தப்படும். உங்கள் மாதவிடாய் வரலாறு வைக்கப்படும்.';

  @override
  String cyclePeriodLength(int days) {
    return 'மாதவிடாய் சுமார் $days நாட்கள்';
  }

  @override
  String cycleShiftEarlier(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'உங்கள் கடைசி மாதவிடாய் கணிப்பை விட $days நாட்கள் முன்னதாகத் தொடங்கியது, எனவே அடுத்த தேதிகள் மாற்றப்பட்டன.',
      one: 'உங்கள் கடைசி மாதவிடாய் கணிப்பை விட 1 நாள் முன்னதாகத் தொடங்கியது, எனவே அடுத்த தேதிகள் மாற்றப்பட்டன.',
    );
    return '$_temp0';
  }

  @override
  String cycleShiftLater(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'உங்கள் கடைசி மாதவிடாய் கணிப்பை விட $days நாட்கள் தாமதமாகத் தொடங்கியது, எனவே அடுத்த தேதிகள் மாற்றப்பட்டன.',
      one: 'உங்கள் கடைசி மாதவிடாய் கணிப்பை விட 1 நாள் தாமதமாகத் தொடங்கியது, எனவே அடுத்த தேதிகள் மாற்றப்பட்டன.',
    );
    return '$_temp0';
  }

  @override
  String get cycleStale =>
      'எதிர்பார்த்த மாதவிடாய் ஒரு சுழற்சிக்கு மேல் தாமதமாகியுள்ளது. மதிப்பீடுகளைப் புதுப்பிக்க சமீபத்திய மாதவிடாயைப் பதிவு செய்யவும்.';

  @override
  String get cycleUpcomingTitle => 'அடுத்தடுத்த மாதவிடாய்கள் (மதிப்பீடு)';

  @override
  String get dayAppointments => 'சந்திப்புகள்';

  @override
  String get dayHealthLogs => 'உடல்நலப் பதிவுகள்';

  @override
  String get dayNotes => 'குறிப்புகள்';

  @override
  String get dayPeriod => 'மாதவிடாய்';

  @override
  String get daySymptoms => 'அறிகுறிகள்';

  @override
  String daysPastDue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'பிரசவ தேதியைத் தாண்டி $days நாட்கள்',
      one: 'பிரசவ தேதியைத் தாண்டி 1 நாள்',
    );
    return '$_temp0';
  }

  @override
  String daysToGo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'இன்னும் $days நாட்கள்',
      one: 'இன்னும் 1 நாள்',
      zero: 'இன்று பிரசவ தேதி',
    );
    return '$_temp0';
  }

  @override
  String deliveredConfirmBody(String date) {
    return 'இந்தக் கர்ப்பத்தை $date அன்று முடித்து, பிரசவத்திற்குப் பிந்தைய பராமரிப்பைத் தொடங்குவோம். உங்கள் கர்ப்பப் பதிவுகள் வரலாற்றில் இருக்கும்.';
  }

  @override
  String get deliveredConfirmTitle => 'வாழ்த்துகள்!';

  @override
  String deliveredOn(String date) {
    return '$date அன்று பிரசவம்';
  }

  @override
  String get deliveredSaved => 'பிரசவத்திற்குப் பிந்தைய பராமரிப்பு தொடங்கியது.';

  @override
  String get demoModeBody =>
      'நீங்கள் தெளிவாகக் குறிக்கப்பட்ட டெமோ தரவைப் பார்க்கிறீர்கள். எதுவும் சர்வருக்கு அனுப்பப்படாது; செயலியை மீண்டும் தொடங்கும்போது பதிவுகள் மீட்டமைக்கப்படும்.';

  @override
  String get demoModeTitle => 'டெமோ முறை';

  @override
  String get demoUseCyclePatient => 'Aina (சுழற்சி)';

  @override
  String get demoUseDoctor => 'Dr. Chua (மருத்துவர்)';

  @override
  String get demoUsePatient => 'Gwen (கர்ப்பிணி)';

  @override
  String get devicesTitle => 'இணைக்கப்பட்ட சாதனங்கள்';

  @override
  String get disclaimer =>
      'இந்தச் செயலி உங்கள் மருத்துவரின் பராமரிப்புக்கு உதவுகிறது, ஆனால் அதற்கு மாற்றாகாது. இது நோயறிதல் செய்யாது. மருத்துவ உள்ளடக்கம் தகுதியுள்ள மருத்துவரின் மதிப்பாய்வுக்குக் காத்திருக்கிறது.';

  @override
  String get docBloodTest => 'இரத்தப் பரிசோதனை';

  @override
  String get docHospital => 'மருத்துவமனை ஆவணம்';

  @override
  String get docOther => 'மற்றவை';

  @override
  String get docPrescription => 'மருந்துச்சீட்டு';

  @override
  String get docUltrasound => 'அல்ட்ராசவுண்ட்';

  @override
  String get docVaccination => 'தடுப்பூசி பதிவு';

  @override
  String doctorGreeting(String name) {
    return 'வணக்கம், $name';
  }

  @override
  String get doctorNavDashboard => 'டாஷ்போர்டு';

  @override
  String get doctorNavPatients => 'நோயாளிகள்';

  @override
  String get doctorPendingBody =>
      'நிர்வாகி உங்கள் MMC பதிவைச் சரிபார்க்கிறார். ஒப்புதல் கிடைத்ததும் இணைந்த நோயாளிகளைப் பார்க்கலாம்.';

  @override
  String get doctorPendingTitle => 'சரிபார்ப்புக்குக் காத்திருக்கிறது';

  @override
  String get documentSearchEmpty => 'பொருந்தும் ஆவணங்கள் இல்லை.';

  @override
  String get documentSearchHint => 'ஆவணங்களில் தலைப்புகளையும் உரையையும் தேடு';

  @override
  String get documentStorageNote =>
      'இந்த டெமோவில் கோப்பு உங்கள் தொலைபேசியிலேயே இருக்கும். முழுச் செயலியில் அது மறையாக்கம் செய்யப்பட்டுத் தனிப்பட்ட முறையில் சேமிக்கப்படும்; உங்களுடன் இணைந்த மருத்துவர்கள் மட்டுமே திறக்க முடியும்.';

  @override
  String get documentsEmpty => 'இன்னும் ஆவணங்கள் இல்லை.';

  @override
  String get documentsTitle => 'மருத்துவ ஆவணங்கள்';

  @override
  String dueDateGaPreview(String ga) {
    return 'அதாவது இன்று நீங்கள் $ga.';
  }

  @override
  String get dueDateHelper =>
      'உங்கள் மருத்துவர் அல்லது ஸ்கேன் அறிக்கையிலிருந்து.';

  @override
  String dueDateInvalidBody(String date) {
    return 'சேமித்த பிரசவ தேதி ($date) நடப்புக் கர்ப்பத்துடன் பொருந்தவில்லை; எனவே வாரங்களையோ கவுண்ட்டவுனையோ காட்டவில்லை.';
  }

  @override
  String get dueDateInvalidTitle => 'உங்கள் பிரசவ தேதியைச் சரிபார்க்கவும்';

  @override
  String get dueDateTooFarFuture =>
      'இந்தத் தேதி 40 வாரங்களுக்கு மேல் தொலைவில் உள்ளது. சரிபார்க்கவும்.';

  @override
  String get dueDateTooFarPast =>
      'நடப்புக் கர்ப்பத்திற்கு இந்தத் தேதி மிகவும் பழையது. சரிபார்க்கவும்.';

  @override
  String dueOn(String date) {
    return 'பிரசவம் $date';
  }

  @override
  String emergencyNumberNote(String number) {
    return 'மலேசியாவில் அவசர நிலையில் $number அழைக்கவும்.';
  }

  @override
  String get errorEnterNumber => 'ஒரு எண்ணை உள்ளிடவும்.';

  @override
  String errorOutOfRange(String min, String max) {
    return '$min முதல் $max வரையிலான மதிப்பை உள்ளிடவும்.';
  }

  @override
  String get errorRequired => 'இதை நிரப்பவும்.';

  @override
  String get estimateLabel => 'மதிப்பீடு';

  @override
  String get fetalAc => 'வயிற்றுச் சுற்றளவு';

  @override
  String get fetalAfi => 'பனிக்குட நீர் அளவு (AFI)';

  @override
  String get fetalBpd => 'தலை அகலம் (BPD)';

  @override
  String get fetalCrl => 'தலை-இடுப்பு நீளம் (CRL)';

  @override
  String get fetalEfw => 'மதிப்பிடப்பட்ட எடை';

  @override
  String get fetalFhr => 'சிசு இதயத் துடிப்பு';

  @override
  String get fetalFl => 'தொடை எலும்பு நீளம்';

  @override
  String get fetalHc => 'தலைச் சுற்றளவு';

  @override
  String get fetalNt => 'கழுத்துப் பின் தடிமன் (NT)';

  @override
  String get fieldActivityLevel => 'செயல்பாட்டு நிலை';

  @override
  String get fieldAllergies => 'ஒவ்வாமைகள்';

  @override
  String get fieldBloodGroup => 'இரத்த வகை';

  @override
  String get fieldCalories => 'கலோரி';

  @override
  String get fieldCategory => 'வகை';

  @override
  String get fieldClinic => 'கிளினிக் அல்லது மருத்துவமனை';

  @override
  String get fieldClinicHospital => 'கிளினிக் அல்லது மருத்துவமனை';

  @override
  String get fieldDate => 'தேதி';

  @override
  String get fieldDateOfBirth => 'பிறந்த தேதி';

  @override
  String get fieldDescription => 'விளக்கம்';

  @override
  String get fieldDiastolic => 'டயஸ்டாலிக் (கீழ்)';

  @override
  String get fieldDoctor => 'மருத்துவர்';

  @override
  String get fieldDocumentDate => 'ஆவணத்தில் உள்ள தேதி';

  @override
  String get fieldDueDate => 'எதிர்பார்க்கப்படும் பிரசவ தேதி';

  @override
  String get fieldEmail => 'மின்னஞ்சல்';

  @override
  String get fieldFlow => 'இரத்தப்போக்கு';

  @override
  String get fieldFoodName => 'உணவு அல்லது பானம்';

  @override
  String get fieldFullName => 'முழுப் பெயர்';

  @override
  String get fieldGlucoseContext => 'எப்போது அளக்கப்பட்டது?';

  @override
  String get fieldHeight => 'உயரம்';

  @override
  String get fieldMeal => 'உணவு நேரம்';

  @override
  String get fieldMeasurement => 'எதைப் பதிவு செய்கிறீர்கள்?';

  @override
  String get fieldMedicalHistory => 'மருத்துவ வரலாறு';

  @override
  String get fieldMilestone => 'மைல்கல்';

  @override
  String get fieldMmcHelper =>
      'நோயாளி தரவைப் பார்க்கும் முன் நிர்வாகி சரிபார்ப்பார்.';

  @override
  String get fieldMmcNumber => 'MMC பதிவு எண்';

  @override
  String get fieldNote => 'குறிப்பு';

  @override
  String get fieldNotesOptional => 'குறிப்புகள் (விருப்பம்)';

  @override
  String get fieldNumberOfBabies => 'குழந்தைகளின் எண்ணிக்கை';

  @override
  String get fieldOtp => 'ஒருமுறை குறியீடு';

  @override
  String get fieldPhone => 'தொலைபேசி எண்';

  @override
  String get fieldPortion => 'அளவு';

  @override
  String get fieldPrePregnancyWeight => 'கர்ப்பத்திற்கு முந்தைய எடை';

  @override
  String get fieldPreferredLanguage => 'விருப்பமான மொழி';

  @override
  String get fieldPurpose => 'நோக்கம்';

  @override
  String get fieldScanType => 'ஸ்கேன் வகை';

  @override
  String get fieldSeverity => 'எவ்வளவு தீவிரம்?';

  @override
  String get fieldSystolic => 'சிஸ்டாலிக் (மேல்)';

  @override
  String get fieldTime => 'நேரம்';

  @override
  String get fieldTitle => 'தலைப்பு';

  @override
  String get filterPending => 'கோரிக்கை';

  @override
  String get flowHeavy => 'அதிகம்';

  @override
  String get flowLight => 'குறைவு';

  @override
  String get flowMedium => 'மிதம்';

  @override
  String get flowNone => 'இல்லை';

  @override
  String get flowSpotting => 'புள்ளிகள்';

  @override
  String gaWeeksDays(int weeks, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks வாரங்கள்',
      one: '1 வாரம்',
    );
    String _temp1 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days நாட்கள்',
      one: '1 நாள்',
      zero: '0 நாள்',
    );
    return '$_temp0 $_temp1';
  }

  @override
  String get glucoseAfterMeal => 'உணவுக்குப் பின்';

  @override
  String get glucoseFasting => 'உண்ணாநிலை';

  @override
  String get glucoseRandom => 'வேறு நேரம்';

  @override
  String get googleConsentAllow => 'அனுமதித்து தொடர்';

  @override
  String get googleConsentBody =>
      'Maternal இவற்றை உங்கள் Google கணக்கிலிருந்து உங்கள் சுயவிவரத்தில் நகலெடுக்கும். பின்னர் தனிப்பட்ட தகவலில் மாற்றலாம்.';

  @override
  String get googleConsentManual => 'என் விவரங்களை நானே உள்ளிடுகிறேன்';

  @override
  String get googleConsentTitle => 'உங்கள் Google விவரங்களைப் பயன்படுத்தவா?';

  @override
  String get googleContinue => 'Google மூலம் தொடர்';

  @override
  String googleFailed(String detail) {
    return 'Google உள்நுழைவு தோல்வியடைந்தது: $detail';
  }

  @override
  String get googleNotSetUp =>
      'இந்தப் பதிப்பில் Google உள்நுழைவு இன்னும் அமைக்கப்படவில்லை. உங்கள் மின்னஞ்சலைப் பயன்படுத்தவும்.';

  @override
  String get googlePhoto => 'சுயவிவரப் படம்';

  @override
  String get googlePhotoValue => 'உங்கள் Google படம்';

  @override
  String get gravidaPara => 'கர்ப்ப / பிரசவ எண்ணிக்கை';

  @override
  String get growthCompareScans => 'ஸ்கேன்களை ஒப்பிடு';

  @override
  String get growthNoScans => 'இன்னும் ஸ்கேன் பதிவுகள் இல்லை.';

  @override
  String get healthConnectBody =>
      'உங்கள் தொலைபேசி அல்லது கடிகாரம் ஏற்கனவே பதிவு செய்யும் அடிகள், இதயத் துடிப்பு, தூக்கம் போன்ற தரவைக் கொண்டுவாருங்கள்.';

  @override
  String get healthConnectDemoNote =>
      'கீழே உள்ள Health Connect இந்தப் பதிப்பில் இன்னும் டெமோ அளவீடுகளைப் பயன்படுத்துகிறது. மேலே உள்ள Bluetooth உண்மையானது.';

  @override
  String get healthConnectRationale =>
      'நீங்கள் அனுமதிக்கும் தரவு வகைகளை மட்டும், நீங்கள் ஒப்புக்கொண்ட பின் மட்டுமே படிக்கிறோம். எப்போது வேண்டுமானாலும் துண்டிக்கலாம்.';

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String homeGreeting(String name) {
    return 'வணக்கம், $name';
  }

  @override
  String get homeNextAppointment => 'வரவிருக்கும் சந்திப்பு';

  @override
  String get homeRecentActivity => 'சமீபத்திய உடல்நலச் செயல்பாடு';

  @override
  String get homeTabBaby => 'குழந்தை';

  @override
  String get homeTabMother => 'தாய்';

  @override
  String get homeTodaysHealth => 'இன்றைய உடல்நலம்';

  @override
  String get homeTodaysTasks => 'இன்றைய பணிகள்';

  @override
  String get intimacyPrivateNote =>
      'தனிப்பட்டது: தனியுரிமையில் பகிரத் தேர்வுசெய்யும் வரை நீங்கள் மட்டுமே பார்க்கலாம்.';

  @override
  String get journeyGeneral => 'பெண்கள் நலம்';

  @override
  String get journeyPostpartum => 'பிரசவத்திற்குப் பின்';

  @override
  String get journeyPregnancy => 'கர்ப்பிணி';

  @override
  String get kcalBurntNotConnected =>
      'எரித்த கலோரி: கடிகாரம் அல்லது Health Connect-ஐ இணைக்கவும்';

  @override
  String get kcalConsumed => 'உண்டது';

  @override
  String kcalOver(String kcal) {
    return 'இலக்கை விட $kcal kcal அதிகம்';
  }

  @override
  String kcalRemaining(String kcal) {
    return '$kcal kcal மீதம்';
  }

  @override
  String get kickCounterTitle => 'உதை எண்ணி';

  @override
  String get kickGuarded => 'கடைசித் தட்டலின் அதே அசைவாகக் கணக்கிடப்பட்டது.';

  @override
  String get kickTapButton => 'ஒவ்வொரு அசைவுக்கும் தட்டவும்';

  @override
  String kicksChartSummary(int count) {
    return 'இன்று ஒவ்வொரு மணிநேர அசைவுகளின் பட்டை வரைபடம். மொத்தம் $count.';
  }

  @override
  String kicksCount(int count) {
    return '$count';
  }

  @override
  String get kicksPastDays => 'முந்தைய நாட்கள்';

  @override
  String get kicksPerHourTitle => 'இன்று மணிக்கு அசைவுகள்';

  @override
  String kicksTodayCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'இன்று $count அசைவுகள்',
      one: 'இன்று 1 அசைவு',
      zero: 'இன்று அசைவுகள் எண்ணப்படவில்லை',
    );
    return '$_temp0';
  }

  @override
  String get languageSwitchLabel => 'செயலி மொழி';

  @override
  String lastKickAt(String time) {
    return 'கடைசி அசைவு $time';
  }

  @override
  String lastNDays(int days) {
    return '$days நாட்கள்';
  }

  @override
  String get legendAppointment => 'சந்திப்பு';

  @override
  String get legendFertile => 'கருவுறும் காலம் (மதிப்பீடு)';

  @override
  String get legendLogged => 'உடல்நலப் பதிவு';

  @override
  String get legendMedication => 'மருந்து எடுக்கப்பட்டது';

  @override
  String get legendPeriod => 'மாதவிடாய்';

  @override
  String get legendPredicted => 'கணிக்கப்பட்ட மாதவிடாய்';

  @override
  String get linkActive => 'நீங்கள் பகிர்ந்த பதிவுகளைப் பார்க்கலாம்';

  @override
  String get linkPending => 'மருத்துவர் ஏற்கக் காத்திருக்கிறது';

  @override
  String get loginChangeIdentifier => 'வேறு மின்னஞ்சலைப் பயன்படுத்து';

  @override
  String get loginIntro =>
      'உங்கள் மின்னஞ்சலை உள்ளிடவும். ஒருமுறை குறியீட்டை அனுப்புவோம்.';

  @override
  String get loginRecoveryHint =>
      'இந்த மின்னஞ்சலில் குறியீடுகள் வரவில்லையா? கணக்கை மீட்க உங்கள் மருத்துவமனையைத் தொடர்பு கொள்ளவும்.';

  @override
  String get loginTitle => 'உள்நுழை';

  @override
  String get macroCarbs => 'மாவுச்சத்து';

  @override
  String get macroFat => 'கொழுப்பு';

  @override
  String get macroProtein => 'புரதம்';

  @override
  String macroSummary(String protein, String carbs, String fat) {
    return 'பு $protein g · மா $carbs g · கொ $fat g';
  }

  @override
  String get mealBreakfast => 'காலை உணவு';

  @override
  String get mealDinner => 'இரவு உணவு';

  @override
  String get mealDrinks => 'பானங்கள்';

  @override
  String get mealLunch => 'மதிய உணவு';

  @override
  String get mealSnacks => 'சிற்றுண்டி';

  @override
  String get medicationSafetyNote =>
      'உங்கள் மருத்துவர் பரிந்துரைத்த மருந்துகளை மட்டும் சேர்க்கவும். இந்தப் பட்டியல் ஒரு நினைவூட்டல் மட்டுமே, மருத்துவ ஆலோசனை அல்ல.';

  @override
  String get medicationsNoneToday => 'இன்று டோஸ்கள் திட்டமிடப்படவில்லை.';

  @override
  String get medicationsTitle => 'மருந்துகள்';

  @override
  String get medicationsToday => 'இன்று';

  @override
  String get menuAbout => 'பற்றி';

  @override
  String get menuAppearance => 'தோற்றம்';

  @override
  String get menuCareTeam => 'என் மருத்துவக் குழு';

  @override
  String get menuEmergencyContact => 'அவசரத் தொடர்பு';

  @override
  String get menuNotifications => 'அறிவிப்புகள்';

  @override
  String get menuPersonalInfo => 'தனிப்பட்ட தகவல்';

  @override
  String get menuPregnancyInfo => 'கர்ப்பத் தகவல்';

  @override
  String get menuPrivacy => 'தனியுரிமை மற்றும் தரவு';

  @override
  String get milestoneHint => 'எ.கா. முதல் உதையை உணர்ந்தேன்';

  @override
  String get moodGood => 'நன்று';

  @override
  String get moodGreat => 'மிக நன்று';

  @override
  String get moodLow => 'குறைவு';

  @override
  String get moodOkay => 'பரவாயில்லை';

  @override
  String get moodVeryLow => 'மிகவும் குறைவு';

  @override
  String get navCalendar => 'நாள்காட்டி';

  @override
  String get navCalories => 'கலோரி';

  @override
  String get navCreate => 'சேர்';

  @override
  String get navHome => 'முகப்பு';

  @override
  String get navProfile => 'சுயவிவரம்';

  @override
  String get noData => 'இன்னும் தரவு இல்லை';

  @override
  String get noDataTapToAdd => 'இன்னும் தரவு இல்லை. சேர்க்கத் தட்டவும்.';

  @override
  String get noReadingsInPeriod => 'இந்தக் காலத்தில் அளவீடுகள் இல்லை.';

  @override
  String get noReadingsYet => 'இன்னும் அளவீடுகள் இல்லை.';

  @override
  String get nothingLogged => 'எதுவும் பதிவு செய்யப்படவில்லை.';

  @override
  String get notifAppointments => 'சந்திப்புகள்';

  @override
  String get notifDoctorMessages => 'என் மருத்துவரின் செய்திகள்';

  @override
  String get notifHealthLogs => 'உடல்நலப் பதிவு நினைவூட்டல்கள்';

  @override
  String get notifLockScreenDetails => 'பூட்டுத் திரையில் விவரங்களைக் காட்டு';

  @override
  String get notifLockScreenHelp =>
      'உங்கள் தனியுரிமையைப் பாதுகாக்க இயல்பாக முடக்கப்பட்டுள்ளது.';

  @override
  String get notifMedication => 'மருந்து';

  @override
  String get notifMilestones => 'கர்ப்ப மைல்கற்கள்';

  @override
  String get notifVaccines => 'தடுப்பூசிகள்';

  @override
  String get notificationsRationale =>
      'சந்திப்புகள், உடல்நலப் பதிவுகள் மற்றும் முக்கியமான கர்ப்ப மைல்கற்களை நினைவூட்ட அறிவிப்புகளைப் பயன்படுத்துகிறோம்.';

  @override
  String get obsActivity => 'அடிகள்';

  @override
  String get obsBloodGlucose => 'இரத்தச் சர்க்கரை';

  @override
  String get obsBloodPressure => 'இரத்த அழுத்தம்';

  @override
  String get obsHeartRate => 'இதயத் துடிப்பு';

  @override
  String get obsMood => 'மனநிலை';

  @override
  String get obsSleep => 'தூக்கம்';

  @override
  String get obsSpo2 => 'ஆக்சிஜன் (SpO2)';

  @override
  String get obsTemperature => 'உடல் வெப்பநிலை';

  @override
  String get obsWater => 'தண்ணீர்';

  @override
  String get obsWeight => 'எடை';

  @override
  String get onboardingBodySubtitle =>
      'எடை மற்றும் கலோரி மதிப்பீடுகளுக்குப் பயன்படும். பின்னர் மாற்றலாம்.';

  @override
  String get onboardingBodyTitle => 'உங்கள் உடல்';

  @override
  String onboardingDemoCode(String code) {
    return 'டெமோ பதிப்பு: $code குறியீட்டைப் பயன்படுத்தவும்.';
  }

  @override
  String get onboardingDoctorDoneSubtitle =>
      'நோயாளி தரவைப் பார்க்கும் முன் நிர்வாகி உங்கள் பதிவைச் சரிபார்ப்பார்.';

  @override
  String get onboardingDoctorDoneTitle => 'கிட்டத்தட்ட முடிந்தது';

  @override
  String get onboardingDoneSubtitle =>
      'இனி நீங்கள் பதிவு செய்யும் அனைத்தும் ஒரே இடத்தில் சேமிக்கப்படும்.';

  @override
  String get onboardingDoneTitle => 'உங்கள் சுயவிவரம் தயார்';

  @override
  String get onboardingNotPregnantInfo =>
      'சுழற்சி கண்காணிப்பு மற்றும் பொது பெண்கள் நலத்தை அமைப்போம். பின்னர் உங்கள் சுயவிவரத்திலிருந்து கர்ப்பத்தைத் தொடங்கலாம்.';

  @override
  String get onboardingPersonalSubtitle =>
      'இது உங்களுக்கேற்ற பராமரிப்பை வழங்க உதவுகிறது.';

  @override
  String get onboardingPersonalTitle => 'உங்களைப் பற்றி';

  @override
  String get onboardingPregnancySubtitle =>
      'இது உங்கள் முகப்புத் திரையை அமைக்கும். எப்போது வேண்டுமானாலும் மாற்றலாம்.';

  @override
  String get onboardingPregnancyTitle =>
      'நீங்கள் தற்போது கர்ப்பமாக உள்ளீர்களா?';

  @override
  String get onboardingRoleSubtitle =>
      'ஒன்றைத் தேர்வுசெய்யவும். உங்கள் பங்கிற்கு அனுமதிக்கப்பட்டதை மட்டுமே பார்க்கலாம்.';

  @override
  String get onboardingRoleTitle => 'செயலியைப் பயன்படுத்துபவர் யார்?';

  @override
  String onboardingStepOf(int current, int total) {
    return 'படி $current / $total';
  }

  @override
  String get onboardingVerifySubtitle =>
      'உங்கள் மின்னஞ்சலை உள்ளிடவும், ஒருமுறை குறியீட்டை அனுப்புவோம்.';

  @override
  String get onboardingVerifyTitle => 'உங்கள் கணக்கைச் சரிபார்க்கவும்';

  @override
  String otpSentTo(String destination) {
    return '$destination-க்குக் குறியீடு அனுப்பப்பட்டது';
  }

  @override
  String get outsideRangeBody =>
      'உங்கள் அளவீடு சேமிக்கப்பட்டது. இது உங்கள் மருத்துவக் குழுவின் அமைப்புகளில் உள்ள வழக்கமான வரம்புக்கு வெளியே உள்ளது. உடல்நலம் சரியில்லை என உணர்ந்தாலோ எச்சரிக்கை அறிகுறிகள் தெரிந்தாலோ உங்கள் மருத்துவக் குழுவைத் தொடர்புகொள்ளவும். இது நோயறிதல் அல்ல.';

  @override
  String get outsideRangeTitle => 'வழக்கமான வரம்புக்கு வெளியே உள்ள அளவீடு';

  @override
  String get painMild => 'லேசான';

  @override
  String get painModerate => 'மிதமான';

  @override
  String get painSevere => 'கடுமையான';

  @override
  String get past => 'முந்தையவை';

  @override
  String get patientId => 'நோயாளி ID';

  @override
  String get patientSearchEmpty => 'பொருந்தும் நோயாளிகள் இல்லை.';

  @override
  String get patientSearchHint =>
      'பெயர், ID, தொலைபேசி அல்லது பிரசவ தேதியைத் தேடு';

  @override
  String percentileFromReport(String value) {
    return 'சதமானம் $value (அறிக்கையிலிருந்து)';
  }

  @override
  String get periodDayTitle => 'மாதவிடாய் மற்றும் சுழற்சி பதிவு';

  @override
  String get permissionsBody =>
      'அறிவிப்புகள், Bluetooth, கேமரா அல்லது புகைப்படங்கள் தேவைப்படும் அம்சத்தை முதன்முறை பயன்படுத்தும்போது மட்டுமே செயலி அனுமதி கேட்கும். இவற்றை எப்போது வேண்டுமானாலும் தொலைபேசி அமைப்புகளில் மாற்றலாம்.';

  @override
  String get permissionsTitle => 'அனுமதிகள்';

  @override
  String get portionHint => 'எ.கா. 1 தட்டு, 250 ml';

  @override
  String postpartumSince(int weeks, int days) {
    return 'பிரசவத்திற்குப் பின் $weeks வாரங்கள் $days நாட்கள்';
  }

  @override
  String get pregnancyStartInfo =>
      'சேமித்தால் உங்கள் பதிவில் புதிய கர்ப்பம் தொடங்கும். முந்தைய வரலாறு இருக்கும்.';

  @override
  String get privacyIntro =>
      'உங்கள் உடல்நலப் பதிவுகள் உங்களுக்குச் சொந்தமானவை. நீங்கள் இணைக்கும் மருத்துவர்கள் மட்டுமே, நீங்கள் பகிரத் தேர்வுசெய்த பகுதிகளை மட்டுமே பார்க்க முடியும்.';

  @override
  String get purposeHint => 'எ.கா. கர்ப்பகாலப் பரிசோதனை';

  @override
  String get rangeAbove => 'வரம்புக்கு மேல்';

  @override
  String get rangeBelow => 'வரம்புக்குக் கீழ்';

  @override
  String get rangeWithin => 'வரம்புக்குள்';

  @override
  String get readingsTitle => 'அளவீடுகள்';

  @override
  String get recentFoods => 'சமீபத்திய உணவுகள்';

  @override
  String reminderAppointmentToday(String purpose, String time) {
    return 'உங்கள் சந்திப்பு ($purpose) இன்று $time-க்கு.';
  }

  @override
  String reminderAppointmentTomorrow(String purpose, String time) {
    return 'உங்கள் சந்திப்பு ($purpose) நாளை $time-க்கு.';
  }

  @override
  String get reminderLogBloodPressure =>
      'இன்றைய இரத்த அழுத்தத்தைப் பதிவு செய்ய மறக்காதீர்கள்.';

  @override
  String reminderMedication(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'இன்று இன்னும் $count டோஸ்கள் எடுக்க வேண்டும்.',
      one: 'இன்று இன்னும் 1 டோஸ் எடுக்க வேண்டும்.',
    );
    return '$_temp0';
  }

  @override
  String reminderVaccineDue(String name) {
    return 'உங்கள் அடுத்த தடுப்பூசி நேரம் வந்திருக்கலாம்: $name. உங்கள் மருத்துவக் குழுவிடம் கேளுங்கள்.';
  }

  @override
  String get remindersEmpty => 'இப்போது நினைவூட்டல்கள் இல்லை.';

  @override
  String get remindersPushNote =>
      'தொலைபேசி அறிவிப்புகள் “உங்களுக்கு ஒரு புதிய நினைவூட்டல் உள்ளது” போன்ற பொதுவான சொற்களைப் பயன்படுத்தும்; உடல்நல விவரங்கள் பூட்டுத் திரையில் ஒருபோதும் தெரியாது.';

  @override
  String get remindersTitle => 'நினைவூட்டல்கள்';

  @override
  String get riskFactors => 'ஆபத்துக் காரணிகள்';

  @override
  String get roleDoctor => 'மருத்துவர் / நிர்வாகி';

  @override
  String get roleDoctorHint => 'சரிபார்ப்புக்குப் பின் நோயாளிகளைப் பார்க்க';

  @override
  String get rolePatient => 'நோயாளி';

  @override
  String get rolePatientHint => 'கர்ப்பம், சுழற்சி, உடல்நலத்தைக் கண்காணிக்க';

  @override
  String get savedMessage => 'சேமிக்கப்பட்டது';

  @override
  String get scanTypeDefault => 'அல்ட்ராசவுண்ட்';

  @override
  String get scanTypeHint => 'எ.கா. வளர்ச்சி ஸ்கேன்';

  @override
  String get scanning => 'தேடுகிறது…';

  @override
  String get securityTitle => 'உள்நுழைவு & பாதுகாப்பு';

  @override
  String get shareCycle => 'மாதவிடாய் மற்றும் சுழற்சி';

  @override
  String get shareDocuments => 'மருத்துவ ஆவணங்கள்';

  @override
  String get shareIntimacy => 'பாலியல் செயல்பாடு';

  @override
  String get shareNutrition => 'உணவு மற்றும் கலோரி';

  @override
  String get sharePregnancy => 'கர்ப்பம் மற்றும் ஸ்கேன்கள்';

  @override
  String get shareVitals => 'உடல்நலப் பதிவுகள் மற்றும் உயிர்க்குறிகள்';

  @override
  String get sharingTitle => 'என் மருத்துவர்களுடன் பகிரப்பட்டவை';

  @override
  String get signOutConfirm => 'இந்தச் சாதனத்திலிருந்து வெளியேறவா?';

  @override
  String get ssoOr => 'அல்லது';

  @override
  String get statAlerts => 'மதிப்பாய்வுக்கான எச்சரிக்கைகள்';

  @override
  String get statAverage => 'சராசரி';

  @override
  String get statHighest => 'அதிகபட்சம்';

  @override
  String get statLowest => 'குறைந்தது';

  @override
  String get statNewRequests => 'புதிய நோயாளி கோரிக்கைகள்';

  @override
  String get statTodaysAppointments => 'இன்றைய சந்திப்புகள்';

  @override
  String get statTotalPatients => 'நோயாளிகள்';

  @override
  String get statusConnected => 'இணைக்கப்பட்டது';

  @override
  String get statusNotConnected => 'இணைக்கப்படவில்லை';

  @override
  String get symptomLogged => 'அறிகுறி';

  @override
  String get symptomsEmpty => 'அறிகுறிகள் எதுவும் பதிவு செய்யப்படவில்லை.';

  @override
  String get symptomsHistoryTitle => 'சமீபத்திய அறிகுறிகள்';

  @override
  String get symptomsLogTitle => 'அறிகுறிகளைப் பதிவு செய்';

  @override
  String get symptomsTitle => 'அறிகுறிகள்';

  @override
  String syncedReadings(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count அளவீடுகள் ஒத்திசைக்கப்பட்டன',
      one: '1 அளவீடு ஒத்திசைக்கப்பட்டது',
      zero: 'புதிய அளவீடுகள் இல்லை',
    );
    return '$_temp0';
  }

  @override
  String get tabCycle => 'மாதவிடாய் சுழற்சி';

  @override
  String get tabGrowth => 'வளர்ச்சி';

  @override
  String get tabPregnancyTimeline => 'கர்ப்பம்';

  @override
  String get tabSummary => 'சுருக்கம்';

  @override
  String get tabTimeline => 'காலவரிசை';

  @override
  String get tabVitals => 'உயிர்க்குறிகள்';

  @override
  String get targetSetByClinician => 'உங்கள் மருத்துவக் குழு அமைத்தது';

  @override
  String get taskCountKicks => 'குழந்தையின் அசைவுகளை எண்ணவும்';

  @override
  String get taskDone => 'முடிந்தது';

  @override
  String get taskDrinkWater => 'தண்ணீர் குடிக்கவும்';

  @override
  String get taskNotDone => 'முடியவில்லை';

  @override
  String taskTakeMedication(String name, String dose) {
    return '$name $dose எடுத்துக்கொள்ளவும்';
  }

  @override
  String get timelineDueDate => 'பிரசவ தேதி';

  @override
  String get timelineStart => 'கர்ப்பம் கணக்கிடப்பட்ட நாள்';

  @override
  String timelineTrimesterStarts(String name) {
    return '$name தொடங்குகிறது';
  }

  @override
  String get today => 'இன்று';

  @override
  String get totpBody =>
      'Google Authenticator, Microsoft Authenticator அல்லது இதுபோன்ற செயலியின் 6 இலக்கக் குறியீட்டுடன் உள்நுழையவும். மின்னஞ்சல் அல்லது இணையம் இல்லாமலும் செயல்படும்.';

  @override
  String get totpCodeLabel => 'அங்கீகரிப்புக் குறியீடு';

  @override
  String get totpEnable => 'சரிபார்த்து இயக்கு';

  @override
  String get totpKeyLabel => 'அமைப்புச் சாவி';

  @override
  String get totpNoApp =>
      'அங்கீகரிப்புச் செயலி எதுவும் இல்லை. Google Authenticator ஐ நிறுவி மீண்டும் முயலவும் அல்லது அமைப்புச் சாவியைத் தட்டச்சு செய்யவும்.';

  @override
  String get totpOn =>
      'அங்கீகரிப்புச் செயலி இயக்கத்தில் உள்ளது. உள்நுழையும்போது அது காட்டும் குறியீட்டை உள்ளிடவும்.';

  @override
  String get totpOpenApp => 'அங்கீகரிப்புச் செயலியைத் திற';

  @override
  String get totpSetup => 'அங்கீகரிப்புச் செயலியை அமை';

  @override
  String get totpStep1 =>
      '1. \"அங்கீகரிப்புச் செயலியைத் திற\" என்பதைத் தட்டவும், அல்லது வேறு தொலைபேசியால் இந்த QR குறியீட்டை ஸ்கேன் செய்யவும், அல்லது அமைப்புச் சாவியைச் செயலியில் தட்டச்சு செய்யவும்.';

  @override
  String get totpStep2 => '2. செயலி காட்டும் 6 இலக்கக் குறியீட்டை உள்ளிடவும்.';

  @override
  String get totpTitle => 'அங்கீகரிப்புச் செயலி';

  @override
  String get totpTurnOff => 'அணை';

  @override
  String get trimesterFirst => 'முதல் மூன்று மாதம்';

  @override
  String get trimesterLabel => 'மூன்றுமாதப் பருவம்';

  @override
  String get trimesterSecond => 'இரண்டாம் மூன்று மாதம்';

  @override
  String get trimesterThird => 'மூன்றாம் மூன்று மாதம்';

  @override
  String get ultrasoundCopyHint =>
      'ஸ்கேன் அறிக்கையிலிருந்து எண்களை நகலெடுக்கவும். அறிக்கையில் இல்லாதவற்றைக் காலியாக விடவும்.';

  @override
  String get ultrasoundNeedOneValue => 'குறைந்தது ஒரு அளவீட்டை உள்ளிடவும்.';

  @override
  String get unitBpm => 'bpm';

  @override
  String get unitHours => 'மணி';

  @override
  String get unitSteps => 'அடிகள்';

  @override
  String get unitWeeksShort => 'வாரம்';

  @override
  String get upcoming => 'வரவிருப்பவை';

  @override
  String uploadedBy(String name) {
    return '$name சேர்த்தது';
  }

  @override
  String vaccinationPurpose(String name) {
    return 'தடுப்பூசி: $name';
  }

  @override
  String get vaccineAlreadyHad => 'ஏற்கனவே போட்டுவிட்டேன் – பதிவு செய்';

  @override
  String get vaccineBook => 'தடுப்பூசி சந்திப்பை முன்பதிவு செய்';

  @override
  String get vaccineBookHint =>
      'முன்பதிவு செய்ய மேலே உள்ள பெட்டியைத் தேர்வுசெய்யவும்.';

  @override
  String get vaccineConfirmRead =>
      'இந்தத் தடுப்பூசி என்ன செய்யும், அதன் விலை என்ன என்பதைப் படித்தேன்.';

  @override
  String get vaccineDemoPrice => 'டெமோ விலை, விளக்கத்திற்கு மட்டும்.';

  @override
  String get vaccineDoctorConfirms =>
      'இந்தத் தடுப்பூசி உங்களுக்கு ஏற்றதா என்பதை உங்கள் மருத்துவர் சந்திப்பில் உறுதிப்படுத்துவார்.';

  @override
  String get vaccineDueNow => 'இப்போது போட வேண்டும்';

  @override
  String get vaccineGiven => 'போடப்பட்டது';

  @override
  String vaccineGivenOn(String date) {
    return '$date அன்று போடப்பட்டது';
  }

  @override
  String get vaccineHistory => 'தடுப்பூசி வரலாறு';

  @override
  String get vaccineHistoryEmpty =>
      'தடுப்பூசிகள் எதுவும் பதிவு செய்யப்படவில்லை.';

  @override
  String get vaccineNoDescription =>
      'உங்கள் கிளினிக் இன்னும் விளக்கம் சேர்க்கவில்லை.';

  @override
  String get vaccinePending => 'நிலுவையில்';

  @override
  String vaccinePriceAt(String clinic) {
    return '$clinic-இல்';
  }

  @override
  String get vaccinePriceLabel => 'விலை';

  @override
  String get vaccinePriceUnknown => 'விலையை உங்கள் கிளினிக்கிடம் கேளுங்கள்.';

  @override
  String get vaccineTapForDetails => 'விவரங்கள் மற்றும் விலை';

  @override
  String get vaccineWhatItDoes => 'இது என்ன செய்யும்';

  @override
  String get vaccineWhen => 'எப்போது';

  @override
  String get vaccinesTitle => 'தடுப்பூசிகள்';

  @override
  String get verificationStatus => 'சரிபார்ப்பு';

  @override
  String get verified => 'சரிபார்க்கப்பட்டது';

  @override
  String versionLabel(String version) {
    return 'பதிப்பு $version';
  }

  @override
  String get warningSignLogNow => 'இப்போது இது உள்ளது — பதிவு செய்';

  @override
  String get warningSignsIntro =>
      'இவற்றில் ஏதேனும் இருந்தால் உடனே உதவி பெறுங்கள். அடுத்த சந்திப்பு வரை காத்திருக்க வேண்டாம்.';

  @override
  String get warningSignsTitle => 'எச்சரிக்கை அறிகுறிகள்';

  @override
  String waterTodayMl(String amount) {
    return 'இன்று $amount ml';
  }

  @override
  String get welcomeCreateAccount => 'கணக்கை உருவாக்கு';

  @override
  String welcomeDemoHint(String code) {
    return 'டெமோ பதிப்பு: demo.patient@example.com (Gwen, கர்ப்பிணி), demo.cycle@example.com (Aina, சுழற்சி கண்காணிப்பு) அல்லது demo.doctor@example.com என உள்நுழைந்து, $code குறியீட்டைப் பயன்படுத்தவும். செயலியை மீண்டும் தொடங்கும்போது டெமோ தரவு மீட்டமைக்கப்படும்.';
  }

  @override
  String get welcomeSignIn => 'எனக்கு ஏற்கனவே கணக்கு உள்ளது';

  @override
  String get welcomeTagline =>
      'உங்கள் கர்ப்பம், மாதவிடாய் சுழற்சி மற்றும் பெண்கள் நலப் பதிவு, உங்கள் மருத்துவக் குழுவுடன் பகிரப்படுகிறது.';

  @override
  String get yourDoctors => 'உங்கள் மருத்துவர்கள்';
}
