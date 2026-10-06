// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Maternal';

  @override
  String get navHome => '首頁';

  @override
  String get navCalendar => '日曆';

  @override
  String get navCreate => '新增';

  @override
  String get navCalories => '卡路里';

  @override
  String get navProfile => '個人';

  @override
  String get createTitle => '您想新增什麼？';

  @override
  String get createHealthLog => '健康紀錄';

  @override
  String get createSymptoms => '症狀';

  @override
  String get createPeriod => '經期';

  @override
  String get createMeal => '餐點';

  @override
  String get createPregnancyRecord => '孕期紀錄';

  @override
  String get createVaccine => '疫苗';

  @override
  String get createAppointment => '預約';

  @override
  String get createDocument => '醫療文件';

  @override
  String get comingSoon => '即將推出。此功能將在後續階段開發。';

  @override
  String get soonBadge => '即將推出';

  @override
  String homeGreeting(String name) {
    return '$name，您好';
  }

  @override
  String get homeGreetingNoName => '您好';

  @override
  String get pregnancyOverview => '孕期概覽';

  @override
  String weeksDays(int weeks, int days) {
    return '$weeks 週 $days 天';
  }

  @override
  String dueDateLabel(String date) {
    return '預產期 $date';
  }

  @override
  String daysToGo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '還有 $count 天',
      zero: '今天是預產期',
    );
    return '$_temp0';
  }

  @override
  String daysPastDue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已過預產期 $count 天',
    );
    return '$_temp0';
  }

  @override
  String get trimesterFirst => '第一孕期';

  @override
  String get trimesterSecond => '第二孕期';

  @override
  String get trimesterThird => '第三孕期';

  @override
  String babiesCount(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '1': '單胎',
      '2': '雙胞胎',
      '3': '三胞胎',
      'other': '$count 胞胎',
    });
    return '$_temp0';
  }

  @override
  String get setDueDatePrompt => '請在個人資料中填寫預產期，以查看孕期進度。';

  @override
  String get cycleOverview => '週期概覽';

  @override
  String nextPeriodEstimate(String date) {
    return '下次經期（估計）：$date';
  }

  @override
  String get noCycleData => '從「新增」記錄經期，即可開始週期估算。';

  @override
  String get todaysHealth => '今日健康';

  @override
  String get noData => '沒有資料';

  @override
  String get metricWeight => '體重';

  @override
  String get metricBloodPressure => '血壓';

  @override
  String get metricHeartRate => '心率';

  @override
  String get metricGlucose => '血糖';

  @override
  String get metricTemperature => '體溫';

  @override
  String get metricSpo2 => '血氧';

  @override
  String get metricSleep => '睡眠';

  @override
  String get metricWater => '飲水';

  @override
  String get metricFetalMovement => '胎動';

  @override
  String get metricSymptom => '症狀';

  @override
  String get statusLow => '偏低';

  @override
  String get statusNormal => '一般範圍';

  @override
  String get statusHigh => '偏高';

  @override
  String get todaysTasks => '今日任務';

  @override
  String get taskLogBp => '記錄血壓';

  @override
  String get taskKicks => '記錄胎動';

  @override
  String get taskWater => '喝 8 杯水';

  @override
  String get taskLogMeal => '記錄餐點';

  @override
  String get recentActivity => '最新健康活動';

  @override
  String get noActivity => '尚未有紀錄。點選「新增」加入第一筆資料。';

  @override
  String get warningSigns => '警示徵兆';

  @override
  String get warningSignsIntro => '如出現以下任何情況，請尋求醫療協助。本應用程式不提供診斷。';

  @override
  String get disclaimer => '臨床流程設計原型，並非已註冊的醫療器材。';

  @override
  String get healthLogTitle => '新增健康紀錄';

  @override
  String get measurement => '測量項目';

  @override
  String get systolic => '收縮壓 (mmHg)';

  @override
  String get diastolic => '舒張壓 (mmHg)';

  @override
  String valueWithUnit(String unit) {
    return '數值 ($unit)';
  }

  @override
  String get noteOptional => '備註（選填）';

  @override
  String get save => '儲存';

  @override
  String get cancel => '取消';

  @override
  String get delete => '刪除';

  @override
  String get invalidNumber => '請輸入有效數字';

  @override
  String get required => '必填';

  @override
  String get saved => '已儲存';

  @override
  String get quickKick => '新增 1 次胎動';

  @override
  String kicksToday(int count) {
    return '今日胎動 $count 次';
  }

  @override
  String get symptomTitle => '記錄症狀';

  @override
  String get symptomCommon => '常見症狀';

  @override
  String get symptomWarning => '需要就醫';

  @override
  String get symptomLogged => '已記錄症狀';

  @override
  String get sym_nausea => '噁心';

  @override
  String get sym_fatigue => '疲倦';

  @override
  String get sym_backPain => '背痛';

  @override
  String get sym_heartburn => '胃灼熱';

  @override
  String get sym_cramps => '抽筋／腹部痙攣';

  @override
  String get sym_headache => '頭痛';

  @override
  String get sym_reducedMovements => '胎動減少或沒有胎動';

  @override
  String get sym_bleeding => '陰道出血';

  @override
  String get sym_severeHeadacheVision => '嚴重頭痛並伴隨視力改變';

  @override
  String get sym_suddenSwelling => '臉部、手部或腳部突然腫脹';

  @override
  String get sym_severeAbdominalPain => '嚴重或持續腹痛';

  @override
  String get sym_fluidLeak => '陰道流出水狀分泌物或羊水';

  @override
  String get sym_feverUnwell => '發燒或感到非常不適';

  @override
  String get act_reducedMovements => '請立即聯絡醫院產房或產科團隊。';

  @override
  String get act_bleeding => '請立即前往最近的醫院急診或產房。';

  @override
  String get act_severeHeadacheVision => '請於今天盡快就醫評估。';

  @override
  String get act_suddenSwelling => '請於今天聯絡醫療團隊檢查血壓及尿液。';

  @override
  String get act_severeAbdominalPain => '請盡快就醫。';

  @override
  String get act_fluidLeak => '請立即聯絡醫院產房。';

  @override
  String get act_feverUnwell => '請於當天聯絡醫療團隊。';

  @override
  String get periodTitle => '記錄經期';

  @override
  String get periodStart => '開始日期';

  @override
  String get periodEnd => '結束日期（選填）';

  @override
  String get flow => '經血量';

  @override
  String get flow_spotting => '點狀出血';

  @override
  String get flow_light => '少量';

  @override
  String get flow_medium => '中量';

  @override
  String get flow_heavy => '大量';

  @override
  String get endBeforeStart => '結束日期不能早於開始日期';

  @override
  String get legendPeriod => '經期';

  @override
  String get legendPredicted => '預測經期';

  @override
  String get legendFertile => '易孕期';

  @override
  String get legendOvulation => '排卵日';

  @override
  String avgCycle(int days) {
    return '平均週期 $days 天';
  }

  @override
  String avgPeriod(int days) {
    return '平均經期 $days 天';
  }

  @override
  String get estimatesNote => '預測僅為估計，並非醫療事實。請勿以此作為避孕依據。';

  @override
  String get irregularNote => '您的週期變化較大，預測可能較不準確。';

  @override
  String get dayEmpty => '這天沒有紀錄。';

  @override
  String get logPeriodThisDay => '記錄從這天開始的經期';

  @override
  String get pregnancyTimeline => '孕期時間軸';

  @override
  String milestoneWeek(int week) {
    return '第 $week 週';
  }

  @override
  String get ms_firstTrimesterEnds => '第一孕期結束';

  @override
  String get ms_halfway => '孕期過半';

  @override
  String get ms_thirdTrimester => '進入第三孕期';

  @override
  String get ms_fullTerm => '足月';

  @override
  String get ms_dueDate => '預產期';

  @override
  String get calorieTarget => '每日目標';

  @override
  String get consumed => '已攝取';

  @override
  String get remaining => '剩餘';

  @override
  String overBy(int kcal) {
    return '超出 $kcal 大卡';
  }

  @override
  String kcalValue(int kcal) {
    return '$kcal 大卡';
  }

  @override
  String get meal_breakfast => '早餐';

  @override
  String get meal_lunch => '午餐';

  @override
  String get meal_dinner => '晚餐';

  @override
  String get meal_snack => '點心';

  @override
  String get meal_drink => '飲品';

  @override
  String get addFood => '新增食物';

  @override
  String get foodName => '食物名稱';

  @override
  String get portion => '份量（選填）';

  @override
  String get caloriesKcal => '熱量（大卡）';

  @override
  String get proteinG => '蛋白質 (g)';

  @override
  String get carbsG => '碳水化合物 (g)';

  @override
  String get fatG => '脂肪 (g)';

  @override
  String macros(String p, String c, String f) {
    return '蛋白質 $p g · 碳水 $c g · 脂肪 $f g';
  }

  @override
  String get targetEstimateNote => '此目標是根據您的個人資料估算，並非醫療處方。您的醫師或營養師可在個人資料中設定目標。';

  @override
  String get targetCustomNote => '目標由您的醫療團隊設定。';

  @override
  String get nothingLogged => '尚無紀錄';

  @override
  String get profileTitle => '個人資料';

  @override
  String get fullName => '全名';

  @override
  String get dateOfBirth => '出生日期';

  @override
  String get heightCm => '身高 (cm)';

  @override
  String get preWeightKg => '懷孕前體重 (kg)';

  @override
  String get pregnantQuestion => '您目前懷孕嗎？';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get expectedDueDate => '預產期';

  @override
  String get numberOfBabies => '胎數';

  @override
  String get activityLevel => '活動量';

  @override
  String get act_low => '低';

  @override
  String get act_light => '輕度';

  @override
  String get act_moderate => '中度';

  @override
  String get act_high => '高';

  @override
  String get customCalorieTarget => '醫療團隊設定的熱量目標（大卡，選填）';

  @override
  String get role => '角色';

  @override
  String get rolePatient => '病人';

  @override
  String get roleDoctor => '醫師／管理員';

  @override
  String get language => '語言';

  @override
  String get saveProfile => '儲存個人資料';

  @override
  String get selectDate => '選擇日期';

  @override
  String get privacyNote => '在此早期版本中，您的資料只儲存在此裝置上，且尚未加密。請勿輸入真實病人資料。';

  @override
  String get doctorDashboard => '醫師儀表板';

  @override
  String get totalPatients => '病人';

  @override
  String get todaysAppointments => '今日預約';

  @override
  String get alertsToReview => '待審警示';

  @override
  String get patients => '病人';

  @override
  String get searchPatients => '以姓名、編號或電話搜尋';

  @override
  String get doctorDemoNote => '示範資料。病人紀錄將在後續階段由診所伺服器提供。';

  @override
  String get noMatches => '沒有符合的病人';
}
