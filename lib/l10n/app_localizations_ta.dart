// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'Maternal';

  @override
  String get navHome => 'முகப்பு';

  @override
  String get navCalendar => 'நாட்காட்டி';

  @override
  String get navCreate => 'சேர்';

  @override
  String get navCalories => 'கலோரி';

  @override
  String get navProfile => 'சுயவிவரம்';

  @override
  String get createTitle => 'எதைச் சேர்க்க விரும்புகிறீர்கள்?';

  @override
  String get createHealthLog => 'உடல்நலப் பதிவு';

  @override
  String get createSymptoms => 'அறிகுறிகள்';

  @override
  String get createPeriod => 'மாதவிடாய்';

  @override
  String get createMeal => 'உணவு';

  @override
  String get createPregnancyRecord => 'கர்ப்பப் பதிவு';

  @override
  String get createVaccine => 'தடுப்பூசி';

  @override
  String get createAppointment => 'சந்திப்பு';

  @override
  String get createDocument => 'மருத்துவ ஆவணம்';

  @override
  String get comingSoon =>
      'விரைவில் வரும். இந்தப் பகுதி அடுத்த கட்டத்தில் உருவாக்கப்படும்.';

  @override
  String get soonBadge => 'விரைவில்';

  @override
  String homeGreeting(String name) {
    return 'வணக்கம், $name';
  }

  @override
  String get homeGreetingNoName => 'வணக்கம்';

  @override
  String get pregnancyOverview => 'கர்ப்பக் கண்ணோட்டம்';

  @override
  String weeksDays(int weeks, int days) {
    return '$weeks வாரங்கள் $days நாட்கள்';
  }

  @override
  String dueDateLabel(String date) {
    return 'பிரசவ தேதி $date';
  }

  @override
  String daysToGo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'இன்னும் $count நாட்கள்',
      one: 'இன்னும் 1 நாள்',
      zero: 'இன்று பிரசவ தேதி',
    );
    return '$_temp0';
  }

  @override
  String daysPastDue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'பிரசவ தேதியைக் கடந்து $count நாட்கள்',
      one: 'பிரசவ தேதியைக் கடந்து 1 நாள்',
    );
    return '$_temp0';
  }

  @override
  String get trimesterFirst => 'முதல் மூன்று மாதம்';

  @override
  String get trimesterSecond => 'இரண்டாம் மூன்று மாதம்';

  @override
  String get trimesterThird => 'மூன்றாம் மூன்று மாதம்';

  @override
  String babiesCount(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '1': 'ஒற்றைக் குழந்தை',
      '2': 'இரட்டையர்',
      '3': 'மூவர்',
      'other': '$count குழந்தைகள்',
    });
    return '$_temp0';
  }

  @override
  String get setDueDatePrompt =>
      'கர்ப்ப முன்னேற்றத்தைக் காண சுயவிவரத்தில் உங்கள் பிரசவ தேதியைச் சேர்க்கவும்.';

  @override
  String get cycleOverview => 'சுழற்சிக் கண்ணோட்டம்';

  @override
  String nextPeriodEstimate(String date) {
    return 'அடுத்த மாதவிடாய் (மதிப்பீடு): $date';
  }

  @override
  String get noCycleData =>
      'சுழற்சி மதிப்பீடுகளைத் தொடங்க, சேர் என்பதிலிருந்து மாதவிடாயைப் பதிவு செய்யவும்.';

  @override
  String get todaysHealth => 'இன்றைய உடல்நலம்';

  @override
  String get noData => 'தரவு இல்லை';

  @override
  String get metricWeight => 'எடை';

  @override
  String get metricBloodPressure => 'இரத்த அழுத்தம்';

  @override
  String get metricHeartRate => 'இதயத் துடிப்பு';

  @override
  String get metricGlucose => 'இரத்தச் சர்க்கரை';

  @override
  String get metricTemperature => 'உடல் வெப்பநிலை';

  @override
  String get metricSpo2 => 'SpO2';

  @override
  String get metricSleep => 'தூக்கம்';

  @override
  String get metricWater => 'தண்ணீர்';

  @override
  String get metricFetalMovement => 'கரு அசைவுகள்';

  @override
  String get metricSymptom => 'அறிகுறி';

  @override
  String get statusLow => 'குறைவு';

  @override
  String get statusNormal => 'வழக்கமானது';

  @override
  String get statusHigh => 'அதிகம்';

  @override
  String get todaysTasks => 'இன்றைய பணிகள்';

  @override
  String get taskLogBp => 'இரத்த அழுத்தத்தைப் பதிவு செய்யவும்';

  @override
  String get taskKicks => 'கரு அசைவுகளைப் பதிவு செய்யவும்';

  @override
  String get taskWater => '8 குவளை தண்ணீர் குடிக்கவும்';

  @override
  String get taskLogMeal => 'உங்கள் உணவுகளைப் பதிவு செய்யவும்';

  @override
  String get recentActivity => 'சமீபத்திய உடல்நலச் செயல்பாடு';

  @override
  String get noActivity =>
      'இன்னும் பதிவு எதுவும் இல்லை. முதல் பதிவைச் சேர்க்க சேர் என்பதைத் தட்டவும்.';

  @override
  String get warningSigns => 'எச்சரிக்கை அறிகுறிகள்';

  @override
  String get warningSignsIntro =>
      'இவற்றில் எதையாவது கவனித்தால் மருத்துவ ஆலோசனை பெறவும். இந்தச் செயலி நோயறிதல் செய்யாது.';

  @override
  String get disclaimer =>
      'மருத்துவப் பணிமுறை வடிவமைப்புக்கான முன்மாதிரி. பதிவுசெய்யப்பட்ட மருத்துவக் கருவி அல்ல.';

  @override
  String get healthLogTitle => 'உடல்நலப் பதிவைச் சேர்';

  @override
  String get measurement => 'அளவீடு';

  @override
  String get systolic => 'சிஸ்டாலிக் (mmHg)';

  @override
  String get diastolic => 'டயஸ்டாலிக் (mmHg)';

  @override
  String valueWithUnit(String unit) {
    return 'மதிப்பு ($unit)';
  }

  @override
  String get noteOptional => 'குறிப்பு (விருப்பத்தேர்வு)';

  @override
  String get save => 'சேமி';

  @override
  String get cancel => 'ரத்து';

  @override
  String get delete => 'நீக்கு';

  @override
  String get invalidNumber => 'சரியான எண்ணை உள்ளிடவும்';

  @override
  String get required => 'கட்டாயம்';

  @override
  String get saved => 'சேமிக்கப்பட்டது';

  @override
  String get quickKick => '1 அசைவைச் சேர்';

  @override
  String kicksToday(int count) {
    return 'இன்று $count அசைவுகள்';
  }

  @override
  String get symptomTitle => 'அறிகுறியைப் பதிவு செய்';

  @override
  String get symptomCommon => 'பொதுவானவை';

  @override
  String get symptomWarning => 'மருத்துவக் கவனம் தேவை';

  @override
  String get symptomLogged => 'அறிகுறி பதிவு செய்யப்பட்டது';

  @override
  String get sym_nausea => 'குமட்டல்';

  @override
  String get sym_fatigue => 'சோர்வு';

  @override
  String get sym_backPain => 'முதுகு வலி';

  @override
  String get sym_heartburn => 'நெஞ்செரிச்சல்';

  @override
  String get sym_cramps => 'தசைப்பிடிப்பு';

  @override
  String get sym_headache => 'தலைவலி';

  @override
  String get sym_reducedMovements => 'கரு அசைவு குறைவு அல்லது இல்லை';

  @override
  String get sym_bleeding => 'யோனி இரத்தப்போக்கு';

  @override
  String get sym_severeHeadacheVision => 'பார்வை மாற்றத்துடன் கடுமையான தலைவலி';

  @override
  String get sym_suddenSwelling =>
      'முகம், கைகள் அல்லது பாதங்களில் திடீர் வீக்கம்';

  @override
  String get sym_severeAbdominalPain =>
      'கடுமையான அல்லது தொடர்ச்சியான வயிற்று வலி';

  @override
  String get sym_fluidLeak => 'யோனியிலிருந்து நீர் போன்ற கசிவு';

  @override
  String get sym_feverUnwell => 'காய்ச்சல் அல்லது மிகவும் உடல்நலக்குறைவு';

  @override
  String get act_reducedMovements =>
      'உடனடியாக உங்கள் மருத்துவமனை பிரசவ வார்டு அல்லது மகப்பேறு குழுவைத் தொடர்பு கொள்ளவும்.';

  @override
  String get act_bleeding =>
      'இப்போதே அருகிலுள்ள மருத்துவமனை அவசரப் பிரிவு அல்லது பிரசவ வார்டுக்குச் செல்லவும்.';

  @override
  String get act_severeHeadacheVision =>
      'இன்றே அவசர மருத்துவப் பரிசோதனை பெறவும்.';

  @override
  String get act_suddenSwelling =>
      'இரத்த அழுத்தம் மற்றும் சிறுநீர் பரிசோதனைக்கு இன்றே உங்கள் மருத்துவக் குழுவைத் தொடர்பு கொள்ளவும்.';

  @override
  String get act_severeAbdominalPain => 'அவசர மருத்துவ உதவி பெறவும்.';

  @override
  String get act_fluidLeak =>
      'உடனடியாக உங்கள் மருத்துவமனை பிரசவ வார்டைத் தொடர்பு கொள்ளவும்.';

  @override
  String get act_feverUnwell =>
      'அதே நாளில் உங்கள் மருத்துவக் குழுவைத் தொடர்பு கொள்ளவும்.';

  @override
  String get periodTitle => 'மாதவிடாயைப் பதிவு செய்';

  @override
  String get periodStart => 'தொடக்க தேதி';

  @override
  String get periodEnd => 'முடிவு தேதி (விருப்பத்தேர்வு)';

  @override
  String get flow => 'உதிரப்போக்கு';

  @override
  String get flow_spotting => 'புள்ளிகள்';

  @override
  String get flow_light => 'குறைவு';

  @override
  String get flow_medium => 'நடுத்தரம்';

  @override
  String get flow_heavy => 'அதிகம்';

  @override
  String get endBeforeStart =>
      'முடிவு தேதி தொடக்க தேதிக்கு முன் இருக்க முடியாது';

  @override
  String get legendPeriod => 'மாதவிடாய்';

  @override
  String get legendPredicted => 'கணிக்கப்பட்ட மாதவிடாய்';

  @override
  String get legendFertile => 'கருவுறும் காலம்';

  @override
  String get legendOvulation => 'கருமுட்டை வெளியீடு';

  @override
  String avgCycle(int days) {
    return 'சராசரி சுழற்சி $days நாட்கள்';
  }

  @override
  String avgPeriod(int days) {
    return 'சராசரி மாதவிடாய் $days நாட்கள்';
  }

  @override
  String get estimatesNote =>
      'கணிப்புகள் மதிப்பீடுகள் மட்டுமே, மருத்துவ உண்மைகள் அல்ல. கருத்தடைக்கு இவற்றை நம்ப வேண்டாம்.';

  @override
  String get irregularNote =>
      'உங்கள் சுழற்சிகள் அதிகம் மாறுபட்டுள்ளன. கணிப்புகள் குறைவாகத் துல்லியமாக இருக்கலாம்.';

  @override
  String get dayEmpty => 'இந்த நாளில் பதிவு எதுவும் இல்லை.';

  @override
  String get logPeriodThisDay => 'இந்த நாளில் தொடங்கும் மாதவிடாயைப் பதிவு செய்';

  @override
  String get pregnancyTimeline => 'கர்ப்பக் காலவரிசை';

  @override
  String milestoneWeek(int week) {
    return 'வாரம் $week';
  }

  @override
  String get ms_firstTrimesterEnds => 'முதல் மூன்று மாதம் முடிவு';

  @override
  String get ms_halfway => 'பாதி வழி';

  @override
  String get ms_thirdTrimester => 'மூன்றாம் மூன்று மாதம் தொடக்கம்';

  @override
  String get ms_fullTerm => 'முழு காலம்';

  @override
  String get ms_dueDate => 'பிரசவ தேதி';

  @override
  String get calorieTarget => 'தினசரி இலக்கு';

  @override
  String get consumed => 'உட்கொண்டது';

  @override
  String get remaining => 'மீதம்';

  @override
  String overBy(int kcal) {
    return '$kcal kcal அதிகம்';
  }

  @override
  String kcalValue(int kcal) {
    return '$kcal kcal';
  }

  @override
  String get meal_breakfast => 'காலை உணவு';

  @override
  String get meal_lunch => 'மதிய உணவு';

  @override
  String get meal_dinner => 'இரவு உணவு';

  @override
  String get meal_snack => 'சிற்றுண்டி';

  @override
  String get meal_drink => 'பானங்கள்';

  @override
  String get addFood => 'உணவைச் சேர்';

  @override
  String get foodName => 'உணவின் பெயர்';

  @override
  String get portion => 'அளவு (விருப்பத்தேர்வு)';

  @override
  String get caloriesKcal => 'கலோரி (kcal)';

  @override
  String get proteinG => 'புரதம் (g)';

  @override
  String get carbsG => 'மாவுச்சத்து (g)';

  @override
  String get fatG => 'கொழுப்பு (g)';

  @override
  String macros(String p, String c, String f) {
    return 'புரதம் $p g · மாவுச்சத்து $c g · கொழுப்பு $f g';
  }

  @override
  String get targetEstimateNote =>
      'இந்த இலக்கு உங்கள் சுயவிவரத்திலிருந்து கணக்கிடப்பட்ட மதிப்பீடு, மருத்துவப் பரிந்துரை அல்ல. உங்கள் மருத்துவர் அல்லது உணவியல் நிபுணர் சுயவிவரத்தில் இலக்கை அமைக்கலாம்.';

  @override
  String get targetCustomNote => 'உங்கள் மருத்துவக் குழு அமைத்த இலக்கு.';

  @override
  String get nothingLogged => 'பதிவு இல்லை';

  @override
  String get profileTitle => 'சுயவிவரம்';

  @override
  String get fullName => 'முழுப் பெயர்';

  @override
  String get dateOfBirth => 'பிறந்த தேதி';

  @override
  String get heightCm => 'உயரம் (cm)';

  @override
  String get preWeightKg => 'கர்ப்பத்திற்கு முந்தைய எடை (kg)';

  @override
  String get pregnantQuestion => 'நீங்கள் தற்போது கர்ப்பமாக இருக்கிறீர்களா?';

  @override
  String get yes => 'ஆம்';

  @override
  String get no => 'இல்லை';

  @override
  String get expectedDueDate => 'எதிர்பார்க்கப்படும் பிரசவ தேதி';

  @override
  String get numberOfBabies => 'குழந்தைகளின் எண்ணிக்கை';

  @override
  String get activityLevel => 'செயல்பாட்டு நிலை';

  @override
  String get act_low => 'குறைவு';

  @override
  String get act_light => 'லேசானது';

  @override
  String get act_moderate => 'மிதமானது';

  @override
  String get act_high => 'அதிகம்';

  @override
  String get customCalorieTarget =>
      'மருத்துவக் குழுவின் கலோரி இலக்கு (kcal, விருப்பத்தேர்வு)';

  @override
  String get role => 'பங்கு';

  @override
  String get rolePatient => 'நோயாளி';

  @override
  String get roleDoctor => 'மருத்துவர் / நிர்வாகி';

  @override
  String get language => 'மொழி';

  @override
  String get saveProfile => 'சுயவிவரத்தைச் சேமி';

  @override
  String get selectDate => 'தேதியைத் தேர்ந்தெடு';

  @override
  String get privacyNote =>
      'இந்த ஆரம்பப் பதிப்பில் உங்கள் தரவு இந்தச் சாதனத்தில் மட்டுமே சேமிக்கப்படுகிறது, இன்னும் மறையாக்கம் செய்யப்படவில்லை. உண்மையான நோயாளித் தரவை உள்ளிட வேண்டாம்.';

  @override
  String get doctorDashboard => 'மருத்துவர் டாஷ்போர்டு';

  @override
  String get totalPatients => 'நோயாளிகள்';

  @override
  String get todaysAppointments => 'இன்றைய சந்திப்புகள்';

  @override
  String get alertsToReview => 'பரிசீலிக்க வேண்டிய எச்சரிக்கைகள்';

  @override
  String get patients => 'நோயாளிகள்';

  @override
  String get searchPatients => 'பெயர், அடையாள எண் அல்லது தொலைபேசி மூலம் தேடு';

  @override
  String get doctorDemoNote =>
      'மாதிரித் தரவு. நோயாளிப் பதிவுகள் அடுத்த கட்டத்தில் கிளினிக் சேவையகத்திலிருந்து வரும்.';

  @override
  String get noMatches => 'பொருந்தும் நோயாளிகள் இல்லை';
}
