// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get aboutRegulatory =>
      '供臨床流程設計使用的開發版本，並非《2012年醫療器材法令》（第737號法令）下的註冊醫療器材。';

  @override
  String get accessLogExplainer => '每次開啟病人紀錄都會被記錄，病人與管理員可查看。';

  @override
  String get accessLogTitle => '我的存取紀錄';

  @override
  String accessLogViewed(String id) {
    return '查看紀錄 $id';
  }

  @override
  String get actionAccept => '接受';

  @override
  String get actionAdd => '新增';

  @override
  String get actionBabyDelivered => '寶寶已出生';

  @override
  String get actionBack => '返回';

  @override
  String get actionCancel => '取消';

  @override
  String get actionConfirm => '確認';

  @override
  String get actionConnect => '連接';

  @override
  String get actionContinue => '繼續';

  @override
  String get actionCopy => '複製';

  @override
  String get actionDecline => '拒絕';

  @override
  String get actionDecrease => '減少';

  @override
  String get actionDisconnect => '中斷連接';

  @override
  String get actionEndPostpartum => '轉為一般照護';

  @override
  String get actionFinish => '完成';

  @override
  String get actionGoHome => '前往首頁';

  @override
  String get actionImPregnant => '我懷孕了';

  @override
  String get actionIncrease => '增加';

  @override
  String get actionNextDay => '後一天';

  @override
  String get actionNextMonth => '下個月';

  @override
  String get actionNotNow => '稍後再說';

  @override
  String get actionOk => '好';

  @override
  String get actionPreviousDay => '前一天';

  @override
  String get actionPreviousMonth => '上個月';

  @override
  String get actionRetry => '再試一次';

  @override
  String get actionSave => '儲存';

  @override
  String get actionScan => '搜尋裝置';

  @override
  String get actionSendCode => '傳送驗證碼';

  @override
  String get actionSignOut => '登出';

  @override
  String get actionToday => '回到今天';

  @override
  String get actionUnderstood => '我明白了';

  @override
  String get actionUndoLast => '撤銷上一次';

  @override
  String get actionVerify => '驗證';

  @override
  String get activityActive => '高度活動';

  @override
  String get activityEmpty => '您最近的紀錄會顯示在這裡。';

  @override
  String get activityLight => '輕度活動';

  @override
  String get activityModerate => '中度活動';

  @override
  String get activitySedentary => '久坐為主';

  @override
  String get addAppointmentTitle => '新增預約';

  @override
  String get addDocumentTitle => '新增文件';

  @override
  String get addFoodTitle => '新增飲食';

  @override
  String get addHealthLogTitle => '新增健康紀錄';

  @override
  String get addMilestoneTitle => '新增里程碑';

  @override
  String get addNoteTitle => '新增備註';

  @override
  String get addUltrasoundTitle => '新增超聲波結果';

  @override
  String ageYears(int age) {
    return '$age 歲';
  }

  @override
  String alertCount(int count) {
    return '$count 項警示';
  }

  @override
  String alertWarningSign(String name) {
    return '警示徵兆：$name';
  }

  @override
  String alertsExplainer(int days) {
    return '過去 $days 天內超出設定範圍的讀數及記錄的警示徵兆。';
  }

  @override
  String get alertsNone => '目前沒有需要查看的項目。';

  @override
  String get alertsToReview => '待查看警示';

  @override
  String get answerNo => '否';

  @override
  String get answerYes => '是';

  @override
  String get appName => 'Maternal Care 母嬰照護';

  @override
  String get appearanceDark => '深色';

  @override
  String get appearanceExplainer => '預設為淺色模式。夜間可選擇深色，或跟隨手機設定。';

  @override
  String get appearanceLight => '淺色';

  @override
  String get appearanceSystem => '跟隨手機';

  @override
  String get appointmentDefaultPurpose => '預約';

  @override
  String get appointmentsNoneToday => '今天沒有預約。';

  @override
  String get appointmentsNoneUpcoming => '沒有即將到來的預約。';

  @override
  String get appointmentsTitle => '預約';

  @override
  String get assistantBadKey => 'AI 服務拒絕了應用程式的金鑰，請聯絡應用程式管理員。';

  @override
  String get assistantBlocked => 'AI 服務沒有回答這個問題。請換個方式再問一次。';

  @override
  String get assistantEducational => '衛教資訊';

  @override
  String get assistantFailed => '無法載入回答，請再試一次。';

  @override
  String get assistantHomeHint => 'AI 可用 English、BM、中文或 தமிழ் 回答。僅供衛教，並非診斷。';

  @override
  String get assistantInputHint => '輸入您的問題';

  @override
  String get assistantLanguage => '回答語言';

  @override
  String get assistantNetwork => '無法連線至 AI 服務。請檢查網路連線後再試一次。';

  @override
  String get assistantNewChat => '新對話';

  @override
  String get assistantNotConfigured => '此版本的應用程式尚未設定 AI 助理，請聯絡應用程式管理員。';

  @override
  String get assistantSend => '傳送';

  @override
  String get assistantThinking => '思考中…';

  @override
  String get assistantTitle => '提出問題';

  @override
  String get assistantUseDetails => '使用我的懷孕資料';

  @override
  String get assistantUseDetailsHelp =>
      '關閉：不會傳送任何紀錄。開啟：只分享您的階段（例如 32 週），不會分享姓名。';

  @override
  String atGestation(String ga) {
    return '於 $ga';
  }

  @override
  String get authAuthenticatorHelp => '請輸入驗證器應用程式為 Maternal 顯示的 6 位數代碼。';

  @override
  String get authEmailNotSetUp => '此版本的應用程式尚未設定電郵驗證碼。';

  @override
  String get authInvalidCode => '驗證碼不正確，請檢查後再試。';

  @override
  String get authInvalidIdentifier => '請輸入有效的電郵地址。';

  @override
  String get authNoAccountYet => '已驗證。目前還沒有帳戶，我們來建立一個。';

  @override
  String get authSendCodeInstead => '改用電郵寄送驗證碼';

  @override
  String authSendFailed(String reason) {
    return '無法傳送或驗證代碼。$reason';
  }

  @override
  String get babiesMore => '更多';

  @override
  String get babiesSingle => '單胎';

  @override
  String get babiesTriplets => '三胞胎';

  @override
  String get babiesTwins => '雙胞胎';

  @override
  String get babyParameters => '寶寶測量數據';

  @override
  String bluetoothBattery(int level) {
    return '電量 $level%';
  }

  @override
  String get bluetoothConnectFailed => '無法連線。請讓手錶靠近手機後再試一次。';

  @override
  String get bluetoothDenied =>
      '未取得藍牙權限。請到手機「設定 > 應用程式」允許 Maternal 使用「鄰近裝置」，然後再試一次。';

  @override
  String get bluetoothFindWatch => '開啟藍牙並尋找我的手錶';

  @override
  String get bluetoothHasHeartRate => '可分享心率';

  @override
  String bluetoothHeartRate(int bpm) {
    return '每分鐘 $bpm 下';
  }

  @override
  String get bluetoothLost => '手錶已中斷連線。';

  @override
  String get bluetoothNoHeartRate =>
      '此裝置不會透過藍牙分享心率。許多手錶可在手錶設定中開啟「廣播心率」（HR broadcast）。';

  @override
  String get bluetoothNoneFound => '尚未找到裝置。';

  @override
  String get bluetoothOff => '藍牙已關閉。請開啟後再試一次。';

  @override
  String bluetoothReconnect(String name) {
    return '重新連線 $name';
  }

  @override
  String get bluetoothScanHelp => '請保持手錶開啟並靠近手機。可分享心率的裝置會排在最前面。';

  @override
  String get bluetoothTitle => '藍牙裝置';

  @override
  String get bluetoothUnsupported => '這部手機不支援低功耗藍牙。';

  @override
  String get bluetoothWaitingForReading => '等待讀數…';

  @override
  String get bluetoothWatchBody => '透過藍牙配對手錶或運動手環，心率數據會直接同步到您的健康紀錄。';

  @override
  String callDoctor(String name) {
    return '致電 $name';
  }

  @override
  String callEmergency(String number) {
    return '撥打 $number';
  }

  @override
  String callManually(String number) {
    return '無法開啟撥號程式，請撥打 $number。';
  }

  @override
  String calorieAnalysis(int days, String average, String percent) {
    return '在您記錄的 $days 天中，平均攝取 $average 大卡，約為目標的 $percent%。請向醫療團隊了解適合您的攝取量。';
  }

  @override
  String calorieAnalysisNoTarget(int days, String average) {
    return '在您記錄的 $days 天中，平均攝取 $average 大卡。';
  }

  @override
  String get calorieAnalysisTooFew => '至少記錄三天才能看到摘要。';

  @override
  String calorieChartSummary(int range, int logged) {
    return '過去 $range 天每日卡路里，其中 $logged 天有紀錄。';
  }

  @override
  String get calorieHistory => '紀錄';

  @override
  String get calorieNoData => '此期間沒有飲食紀錄。開始記錄飲食或連接您的手錶。';

  @override
  String get calorieNoTargetBody => '請新增出生日期、身高與體重，以查看每日目標估算。';

  @override
  String get calorieNoTargetTitle => '尚未有目標';

  @override
  String get calorieTarget => '每日目標';

  @override
  String get careTeamEmpty => '尚未連結任何醫生。';

  @override
  String get careTeamIntro => '這裡的醫生可以查看您分享的紀錄，您可隨時移除存取權。';

  @override
  String get chartBandNote => '陰影區為醫療團隊設定的一般範圍。';

  @override
  String chartSummary(String name, int count, String latest) {
    return '$name 圖表：共 $count 筆讀數，最新為 $latest。';
  }

  @override
  String get chartTargetLineNote => '虛線為您的每日目標。';

  @override
  String get clinicalSummary => '臨床摘要';

  @override
  String get colGestation => '孕週';

  @override
  String get colScan => '檢查';

  @override
  String get contentPendingReview => '此時間表為示範內容，尚待合格臨床人員依馬來西亞指引審核。請一律遵從您的醫療團隊。';

  @override
  String contentVersion(String version) {
    return '臨床內容版本 $version';
  }

  @override
  String get contractionAvgDuration => '平均長度';

  @override
  String get contractionAvgInterval => '平均間隔';

  @override
  String contractionDuration(String duration) {
    return '持續 $duration';
  }

  @override
  String get contractionEmpty => '您計時的宮縮會顯示在這裡。';

  @override
  String contractionGap(String gap) {
    return '距上一次 $gap';
  }

  @override
  String get contractionHistory => '紀錄';

  @override
  String contractionLastHour(int count) {
    return '過去一小時 $count 次宮縮';
  }

  @override
  String get contractionStart => '宮縮開始';

  @override
  String get contractionStop => '宮縮結束';

  @override
  String get contractionTapToStop => '結束時點一下';

  @override
  String get contractionTitle => '宮縮計時';

  @override
  String get contractionTooShort => '只有幾秒鐘，因此未儲存。';

  @override
  String get copied => '已複製';

  @override
  String get createAppointment => '預約';

  @override
  String get createAskAi => '問 AI';

  @override
  String get createContractions => '宮縮';

  @override
  String get createDocument => '文件';

  @override
  String get createFood => '飲食';

  @override
  String get createGroupCare => '照護';

  @override
  String get createGroupHealth => '健康';

  @override
  String get createGroupNutrition => '營養';

  @override
  String get createGroupPregnancy => '懷孕';

  @override
  String get createHealthLog => '健康紀錄';

  @override
  String get createKickCounter => '胎動計數';

  @override
  String get createMedication => '藥物';

  @override
  String get createMilestone => '里程碑';

  @override
  String get createPeriod => '月經';

  @override
  String get createSymptoms => '症狀';

  @override
  String get createTitle => '您想新增什麼？';

  @override
  String get createUltrasound => '超聲波結果';

  @override
  String get createVaccine => '疫苗';

  @override
  String get createWater => '飲水';

  @override
  String cycleAverageLength(int days) {
    return '週期約 $days 天';
  }

  @override
  String cycleBasedOnRecords(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '根據您記錄的 $count 次月經。每次新增紀錄都會更新之後幾個月的預測。',
    );
    return '$_temp0';
  }

  @override
  String get cycleBasedOnTypical => '依一般週期推算';

  @override
  String cycleDaysLate(int days) {
    return '比預期晚 $days 天';
  }

  @override
  String cycleFertileWindow(String start, String end) {
    return '估計易孕期：$start – $end';
  }

  @override
  String cycleInDays(int days) {
    return '$days 天後';
  }

  @override
  String get cycleIrregularWarning => '您的週期變化較大，因此估算可能較不準確。';

  @override
  String get cycleLogToday => '記錄月經';

  @override
  String get cycleNeedSecondPeriod => '目前以一般 28 天週期估算。記錄下一次月經後，預測就會依照您自己的週期。';

  @override
  String get cycleNextPeriod => '下次月經';

  @override
  String get cycleNoData => '請記錄月經的日子。記錄兩次月經後，我們就能估算下一次。';

  @override
  String get cycleNoEstimate => '記錄月經後即可看到估算。';

  @override
  String cycleOvulation(String date) {
    return '估計排卵日：$date';
  }

  @override
  String get cyclePausedInPregnancy => '懷孕期間暫停週期預測，您的月經紀錄會保留。';

  @override
  String cyclePeriodLength(int days) {
    return '經期約 $days 天';
  }

  @override
  String cycleShiftEarlier(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '您上次月經比預測早了 $days 天，因此之後的日期已更新。',
    );
    return '$_temp0';
  }

  @override
  String cycleShiftLater(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '您上次月經比預測晚了 $days 天，因此之後的日期已更新。',
    );
    return '$_temp0';
  }

  @override
  String get cycleStale => '預期月經已延遲超過一個週期。請記錄最近一次月經以更新估算。';

  @override
  String get cycleUpcomingTitle => '之後的月經（估計）';

  @override
  String get dayAppointments => '預約';

  @override
  String get dayHealthLogs => '健康紀錄';

  @override
  String get dayNotes => '備註';

  @override
  String get dayPeriod => '月經';

  @override
  String get daySymptoms => '症狀';

  @override
  String daysPastDue(int days) {
    return '已過預產期 $days 天';
  }

  @override
  String daysToGo(int days) {
    return '還有 $days 天';
  }

  @override
  String deliveredConfirmBody(String date) {
    return '我們會在 $date 結束本次懷孕並開始產後照護，您的懷孕紀錄會保留在歷史中。';
  }

  @override
  String get deliveredConfirmTitle => '恭喜您！';

  @override
  String deliveredOn(String date) {
    return '於 $date 分娩';
  }

  @override
  String get deliveredSaved => '已開始產後照護。';

  @override
  String get demoModeBody => '您正在查看明確標示的示範資料。資料不會傳送到伺服器，重新啟動應用程式後紀錄會重設。';

  @override
  String get demoModeTitle => '示範模式';

  @override
  String get demoUseCyclePatient => 'Aina（經期）';

  @override
  String get demoUseDoctor => 'Dr. Chua（醫生）';

  @override
  String get demoUsePatient => 'Gwen（懷孕中）';

  @override
  String get devicesTitle => '已連接裝置';

  @override
  String get disclaimer => '本應用程式輔助但不取代醫生的照護，亦不作診斷。臨床內容仍待合格臨床人員審核。';

  @override
  String get docBloodTest => '血液檢查';

  @override
  String get docHospital => '醫院文件';

  @override
  String get docOther => '其他';

  @override
  String get docPrescription => '處方';

  @override
  String get docUltrasound => '超聲波';

  @override
  String get docVaccination => '疫苗紀錄';

  @override
  String doctorGreeting(String name) {
    return '$name，您好';
  }

  @override
  String get doctorNavDashboard => '總覽';

  @override
  String get doctorNavPatients => '病人';

  @override
  String get doctorPendingBody => '管理員正在核實您的 MMC 註冊。核准後您即可查看已連結的病人。';

  @override
  String get doctorPendingTitle => '等待核實';

  @override
  String get documentSearchEmpty => '沒有相符的文件。';

  @override
  String get documentSearchHint => '搜尋文件標題與內容';

  @override
  String get documentStorageNote =>
      '在此示範版本中，檔案只會留在您的手機。正式版本會加密並私密儲存，只有已連結的醫生能開啟。';

  @override
  String get documentsEmpty => '尚無文件。';

  @override
  String get documentsTitle => '醫療文件';

  @override
  String dueDateGaPreview(String ga) {
    return '即您今天懷孕 $ga。';
  }

  @override
  String get dueDateHelper => '依醫生或超聲波報告填寫。';

  @override
  String dueDateInvalidBody(String date) {
    return '已儲存的預產期（$date）不符合進行中的懷孕，因此暫不顯示週數或倒數。';
  }

  @override
  String get dueDateInvalidTitle => '請檢查您的預產期';

  @override
  String get dueDateTooFarFuture => '此日期距今超過 40 週，請檢查。';

  @override
  String get dueDateTooFarPast => '此日期距今太久，不符合進行中的懷孕，請檢查。';

  @override
  String dueOn(String date) {
    return '預產期 $date';
  }

  @override
  String emergencyNumberNote(String number) {
    return '在馬來西亞遇到緊急情況，請撥打 $number。';
  }

  @override
  String get errorEnterNumber => '請輸入數字。';

  @override
  String errorOutOfRange(String min, String max) {
    return '請輸入介於 $min 至 $max 之間的數值。';
  }

  @override
  String get errorRequired => '請填寫此欄。';

  @override
  String get estimateLabel => '估算';

  @override
  String get fetalAc => '腹圍';

  @override
  String get fetalAfi => '羊水指數';

  @override
  String get fetalBpd => '雙頂徑';

  @override
  String get fetalCrl => '頭臀長';

  @override
  String get fetalEfw => '估計胎兒體重';

  @override
  String get fetalFhr => '胎兒心率';

  @override
  String get fetalFl => '股骨長';

  @override
  String get fetalHc => '頭圍';

  @override
  String get fetalNt => '頸部透明帶';

  @override
  String get fieldActivityLevel => '活動量';

  @override
  String get fieldAllergies => '過敏';

  @override
  String get fieldBloodGroup => '血型';

  @override
  String get fieldCalories => '卡路里';

  @override
  String get fieldCategory => '類別';

  @override
  String get fieldClinic => '診所或醫院';

  @override
  String get fieldClinicHospital => '診所或醫院';

  @override
  String get fieldDate => '日期';

  @override
  String get fieldDateOfBirth => '出生日期';

  @override
  String get fieldDescription => '說明';

  @override
  String get fieldDiastolic => '舒張壓（下）';

  @override
  String get fieldDoctor => '醫生';

  @override
  String get fieldDocumentDate => '文件日期';

  @override
  String get fieldDueDate => '預產期';

  @override
  String get fieldEmail => '電郵';

  @override
  String get fieldFlow => '經量';

  @override
  String get fieldFoodName => '食物或飲品';

  @override
  String get fieldFullName => '全名';

  @override
  String get fieldGlucoseContext => '何時測量？';

  @override
  String get fieldHeight => '身高';

  @override
  String get fieldMeal => '餐別';

  @override
  String get fieldMeasurement => '您要記錄什麼？';

  @override
  String get fieldMedicalHistory => '病史';

  @override
  String get fieldMilestone => '里程碑';

  @override
  String get fieldMmcHelper => '在您查看病人資料前，管理員會先核實。';

  @override
  String get fieldMmcNumber => 'MMC 註冊號碼';

  @override
  String get fieldNote => '備註';

  @override
  String get fieldNotesOptional => '備註（選填）';

  @override
  String get fieldNumberOfBabies => '胎兒數目';

  @override
  String get fieldOtp => '一次性驗證碼';

  @override
  String get fieldPhone => '手機號碼';

  @override
  String get fieldPortion => '份量';

  @override
  String get fieldPrePregnancyWeight => '懷孕前體重';

  @override
  String get fieldPreferredLanguage => '偏好語言';

  @override
  String get fieldPurpose => '目的';

  @override
  String get fieldScanType => '檢查類型';

  @override
  String get fieldSeverity => '程度如何？';

  @override
  String get fieldSystolic => '收縮壓（上）';

  @override
  String get fieldTime => '時間';

  @override
  String get fieldTitle => '標題';

  @override
  String get filterPending => '申請中';

  @override
  String get flowHeavy => '大量';

  @override
  String get flowLight => '少量';

  @override
  String get flowMedium => '中量';

  @override
  String get flowNone => '無';

  @override
  String get flowSpotting => '點狀出血';

  @override
  String gaWeeksDays(int weeks, int days) {
    return '$weeks 週 $days 天';
  }

  @override
  String get glucoseAfterMeal => '餐後';

  @override
  String get glucoseFasting => '空腹';

  @override
  String get glucoseRandom => '其他時間';

  @override
  String get googleConsentAllow => '允許並繼續';

  @override
  String get googleConsentBody =>
      'Maternal 會將以下資料從您的 Google 帳戶複製到個人檔案。您之後可在「個人資料」中修改。';

  @override
  String get googleConsentManual => '我自行輸入資料';

  @override
  String get googleConsentTitle => '使用您的 Google 資料？';

  @override
  String get googleContinue => '使用 Google 繼續';

  @override
  String googleFailed(String detail) {
    return 'Google 登入失敗：$detail';
  }

  @override
  String get googleNotSetUp => '此版本尚未設定 Google 登入，請使用電郵。';

  @override
  String get googlePhoto => '個人照片';

  @override
  String get googlePhotoValue => '您的 Google 照片';

  @override
  String get gravidaPara => '孕次／產次';

  @override
  String get growthCompareScans => '比較檢查結果';

  @override
  String get growthNoScans => '尚未記錄任何超聲波檢查。';

  @override
  String get healthConnectBody => '匯入手機或手錶已記錄的步數、心率、睡眠等資料。';

  @override
  String get healthConnectDemoNote =>
      '下方的 Health Connect 在此版本仍使用示範數據；上方的藍牙為真實連線。';

  @override
  String get healthConnectRationale => '我們只會在您同意後讀取您允許的資料類型，您可隨時中斷連接。';

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String homeGreeting(String name) {
    return '$name，您好';
  }

  @override
  String get homeNextAppointment => '即將到來的預約';

  @override
  String get homeRecentActivity => '最新健康紀錄';

  @override
  String get homeTabBaby => '寶寶';

  @override
  String get homeTabMother => '媽媽';

  @override
  String get homeTodaysHealth => '今日健康';

  @override
  String get homeTodaysTasks => '今日待辦';

  @override
  String get intimacyPrivateNote => '私密：除非您在「私隱」中選擇分享，否則只有您能看到。';

  @override
  String get journeyGeneral => '婦女健康';

  @override
  String get journeyPostpartum => '產後';

  @override
  String get journeyPregnancy => '懷孕中';

  @override
  String get kcalBurntNotConnected => '消耗卡路里：請連接手錶或 Health Connect';

  @override
  String get kcalConsumed => '已攝取';

  @override
  String kcalOver(String kcal) {
    return '超出目標 $kcal 大卡';
  }

  @override
  String kcalRemaining(String kcal) {
    return '還剩 $kcal 大卡';
  }

  @override
  String get kickCounterTitle => '胎動計數';

  @override
  String get kickGuarded => '已視為與上一次點按相同的胎動。';

  @override
  String get kickTapButton => '每次胎動點一下';

  @override
  String kicksChartSummary(int count) {
    return '今天每小時胎動長條圖，共 $count 次。';
  }

  @override
  String kicksCount(int count) {
    return '$count 次';
  }

  @override
  String get kicksPastDays => '前幾天';

  @override
  String get kicksPerHourTitle => '今天每小時胎動次數';

  @override
  String kicksTodayCount(int count) {
    return '今天 $count 次胎動';
  }

  @override
  String get languageSwitchLabel => '應用程式語言';

  @override
  String lastKickAt(String time) {
    return '上一次胎動：$time';
  }

  @override
  String lastNDays(int days) {
    return '$days 天';
  }

  @override
  String get legendAppointment => '預約';

  @override
  String get legendFertile => '易孕期（估算）';

  @override
  String get legendLogged => '健康紀錄';

  @override
  String get legendMedication => '已服藥';

  @override
  String get legendPeriod => '月經';

  @override
  String get legendPredicted => '預測月經';

  @override
  String get linkActive => '可查看您分享的紀錄';

  @override
  String get linkPending => '等待醫生接受';

  @override
  String get loginChangeIdentifier => '使用其他電郵';

  @override
  String get loginIntro => '請輸入您的電郵，我們會寄送一次性驗證碼。';

  @override
  String get loginRecoveryHint => '無法在此電郵收到驗證碼？請聯絡您的診所以恢復帳戶。';

  @override
  String get loginTitle => '登入';

  @override
  String get macroCarbs => '碳水化合物';

  @override
  String get macroFat => '脂肪';

  @override
  String get macroProtein => '蛋白質';

  @override
  String macroSummary(String protein, String carbs, String fat) {
    return '蛋白質 $protein g · 碳水 $carbs g · 脂肪 $fat g';
  }

  @override
  String get mealBreakfast => '早餐';

  @override
  String get mealDinner => '晚餐';

  @override
  String get mealDrinks => '飲品';

  @override
  String get mealLunch => '午餐';

  @override
  String get mealSnacks => '點心';

  @override
  String get medicationSafetyNote => '請只依醫生處方新增藥物。此清單僅作提醒，並非醫療建議。';

  @override
  String get medicationsNoneToday => '今天沒有排定的藥物。';

  @override
  String get medicationsTitle => '藥物';

  @override
  String get medicationsToday => '今天';

  @override
  String get menuAbout => '關於';

  @override
  String get menuAppearance => '外觀';

  @override
  String get menuCareTeam => '我的醫療團隊';

  @override
  String get menuEmergencyContact => '緊急聯絡人';

  @override
  String get menuNotifications => '通知';

  @override
  String get menuPersonalInfo => '個人資料';

  @override
  String get menuPregnancyInfo => '懷孕資料';

  @override
  String get menuPrivacy => '私隱與資料';

  @override
  String get milestoneHint => '例如：第一次感覺到胎動';

  @override
  String get moodGood => '好';

  @override
  String get moodGreat => '很好';

  @override
  String get moodLow => '差';

  @override
  String get moodOkay => '普通';

  @override
  String get moodVeryLow => '很差';

  @override
  String get navCalendar => '行事曆';

  @override
  String get navCalories => '卡路里';

  @override
  String get navCreate => '新增';

  @override
  String get navHome => '首頁';

  @override
  String get navProfile => '個人';

  @override
  String get noData => '尚無資料';

  @override
  String get noDataTapToAdd => '尚無資料，點按以新增。';

  @override
  String get noReadingsInPeriod => '此期間沒有讀數。';

  @override
  String get noReadingsYet => '尚無讀數。';

  @override
  String get nothingLogged => '沒有紀錄。';

  @override
  String get notifAppointments => '預約';

  @override
  String get notifDoctorMessages => '醫生的訊息';

  @override
  String get notifHealthLogs => '健康紀錄提醒';

  @override
  String get notifLockScreenDetails => '在鎖定畫面顯示詳情';

  @override
  String get notifLockScreenHelp => '預設關閉以保護您的私隱。';

  @override
  String get notifMedication => '藥物';

  @override
  String get notifMilestones => '孕期里程碑';

  @override
  String get notifVaccines => '疫苗';

  @override
  String get notificationsRationale => '我們會使用通知提醒您預約、健康紀錄及重要的孕期里程碑。';

  @override
  String get obsActivity => '步數';

  @override
  String get obsBloodGlucose => '血糖';

  @override
  String get obsBloodPressure => '血壓';

  @override
  String get obsHeartRate => '心率';

  @override
  String get obsMood => '心情';

  @override
  String get obsSleep => '睡眠';

  @override
  String get obsSpo2 => '血氧（SpO2）';

  @override
  String get obsTemperature => '體溫';

  @override
  String get obsWater => '飲水';

  @override
  String get obsWeight => '體重';

  @override
  String get onboardingBodySubtitle => '用於體重與卡路里估算，之後可以修改。';

  @override
  String get onboardingBodyTitle => '您的身體資料';

  @override
  String onboardingDemoCode(String code) {
    return '示範版本：請使用驗證碼 $code。';
  }

  @override
  String get onboardingDoctorDoneSubtitle => '管理員核實您的註冊後，您才能查看病人資料。';

  @override
  String get onboardingDoctorDoneTitle => '快完成了';

  @override
  String get onboardingDoneSubtitle => '從現在起，您記錄的一切都會集中保存。';

  @override
  String get onboardingDoneTitle => '您的個人資料已完成';

  @override
  String get onboardingNotPregnantInfo => '我們會為您設定月經週期追蹤與一般婦女健康。之後可在個人頁面新增懷孕。';

  @override
  String get onboardingPersonalSubtitle => '這有助我們為您提供個人化照護。';

  @override
  String get onboardingPersonalTitle => '關於您';

  @override
  String get onboardingPregnancySubtitle => '這會影響您的首頁內容，隨時可以更改。';

  @override
  String get onboardingPregnancyTitle => '您目前懷孕嗎？';

  @override
  String get onboardingRoleSubtitle => '請選擇一項。您只能查看您角色允許的內容。';

  @override
  String get onboardingRoleTitle => '誰會使用此應用程式？';

  @override
  String onboardingStepOf(int current, int total) {
    return '第 $current 步，共 $total 步';
  }

  @override
  String get onboardingVerifySubtitle => '請輸入電郵，我們會寄送一次性驗證碼。';

  @override
  String get onboardingVerifyTitle => '驗證您的帳戶';

  @override
  String get otpExpired => '此驗證碼已失效，請重新寄送。';

  @override
  String otpExpiresIn(String time) {
    return '驗證碼將於 $time 後失效';
  }

  @override
  String get otpResend => '重新寄送';

  @override
  String otpSentTo(String destination) {
    return '驗證碼已傳送至 $destination';
  }

  @override
  String get outsideRangeBody =>
      '您的讀數已儲存，但超出醫療團隊設定的一般範圍。如感到不適或出現警示徵兆，請聯絡您的醫療團隊。這並非診斷。';

  @override
  String get outsideRangeTitle => '讀數超出一般範圍';

  @override
  String get painMild => '輕微';

  @override
  String get painModerate => '中等';

  @override
  String get painSevere => '嚴重';

  @override
  String get past => '過去';

  @override
  String get patientId => '病人編號';

  @override
  String get patientSearchEmpty => '沒有相符的病人。';

  @override
  String get patientSearchHint => '搜尋姓名、編號、電話或預產期';

  @override
  String percentileFromReport(String value) {
    return '第 $value 百分位（報告所載）';
  }

  @override
  String get periodDayTitle => '月經與週期紀錄';

  @override
  String get permissionsBody =>
      '應用程式只會在您首次使用相關功能時，才要求通知、藍牙、相機或相片權限。您可隨時在手機設定中更改。';

  @override
  String get permissionsTitle => '權限';

  @override
  String get photoChange => '更換個人照片';

  @override
  String get photoChoose => '從相簿選擇';

  @override
  String get photoRemove => '移除照片';

  @override
  String get photoSaved => '已更新個人照片';

  @override
  String get portionHint => '例如：1 盤、250 毫升';

  @override
  String postpartumSince(int weeks, int days) {
    return '產後 $weeks 週 $days 天';
  }

  @override
  String get pregnancyStartInfo => '儲存後會在您的紀錄中開始新的懷孕，先前的紀錄會保留。';

  @override
  String get privacyIntro => '您的健康紀錄屬於您。只有您連結的醫生能查看，而且只限您選擇分享的部分。';

  @override
  String get purposeHint => '例如：產檢';

  @override
  String get rangeAbove => '高於範圍';

  @override
  String get rangeBelow => '低於範圍';

  @override
  String get rangeWithin => '在範圍內';

  @override
  String get readingsTitle => '讀數';

  @override
  String get recentFoods => '最近的飲食';

  @override
  String reminderAppointmentToday(String purpose, String time) {
    return '您的預約（$purpose）在今天 $time。';
  }

  @override
  String reminderAppointmentTomorrow(String purpose, String time) {
    return '您的預約（$purpose）在明天 $time。';
  }

  @override
  String get reminderLogBloodPressure => '記得記錄今天的血壓。';

  @override
  String reminderMedication(int count) {
    return '今天還有 $count 劑藥物要服用。';
  }

  @override
  String reminderVaccineDue(String name) {
    return '您的下一劑疫苗可能到期：$name。請向醫療團隊確認。';
  }

  @override
  String get remindersEmpty => '目前沒有提醒。';

  @override
  String get remindersPushNote => '手機通知只會使用一般字句，例如「您有新的提醒」，健康細節不會顯示在鎖定畫面上。';

  @override
  String get remindersTitle => '提醒';

  @override
  String get riskFactors => '風險因素';

  @override
  String get roleDoctor => '醫生／管理員';

  @override
  String get roleDoctorHint => '通過驗證後查看您的病人';

  @override
  String get rolePatient => '病人';

  @override
  String get rolePatientHint => '記錄懷孕、週期與健康';

  @override
  String get savedMessage => '已儲存';

  @override
  String get scanTypeDefault => '超聲波';

  @override
  String get scanTypeHint => '例如：生長評估';

  @override
  String get scanning => '搜尋中…';

  @override
  String get securityTitle => '登入與安全';

  @override
  String get shareCycle => '月經與週期';

  @override
  String get shareDocuments => '醫療文件';

  @override
  String get shareIntimacy => '性行為紀錄';

  @override
  String get shareNutrition => '飲食與卡路里';

  @override
  String get sharePregnancy => '懷孕與超聲波';

  @override
  String get shareVitals => '健康紀錄與生命徵象';

  @override
  String get sharingTitle => '與我的醫生分享';

  @override
  String get signOutConfirm => '要從此裝置登出嗎？';

  @override
  String get ssoOr => '或';

  @override
  String get statAlerts => '待查看警示';

  @override
  String get statAverage => '平均';

  @override
  String get statHighest => '最高';

  @override
  String get statLowest => '最低';

  @override
  String get statNewRequests => '新病人申請';

  @override
  String get statTodaysAppointments => '今日預約';

  @override
  String get statTotalPatients => '病人';

  @override
  String get statusConnected => '已連接';

  @override
  String get statusNotConnected => '未連接';

  @override
  String get symptomLogged => '症狀';

  @override
  String get symptomsEmpty => '沒有症狀紀錄。';

  @override
  String get symptomsHistoryTitle => '最近的症狀';

  @override
  String get symptomsLogTitle => '記錄症狀';

  @override
  String get symptomsTitle => '症狀';

  @override
  String syncedReadings(int count) {
    return '已同步 $count 筆讀數';
  }

  @override
  String get tabCycle => '月經週期';

  @override
  String get tabGrowth => '生長';

  @override
  String get tabPregnancyTimeline => '懷孕';

  @override
  String get tabSummary => '摘要';

  @override
  String get tabTimeline => '時間軸';

  @override
  String get tabVitals => '生命徵象';

  @override
  String get targetSetByClinician => '由醫療團隊設定';

  @override
  String get taskCountKicks => '記錄胎動';

  @override
  String get taskDone => '已完成';

  @override
  String get taskDrinkWater => '喝水';

  @override
  String get taskNotDone => '未完成';

  @override
  String taskTakeMedication(String name, String dose) {
    return '服用 $name $dose';
  }

  @override
  String get timelineDueDate => '預產期';

  @override
  String get timelineStart => '懷孕起算日';

  @override
  String timelineTrimesterStarts(String name) {
    return '$name開始';
  }

  @override
  String get today => '今天';

  @override
  String get totpBody =>
      '使用 Google Authenticator、Microsoft Authenticator 或類似應用程式的 6 位數驗證碼登入，無需電郵或網絡。';

  @override
  String get totpCodeLabel => '驗證器代碼';

  @override
  String get totpEnable => '驗證並開啟';

  @override
  String get totpKeyLabel => '設定金鑰';

  @override
  String get totpNoApp => '找不到驗證器應用程式。請安裝 Google Authenticator 後再試，或輸入設定金鑰。';

  @override
  String get totpOn => '驗證器應用程式已開啟。登入時請輸入它顯示的代碼。';

  @override
  String get totpOpenApp => '開啟驗證器應用程式';

  @override
  String get totpSetup => '設定驗證器應用程式';

  @override
  String get totpStep1 => '1. 點「開啟驗證器應用程式」，或用另一部手機掃描此 QR 碼，或在應用程式中輸入設定金鑰。';

  @override
  String get totpStep2 => '2. 輸入應用程式顯示的 6 位數代碼。';

  @override
  String get totpTitle => '驗證器應用程式';

  @override
  String get totpTurnOff => '關閉';

  @override
  String get trimesterFirst => '第一孕期';

  @override
  String get trimesterLabel => '孕期';

  @override
  String get trimesterSecond => '第二孕期';

  @override
  String get trimesterThird => '第三孕期';

  @override
  String get ultrasoundCopyHint => '請依超聲波報告填寫數值，報告沒有的項目請留空。';

  @override
  String get ultrasoundNeedOneValue => '請至少輸入一項測量值。';

  @override
  String get unitBpm => '次/分';

  @override
  String get unitHours => '小時';

  @override
  String get unitSteps => '步';

  @override
  String get unitWeeksShort => '週';

  @override
  String get upcoming => '即將到來';

  @override
  String uploadedBy(String name) {
    return '由 $name 新增';
  }

  @override
  String vaccinationPurpose(String name) {
    return '疫苗接種：$name';
  }

  @override
  String get vaccineAlreadyHad => '我已接種 – 記錄下來';

  @override
  String get vaccineBook => '預約接種疫苗';

  @override
  String get vaccineBookHint => '請先勾選上方方框再預約。';

  @override
  String get vaccineConfirmRead => '我已閱讀此疫苗的作用及價格。';

  @override
  String get vaccineDemoPrice => '示範價格，僅供參考。';

  @override
  String get vaccineDoctorConfirms => '醫生會在預約時確認此疫苗是否適合您。';

  @override
  String get vaccineDueNow => '現在可接種';

  @override
  String get vaccineGiven => '已接種';

  @override
  String vaccineGivenOn(String date) {
    return '$date 已接種';
  }

  @override
  String get vaccineHistory => '疫苗接種紀錄';

  @override
  String get vaccineHistoryEmpty => '沒有疫苗接種紀錄。';

  @override
  String get vaccineNoDescription => '診所尚未加入說明。';

  @override
  String get vaccinePending => '待接種';

  @override
  String vaccinePriceAt(String clinic) {
    return '於 $clinic';
  }

  @override
  String get vaccinePriceLabel => '價格';

  @override
  String get vaccinePriceUnknown => '請向診所查詢價格。';

  @override
  String get vaccineTapForDetails => '詳情與價格';

  @override
  String get vaccineWhatItDoes => '疫苗作用';

  @override
  String get vaccineWhen => '接種時間';

  @override
  String get vaccinesTitle => '疫苗';

  @override
  String get verificationStatus => '核實狀態';

  @override
  String get verified => '已核實';

  @override
  String versionLabel(String version) {
    return '版本 $version';
  }

  @override
  String get warningSignLogNow => '我現在有此情況 — 記錄';

  @override
  String get warningSignsIntro => '如出現以下任何情況，請立即求助，不要等到下次預約。';

  @override
  String get warningSignsTitle => '警示徵兆';

  @override
  String waterTodayMl(String amount) {
    return '今天 $amount 毫升';
  }

  @override
  String get welcomeCreateAccount => '建立帳戶';

  @override
  String welcomeDemoHint(String code) {
    return '示範版本：使用 demo.patient@example.com（Gwen，懷孕中）、demo.cycle@example.com（Aina，經期追蹤）或 demo.doctor@example.com 登入，驗證碼 $code。重新啟動應用程式後，示範資料會重設。';
  }

  @override
  String get welcomeSignIn => '我已有帳戶';

  @override
  String get welcomeTagline => '您的懷孕、月經週期與婦女健康紀錄，與您的醫療團隊共享。';

  @override
  String get yourDoctors => '您的醫生';
}
