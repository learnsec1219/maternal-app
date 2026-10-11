// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get aboutRegulatory =>
      'Binaan pembangunan untuk reka bentuk aliran kerja klinikal. Bukan peranti perubatan berdaftar di bawah Akta Peranti Perubatan 2012 (Akta 737).';

  @override
  String get accessLogExplainer =>
      'Setiap kali anda membuka rekod pesakit, ia direkodkan. Pesakit dan pentadbir boleh menyemaknya.';

  @override
  String get accessLogTitle => 'Log akses saya';

  @override
  String accessLogViewed(String id) {
    return 'Melihat rekod $id';
  }

  @override
  String get actionAccept => 'Terima';

  @override
  String get actionAdd => 'Tambah';

  @override
  String get actionBabyDelivered => 'Bayi telah lahir';

  @override
  String get actionBack => 'Kembali';

  @override
  String get actionCancel => 'Batal';

  @override
  String get actionConfirm => 'Sahkan';

  @override
  String get actionConnect => 'Sambung';

  @override
  String get actionContinue => 'Teruskan';

  @override
  String get actionCopy => 'Salin';

  @override
  String get actionDecline => 'Tolak';

  @override
  String get actionDecrease => 'Kurangkan';

  @override
  String get actionDisconnect => 'Putuskan';

  @override
  String get actionEndPostpartum => 'Beralih ke penjagaan umum';

  @override
  String get actionFinish => 'Selesai';

  @override
  String get actionGoHome => 'Pergi ke Utama';

  @override
  String get actionImPregnant => 'Saya hamil';

  @override
  String get actionIncrease => 'Tambah';

  @override
  String get actionNextDay => 'Hari berikutnya';

  @override
  String get actionNextMonth => 'Bulan berikutnya';

  @override
  String get actionNotNow => 'Bukan sekarang';

  @override
  String get actionOk => 'OK';

  @override
  String get actionPreviousDay => 'Hari sebelumnya';

  @override
  String get actionPreviousMonth => 'Bulan sebelumnya';

  @override
  String get actionRetry => 'Cuba lagi';

  @override
  String get actionSave => 'Simpan';

  @override
  String get actionScan => 'Imbas peranti';

  @override
  String get actionSendCode => 'Hantar kod';

  @override
  String get actionSignOut => 'Log keluar';

  @override
  String get actionToday => 'Kembali ke hari ini';

  @override
  String get actionUnderstood => 'Saya faham';

  @override
  String get actionUndoLast => 'Buat asal yang terakhir';

  @override
  String get actionVerify => 'Sahkan';

  @override
  String get activityActive => 'Sangat aktif';

  @override
  String get activityEmpty => 'Rekod terkini anda akan dipaparkan di sini.';

  @override
  String get activityLight => 'Aktif ringan';

  @override
  String get activityModerate => 'Aktif sederhana';

  @override
  String get activitySedentary => 'Kebanyakannya duduk';

  @override
  String get addAppointmentTitle => 'Tambah temu janji';

  @override
  String get addDocumentTitle => 'Tambah dokumen';

  @override
  String get addFoodTitle => 'Tambah makanan';

  @override
  String get addHealthLogTitle => 'Tambah log kesihatan';

  @override
  String get addMilestoneTitle => 'Tambah pencapaian';

  @override
  String get addNoteTitle => 'Tambah nota';

  @override
  String get addUltrasoundTitle => 'Tambah keputusan imbasan';

  @override
  String ageYears(int age) {
    return '$age tahun';
  }

  @override
  String alertCount(int count) {
    return '$count amaran';
  }

  @override
  String alertWarningSign(String name) {
    return 'Tanda amaran: $name';
  }

  @override
  String alertsExplainer(int days) {
    return 'Bacaan di luar julat yang ditetapkan dan tanda amaran yang direkodkan dalam $days hari lepas.';
  }

  @override
  String get alertsNone => 'Tiada apa-apa perlu disemak buat masa ini.';

  @override
  String get alertsToReview => 'Amaran untuk disemak';

  @override
  String get answerNo => 'Tidak';

  @override
  String get answerYes => 'Ya';

  @override
  String get appName => 'Maternal Care';

  @override
  String get appearanceDark => 'Gelap';

  @override
  String get appearanceExplainer =>
      'Mod cerah ialah tetapan asal. Pilih Gelap untuk waktu malam, atau ikut tetapan telefon anda.';

  @override
  String get appearanceLight => 'Cerah';

  @override
  String get appearanceSystem => 'Ikut telefon';

  @override
  String get appointmentDefaultPurpose => 'Temu janji';

  @override
  String get appointmentsNoneToday => 'Tiada temu janji hari ini.';

  @override
  String get appointmentsNoneUpcoming => 'Tiada temu janji akan datang.';

  @override
  String get appointmentsTitle => 'Temu janji';

  @override
  String get assistantBadKey =>
      'Perkhidmatan AI menolak kunci API Gemini. Semak kunci di Profil > Sambungan.';

  @override
  String get assistantBlocked =>
      'Perkhidmatan AI tidak menjawab soalan ini. Sila tanya dengan cara lain.';

  @override
  String get assistantEducational => 'Maklumat pendidikan';

  @override
  String get assistantFailed =>
      'Jawapan tidak dapat dimuatkan. Sila cuba lagi.';

  @override
  String get assistantHomeHint =>
      'AI menjawab dalam English, BM, 中文 atau தமிழ். Pendidikan, bukan diagnosis.';

  @override
  String get assistantInputHint => 'Taip soalan anda';

  @override
  String get assistantLanguage => 'Jawab dalam';

  @override
  String get assistantNetwork =>
      'Tidak dapat menghubungi perkhidmatan AI. Semak sambungan internet anda dan cuba lagi.';

  @override
  String get assistantNewChat => 'Perbualan baharu';

  @override
  String get assistantNotConfigured =>
      'Pembantu AI memerlukan kunci API Gemini sebelum boleh menjawab. Tambahkannya di Profil > Sambungan, atau minta pentadbir aplikasi memasukkannya ke dalam aplikasi.';

  @override
  String get assistantSend => 'Hantar';

  @override
  String get assistantThinking => 'Sedang berfikir...';

  @override
  String get assistantTitle => 'Tanya soalan';

  @override
  String get assistantUseDetails => 'Guna butiran kehamilan saya';

  @override
  String get assistantUseDetailsHelp =>
      'Mati: tiada maklumat rekod dihantar. Hidup: hanya peringkat anda (contohnya 32 minggu) dikongsi, bukan nama anda.';

  @override
  String atGestation(String ga) {
    return 'pada $ga';
  }

  @override
  String get authAuthenticatorHelp =>
      'Masukkan kod 6 digit yang dipaparkan oleh aplikasi pengesah anda untuk Maternal.';

  @override
  String get authEmailNotSetUp =>
      'Kod e-mel sebenar belum disediakan (Sambungan).';

  @override
  String get authInvalidCode =>
      'Kod itu tidak betul. Sila semak dan cuba lagi.';

  @override
  String get authInvalidIdentifier =>
      'Sila masukkan nombor telefon atau e-mel yang sah.';

  @override
  String get authNoAccountYet =>
      'Disahkan. Belum ada akaun, jadi mari kita cipta satu.';

  @override
  String get authSendCodeInstead => 'Hantar kod melalui SMS atau e-mel';

  @override
  String authSendFailed(String reason) {
    return 'Tidak dapat menghantar atau menyemak kod. $reason';
  }

  @override
  String get authSmsNotSetUp =>
      'Nombor telefon menggunakan kod demo dalam binaan ini. Kod sebenar dihantar melalui e-mel.';

  @override
  String get babiesMore => 'Lebih';

  @override
  String get babiesSingle => 'Tunggal';

  @override
  String get babiesTriplets => 'Kembar tiga';

  @override
  String get babiesTwins => 'Kembar dua';

  @override
  String get babyParameters => 'Ukuran bayi';

  @override
  String bluetoothBattery(int level) {
    return 'Bateri $level%';
  }

  @override
  String get bluetoothConnectFailed =>
      'Tidak dapat bersambung. Letakkan jam dekat dengan telefon dan cuba lagi.';

  @override
  String get bluetoothDenied =>
      'Kebenaran Bluetooth tidak diberikan. Benarkan \"Peranti berdekatan\" untuk Maternal di Tetapan > Aplikasi telefon anda, kemudian cuba lagi.';

  @override
  String get bluetoothFindWatch => 'Hidupkan Bluetooth dan cari jam saya';

  @override
  String get bluetoothHasHeartRate => 'Berkongsi kadar denyutan jantung';

  @override
  String bluetoothHeartRate(int bpm) {
    return '$bpm bpm';
  }

  @override
  String get bluetoothLost => 'Jam tangan terputus sambungan.';

  @override
  String get bluetoothNoHeartRate =>
      'Peranti ini tidak berkongsi kadar denyutan jantung melalui Bluetooth. Pada banyak jam tangan, anda boleh menghidupkan \"Broadcast heart rate\" dalam tetapan jam.';

  @override
  String get bluetoothNoneFound => 'Belum ada peranti ditemui.';

  @override
  String get bluetoothOff => 'Bluetooth dimatikan. Hidupkannya dan cuba lagi.';

  @override
  String bluetoothReconnect(String name) {
    return 'Sambung semula $name';
  }

  @override
  String get bluetoothScanHelp =>
      'Pastikan jam tangan aktif dan dekat dengan telefon. Peranti yang berkongsi kadar denyutan jantung disenaraikan dahulu.';

  @override
  String get bluetoothTitle => 'Peranti Bluetooth';

  @override
  String get bluetoothUnsupported =>
      'Telefon ini tidak menyokong Bluetooth Low Energy.';

  @override
  String get bluetoothWaitingForReading => 'Menunggu bacaan…';

  @override
  String get bluetoothWatchBody =>
      'Pasangkan jam tangan atau gelang kecergasan melalui Bluetooth. Bacaan kadar denyutan jantung terus disegerakkan ke Log kesihatan anda.';

  @override
  String callDoctor(String name) {
    return 'Hubungi $name';
  }

  @override
  String callEmergency(String number) {
    return 'Hubungi $number';
  }

  @override
  String callManually(String number) {
    return 'Tidak dapat membuka pendail. Sila hubungi $number.';
  }

  @override
  String calorieAnalysis(int days, String average, String percent) {
    return 'Pada $days hari yang anda rekodkan, purata pengambilan anda ialah $average kcal, kira-kira $percent% daripada sasaran. Tanya pasukan penjagaan anda apa yang sesuai untuk anda.';
  }

  @override
  String calorieAnalysisNoTarget(int days, String average) {
    return 'Pada $days hari yang anda rekodkan, purata pengambilan anda ialah $average kcal.';
  }

  @override
  String get calorieAnalysisTooFew =>
      'Rekod sekurang-kurangnya tiga hari untuk melihat ringkasan.';

  @override
  String calorieChartSummary(int range, int logged) {
    return 'Kalori sehari bagi $range hari lepas; $logged hari direkodkan.';
  }

  @override
  String get calorieHistory => 'Sejarah';

  @override
  String get calorieNoData =>
      'Tiada makanan direkodkan dalam tempoh ini. Mula merekod makanan atau sambungkan jam tangan anda.';

  @override
  String get calorieNoTargetBody =>
      'Tambah tarikh lahir, tinggi dan berat anda untuk melihat anggaran sasaran harian.';

  @override
  String get calorieNoTargetTitle => 'Belum ada sasaran';

  @override
  String get calorieTarget => 'Sasaran harian';

  @override
  String get careTeamEmpty => 'Belum ada doktor dipautkan.';

  @override
  String get careTeamIntro =>
      'Doktor di sini boleh melihat rekod yang anda kongsi. Tarik balik akses bila-bila masa.';

  @override
  String get channelEmail => 'E-mel';

  @override
  String get channelPhone => 'Telefon';

  @override
  String get chartBandNote =>
      'Jalur berlorek ialah julat biasa daripada tetapan pasukan penjagaan anda.';

  @override
  String chartSummary(String name, int count, String latest) {
    return 'Carta $name: $count bacaan, terkini $latest.';
  }

  @override
  String get chartTargetLineNote =>
      'Garis putus-putus ialah sasaran harian anda.';

  @override
  String get clinicalSummary => 'Ringkasan klinikal';

  @override
  String get colGestation => 'Usia kandungan';

  @override
  String get colScan => 'Imbasan';

  @override
  String get connectionsAiBody =>
      'Cipta kunci percuma di aistudio.google.com > Get API key. Model boleh kekal gemini-flash-latest.';

  @override
  String get connectionsAiTitle => 'Pembantu AI (Google Gemini)';

  @override
  String get connectionsBuiltIn => 'Terbina dalam aplikasi ini';

  @override
  String get connectionsEmailBody =>
      'Dalam EmailJS, tambah perkhidmatan Gmail dan templat e-mel dengan \"To\" ialah to_email dan mesej memaparkan passcode. Hidupkan \"Allow EmailJS API for non-browser applications\" di Account > Security, dan salin juga kunci peribadi.';

  @override
  String get connectionsEmailTitle => 'Kod e-mel (EmailJS + Gmail)';

  @override
  String get connectionsIntro =>
      'Kunci untuk pembantu AI dan kod e-mel. Kunci yang ditaip di sini kekal dalam telefon ini dan menggantikan kunci terbina dalam aplikasi. Biarkan kotak kosong untuk guna kunci terbina dalam.';

  @override
  String get connectionsMissing => 'Belum ditetapkan';

  @override
  String get connectionsSetHere => 'Ditetapkan pada telefon ini';

  @override
  String get connectionsTitle => 'Sambungan';

  @override
  String get contentPendingReview =>
      'Jadual ini ialah kandungan demo yang menunggu semakan klinisian bertauliah berdasarkan garis panduan Malaysia. Sentiasa ikut pasukan penjagaan anda.';

  @override
  String contentVersion(String version) {
    return 'Versi kandungan klinikal $version';
  }

  @override
  String get contractionAvgDuration => 'Purata tempoh';

  @override
  String get contractionAvgInterval => 'Purata jarak masa';

  @override
  String contractionDuration(String duration) {
    return 'Berlangsung $duration';
  }

  @override
  String get contractionEmpty =>
      'Kontraksi yang anda catat akan dipaparkan di sini.';

  @override
  String contractionGap(String gap) {
    return '$gap selepas yang sebelumnya';
  }

  @override
  String get contractionHistory => 'Sejarah';

  @override
  String contractionLastHour(int count) {
    return '$count kontraksi dalam sejam yang lalu';
  }

  @override
  String get contractionStart => 'Kontraksi bermula';

  @override
  String get contractionStop => 'Kontraksi tamat';

  @override
  String get contractionTapToStop => 'Ketik apabila tamat';

  @override
  String get contractionTitle => 'Pemasa kontraksi';

  @override
  String get contractionTooShort =>
      'Itu hanya beberapa saat, jadi tidak disimpan.';

  @override
  String get copied => 'Disalin';

  @override
  String get createAppointment => 'Temu janji';

  @override
  String get createAskAi => 'Tanya AI';

  @override
  String get createContractions => 'Kontraksi';

  @override
  String get createDocument => 'Dokumen';

  @override
  String get createFood => 'Makanan';

  @override
  String get createGroupCare => 'Penjagaan';

  @override
  String get createGroupHealth => 'Kesihatan';

  @override
  String get createGroupNutrition => 'Pemakanan';

  @override
  String get createGroupPregnancy => 'Kehamilan';

  @override
  String get createHealthLog => 'Log kesihatan';

  @override
  String get createKickCounter => 'Pengira tendangan';

  @override
  String get createMedication => 'Ubat';

  @override
  String get createMilestone => 'Pencapaian';

  @override
  String get createPeriod => 'Haid';

  @override
  String get createSymptoms => 'Simptom';

  @override
  String get createTitle => 'Apakah yang anda mahu tambah?';

  @override
  String get createUltrasound => 'Keputusan imbasan';

  @override
  String get createVaccine => 'Vaksin';

  @override
  String get createWater => 'Air';

  @override
  String cycleAverageLength(int days) {
    return 'Kitaran kira-kira $days hari';
  }

  @override
  String cycleBasedOnRecords(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Berdasarkan $count haid yang anda rekodkan. Setiap rekod baharu mengemas kini bulan-bulan seterusnya.',
    );
    return '$_temp0';
  }

  @override
  String get cycleBasedOnTypical => 'Berdasarkan kitaran biasa';

  @override
  String cycleDaysLate(int days) {
    return '$days hari lewat daripada jangkaan';
  }

  @override
  String cycleFertileWindow(String start, String end) {
    return 'Anggaran tempoh subur: $start – $end';
  }

  @override
  String cycleInDays(int days) {
    return 'Dalam $days hari';
  }

  @override
  String get cycleIrregularWarning =>
      'Kitaran anda banyak berubah-ubah, jadi anggaran ini mungkin kurang tepat.';

  @override
  String get cycleLogToday => 'Rekod haid';

  @override
  String get cycleNeedSecondPeriod =>
      'Berdasarkan kitaran biasa 28 hari. Rekod haid anda yang seterusnya dan ramalan akan mengikut rentak anda sendiri.';

  @override
  String get cycleNextPeriod => 'Haid seterusnya';

  @override
  String get cycleNoData =>
      'Rekod hari-hari haid anda. Selepas dua kali haid, kami boleh menganggarkan haid seterusnya.';

  @override
  String get cycleNoEstimate => 'Rekod haid anda untuk melihat anggaran.';

  @override
  String cycleOvulation(String date) {
    return 'Anggaran ovulasi: $date';
  }

  @override
  String get cyclePausedInPregnancy =>
      'Ramalan kitaran dihentikan sementara semasa hamil. Sejarah haid anda disimpan.';

  @override
  String cyclePeriodLength(int days) {
    return 'Haid kira-kira $days hari';
  }

  @override
  String cycleShiftEarlier(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Haid terakhir anda bermula $days hari awal daripada ramalan, jadi tarikh seterusnya dikemas kini.',
      one: 'Haid terakhir anda bermula 1 hari awal daripada ramalan, jadi tarikh seterusnya dikemas kini.',
    );
    return '$_temp0';
  }

  @override
  String cycleShiftLater(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Haid terakhir anda bermula $days hari lewat daripada ramalan, jadi tarikh seterusnya dikemas kini.',
      one: 'Haid terakhir anda bermula 1 hari lewat daripada ramalan, jadi tarikh seterusnya dikemas kini.',
    );
    return '$_temp0';
  }

  @override
  String get cycleStale =>
      'Haid yang dijangka sudah lewat lebih daripada satu kitaran. Rekod haid terkini untuk mengemas kini anggaran.';

  @override
  String get cycleUpcomingTitle => 'Haid seterusnya (anggaran)';

  @override
  String get dayAppointments => 'Temu janji';

  @override
  String get dayHealthLogs => 'Log kesihatan';

  @override
  String get dayNotes => 'Nota';

  @override
  String get dayPeriod => 'Haid';

  @override
  String get daySymptoms => 'Simptom';

  @override
  String daysPastDue(int days) {
    return '$days hari melepasi tarikh jangkaan';
  }

  @override
  String daysToGo(int days) {
    return '$days hari lagi';
  }

  @override
  String deliveredConfirmBody(String date) {
    return 'Kami akan menutup kehamilan ini pada $date dan memulakan penjagaan selepas bersalin. Rekod kehamilan anda kekal dalam sejarah.';
  }

  @override
  String get deliveredConfirmTitle => 'Tahniah!';

  @override
  String deliveredOn(String date) {
    return 'Bersalin pada $date';
  }

  @override
  String get deliveredSaved => 'Penjagaan selepas bersalin dimulakan.';

  @override
  String get demoModeBody =>
      'Anda sedang melihat data demo yang dilabel dengan jelas. Tiada apa-apa dihantar ke pelayan dan rekod ditetapkan semula apabila aplikasi dimulakan semula.';

  @override
  String get demoModeTitle => 'Mod demo';

  @override
  String get demoUseCyclePatient => 'Aina (kitaran)';

  @override
  String get demoUseDoctor => 'Dr. Chua (doktor)';

  @override
  String get demoUsePatient => 'Gwen (hamil)';

  @override
  String get devicesTitle => 'Peranti bersambung';

  @override
  String get disclaimer =>
      'Aplikasi ini menyokong, tetapi tidak menggantikan, penjagaan daripada doktor anda. Ia tidak membuat diagnosis. Kandungan klinikal masih menunggu semakan oleh klinisian bertauliah.';

  @override
  String get docBloodTest => 'Ujian darah';

  @override
  String get docHospital => 'Dokumen hospital';

  @override
  String get docOther => 'Lain-lain';

  @override
  String get docPrescription => 'Preskripsi';

  @override
  String get docUltrasound => 'Ultrabunyi';

  @override
  String get docVaccination => 'Rekod vaksinasi';

  @override
  String doctorGreeting(String name) {
    return 'Selamat sejahtera, $name';
  }

  @override
  String get doctorNavDashboard => 'Papan pemuka';

  @override
  String get doctorNavPatients => 'Pesakit';

  @override
  String get doctorPendingBody =>
      'Pentadbir sedang menyemak pendaftaran MMC anda. Anda boleh melihat pesakit yang dipautkan selepas diluluskan.';

  @override
  String get doctorPendingTitle => 'Menunggu pengesahan';

  @override
  String get documentSearchEmpty => 'Tiada dokumen sepadan.';

  @override
  String get documentSearchHint => 'Cari tajuk dan teks dalam dokumen';

  @override
  String get documentStorageNote =>
      'Dalam demo ini fail kekal di telefon anda. Dalam aplikasi penuh ia disulitkan dan disimpan secara peribadi, dan hanya doktor yang dipautkan boleh membukanya.';

  @override
  String get documentsEmpty => 'Belum ada dokumen.';

  @override
  String get documentsTitle => 'Dokumen perubatan';

  @override
  String dueDateGaPreview(String ga) {
    return 'Ini bermakna anda $ga hari ini.';
  }

  @override
  String get dueDateHelper => 'Daripada doktor atau laporan imbasan anda.';

  @override
  String dueDateInvalidBody(String date) {
    return 'Tarikh jangkaan yang disimpan ($date) tidak sepadan dengan kehamilan yang sedang berlangsung, jadi kami tidak memaparkan minggu atau kiraan detik.';
  }

  @override
  String get dueDateInvalidTitle => 'Sila semak tarikh jangkaan bersalin anda';

  @override
  String get dueDateTooFarFuture =>
      'Tarikh ini lebih daripada 40 minggu lagi. Sila semak.';

  @override
  String get dueDateTooFarPast =>
      'Tarikh ini terlalu lama untuk kehamilan yang sedang berlangsung. Sila semak.';

  @override
  String dueOn(String date) {
    return 'Jangkaan bersalin $date';
  }

  @override
  String emergencyNumberNote(String number) {
    return 'Dalam kecemasan di Malaysia, hubungi $number.';
  }

  @override
  String get errorEnterNumber => 'Sila masukkan nombor.';

  @override
  String errorOutOfRange(String min, String max) {
    return 'Sila masukkan nilai antara $min hingga $max.';
  }

  @override
  String get errorRequired => 'Sila isi ruangan ini.';

  @override
  String get estimateLabel => 'Anggaran';

  @override
  String get fetalAc => 'Lilitan abdomen';

  @override
  String get fetalAfi => 'Indeks cecair amniotik';

  @override
  String get fetalBpd => 'Diameter biparietal';

  @override
  String get fetalCrl => 'Panjang kepala-punggung';

  @override
  String get fetalEfw => 'Anggaran berat';

  @override
  String get fetalFhr => 'Kadar jantung janin';

  @override
  String get fetalFl => 'Panjang femur';

  @override
  String get fetalHc => 'Lilitan kepala';

  @override
  String get fetalNt => 'Translusensi nukal';

  @override
  String get fieldActivityLevel => 'Tahap aktiviti';

  @override
  String get fieldAllergies => 'Alahan';

  @override
  String get fieldBloodGroup => 'Kumpulan darah';

  @override
  String get fieldCalories => 'Kalori';

  @override
  String get fieldCategory => 'Kategori';

  @override
  String get fieldClinic => 'Klinik atau hospital';

  @override
  String get fieldClinicHospital => 'Klinik atau hospital';

  @override
  String get fieldDate => 'Tarikh';

  @override
  String get fieldDateOfBirth => 'Tarikh lahir';

  @override
  String get fieldDescription => 'Keterangan';

  @override
  String get fieldDiastolic => 'Diastolik (bawah)';

  @override
  String get fieldDoctor => 'Doktor';

  @override
  String get fieldDocumentDate => 'Tarikh pada dokumen';

  @override
  String get fieldDueDate => 'Jangkaan tarikh bersalin';

  @override
  String get fieldEmail => 'E-mel';

  @override
  String get fieldFlow => 'Aliran';

  @override
  String get fieldFoodName => 'Makanan atau minuman';

  @override
  String get fieldFullName => 'Nama penuh';

  @override
  String get fieldGlucoseContext => 'Bilakah ia diukur?';

  @override
  String get fieldHeight => 'Tinggi';

  @override
  String get fieldMeal => 'Waktu makan';

  @override
  String get fieldMeasurement => 'Apakah yang anda rekodkan?';

  @override
  String get fieldMedicalHistory => 'Sejarah perubatan';

  @override
  String get fieldMilestone => 'Pencapaian';

  @override
  String get fieldMmcHelper =>
      'Disemak oleh pentadbir sebelum anda boleh melihat data pesakit.';

  @override
  String get fieldMmcNumber => 'Nombor pendaftaran MMC';

  @override
  String get fieldNote => 'Nota';

  @override
  String get fieldNotesOptional => 'Nota (pilihan)';

  @override
  String get fieldNumberOfBabies => 'Bilangan bayi';

  @override
  String get fieldOtp => 'Kod sekali guna';

  @override
  String get fieldPhone => 'Nombor telefon';

  @override
  String get fieldPhoneOrEmail => 'Telefon atau e-mel';

  @override
  String get fieldPortion => 'Hidangan';

  @override
  String get fieldPrePregnancyWeight => 'Berat sebelum hamil';

  @override
  String get fieldPreferredLanguage => 'Bahasa pilihan';

  @override
  String get fieldPurpose => 'Tujuan';

  @override
  String get fieldScanType => 'Jenis imbasan';

  @override
  String get fieldSeverity => 'Sejauh mana teruknya?';

  @override
  String get fieldSystolic => 'Sistolik (atas)';

  @override
  String get fieldTime => 'Masa';

  @override
  String get fieldTitle => 'Tajuk';

  @override
  String get filterPending => 'Permintaan';

  @override
  String get flowHeavy => 'Banyak';

  @override
  String get flowLight => 'Sedikit';

  @override
  String get flowMedium => 'Sederhana';

  @override
  String get flowNone => 'Tiada';

  @override
  String get flowSpotting => 'Bertompok';

  @override
  String gaWeeksDays(int weeks, int days) {
    return '$weeks minggu $days hari';
  }

  @override
  String get glucoseAfterMeal => 'Selepas makan';

  @override
  String get glucoseFasting => 'Berpuasa';

  @override
  String get glucoseRandom => 'Masa lain';

  @override
  String get gravidaPara => 'Gravida / para';

  @override
  String get growthCompareScans => 'Bandingkan imbasan';

  @override
  String get growthNoScans => 'Belum ada imbasan direkodkan.';

  @override
  String get healthConnectBody =>
      'Bawa masuk langkah, kadar denyutan jantung, tidur dan data lain yang sudah direkod oleh telefon atau jam tangan anda.';

  @override
  String get healthConnectDemoNote =>
      'Health Connect di bawah masih menggunakan bacaan demo dalam binaan ini. Bluetooth di atas adalah sebenar.';

  @override
  String get healthConnectRationale =>
      'Kami hanya membaca jenis data yang anda benarkan, dan hanya selepas anda bersetuju. Anda boleh memutuskan sambungan bila-bila masa.';

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String homeGreeting(String name) {
    return 'Hai, $name';
  }

  @override
  String get homeNextAppointment => 'Temu janji akan datang';

  @override
  String get homeRecentActivity => 'Aktiviti kesihatan terkini';

  @override
  String get homeTabBaby => 'Bayi';

  @override
  String get homeTabMother => 'Ibu';

  @override
  String get homeTodaysHealth => 'Kesihatan hari ini';

  @override
  String get homeTodaysTasks => 'Tugasan hari ini';

  @override
  String get intimacyPrivateNote =>
      'Peribadi: hanya anda boleh melihatnya melainkan anda memilih untuk berkongsi dalam Privasi.';

  @override
  String get journeyGeneral => 'Kesihatan wanita';

  @override
  String get journeyPostpartum => 'Selepas bersalin';

  @override
  String get journeyPregnancy => 'Hamil';

  @override
  String get kcalBurntNotConnected =>
      'Kalori dibakar: sambungkan jam tangan atau Health Connect';

  @override
  String get kcalConsumed => 'dimakan';

  @override
  String kcalOver(String kcal) {
    return '$kcal kcal melebihi sasaran';
  }

  @override
  String kcalRemaining(String kcal) {
    return '$kcal kcal berbaki';
  }

  @override
  String get kickCounterTitle => 'Pengira tendangan';

  @override
  String get kickGuarded =>
      'Dikira sebagai pergerakan yang sama dengan ketikan terakhir.';

  @override
  String get kickTapButton => 'Ketik untuk setiap pergerakan';

  @override
  String kicksChartSummary(int count) {
    return 'Carta bar pergerakan setiap jam hari ini. Jumlah $count.';
  }

  @override
  String kicksCount(int count) {
    return '$count';
  }

  @override
  String get kicksPastDays => 'Hari-hari sebelumnya';

  @override
  String get kicksPerHourTitle => 'Pergerakan setiap jam hari ini';

  @override
  String kicksTodayCount(int count) {
    return '$count pergerakan hari ini';
  }

  @override
  String get languageSwitchLabel => 'Bahasa aplikasi';

  @override
  String lastKickAt(String time) {
    return 'Pergerakan terakhir pada $time';
  }

  @override
  String lastNDays(int days) {
    return '$days hari';
  }

  @override
  String get legendAppointment => 'Temu janji';

  @override
  String get legendFertile => 'Tempoh subur (anggaran)';

  @override
  String get legendLogged => 'Log kesihatan';

  @override
  String get legendMedication => 'Ubat diambil';

  @override
  String get legendPeriod => 'Haid';

  @override
  String get legendPredicted => 'Jangkaan haid';

  @override
  String get linkActive => 'Boleh melihat rekod yang dikongsi';

  @override
  String get linkPending => 'Menunggu doktor menerima';

  @override
  String get loginChangeIdentifier => 'Guna telefon atau e-mel lain';

  @override
  String get loginIntro =>
      'Masukkan nombor telefon atau e-mel anda. Kami akan menghantar kod sekali guna.';

  @override
  String get loginRecoveryHint =>
      'Tidak dapat menerima kod pada telefon atau e-mel ini? Hubungi klinik anda untuk memulihkan akaun.';

  @override
  String get loginTitle => 'Log masuk';

  @override
  String get macroCarbs => 'Karbohidrat';

  @override
  String get macroFat => 'Lemak';

  @override
  String get macroProtein => 'Protein';

  @override
  String macroSummary(String protein, String carbs, String fat) {
    return 'P $protein g · K $carbs g · L $fat g';
  }

  @override
  String get mealBreakfast => 'Sarapan';

  @override
  String get mealDinner => 'Makan malam';

  @override
  String get mealDrinks => 'Minuman';

  @override
  String get mealLunch => 'Makan tengah hari';

  @override
  String get mealSnacks => 'Snek';

  @override
  String get medicationSafetyNote =>
      'Tambah ubat hanya seperti yang dipreskripsikan oleh doktor anda. Senarai ini ialah peringatan, bukan nasihat perubatan.';

  @override
  String get medicationsNoneToday => 'Tiada dos dijadualkan hari ini.';

  @override
  String get medicationsTitle => 'Ubat-ubatan';

  @override
  String get medicationsToday => 'Hari ini';

  @override
  String get menuAbout => 'Perihal';

  @override
  String get menuAppearance => 'Penampilan';

  @override
  String get menuCareTeam => 'Pasukan penjagaan saya';

  @override
  String get menuEmergencyContact => 'Kenalan kecemasan';

  @override
  String get menuNotifications => 'Pemberitahuan';

  @override
  String get menuPersonalInfo => 'Maklumat peribadi';

  @override
  String get menuPregnancyInfo => 'Maklumat kehamilan';

  @override
  String get menuPrivacy => 'Privasi dan data';

  @override
  String get milestoneHint => 'cth. Merasa tendangan pertama';

  @override
  String get moodGood => 'Baik';

  @override
  String get moodGreat => 'Sangat baik';

  @override
  String get moodLow => 'Rendah';

  @override
  String get moodOkay => 'Biasa';

  @override
  String get moodVeryLow => 'Sangat rendah';

  @override
  String get navCalendar => 'Kalendar';

  @override
  String get navCalories => 'Kalori';

  @override
  String get navCreate => 'Cipta';

  @override
  String get navHome => 'Utama';

  @override
  String get navProfile => 'Profil';

  @override
  String get noData => 'Belum ada data';

  @override
  String get noDataTapToAdd => 'Belum ada data. Ketik untuk tambah.';

  @override
  String get noReadingsInPeriod => 'Tiada bacaan dalam tempoh ini.';

  @override
  String get noReadingsYet => 'Belum ada bacaan.';

  @override
  String get nothingLogged => 'Tiada rekod.';

  @override
  String get notifAppointments => 'Temu janji';

  @override
  String get notifDoctorMessages => 'Mesej daripada doktor saya';

  @override
  String get notifHealthLogs => 'Peringatan log kesihatan';

  @override
  String get notifLockScreenDetails => 'Tunjukkan butiran pada skrin kunci';

  @override
  String get notifLockScreenHelp =>
      'Dimatikan secara lalai untuk melindungi privasi anda.';

  @override
  String get notifMedication => 'Ubat';

  @override
  String get notifMilestones => 'Pencapaian kehamilan';

  @override
  String get notifVaccines => 'Vaksin';

  @override
  String get notificationsRationale =>
      'Kami menggunakan pemberitahuan untuk mengingatkan anda tentang temu janji, log kesihatan dan pencapaian kehamilan yang penting.';

  @override
  String get obsActivity => 'Langkah';

  @override
  String get obsBloodGlucose => 'Glukosa darah';

  @override
  String get obsBloodPressure => 'Tekanan darah';

  @override
  String get obsHeartRate => 'Kadar denyutan jantung';

  @override
  String get obsMood => 'Emosi';

  @override
  String get obsSleep => 'Tidur';

  @override
  String get obsSpo2 => 'Oksigen (SpO2)';

  @override
  String get obsTemperature => 'Suhu badan';

  @override
  String get obsWater => 'Air';

  @override
  String get obsWeight => 'Berat badan';

  @override
  String get onboardingBodySubtitle =>
      'Digunakan untuk anggaran berat dan kalori. Anda boleh mengubahnya kemudian.';

  @override
  String get onboardingBodyTitle => 'Badan anda';

  @override
  String onboardingDemoCode(String code) {
    return 'Binaan demo: gunakan kod $code.';
  }

  @override
  String get onboardingDoctorDoneSubtitle =>
      'Pentadbir akan mengesahkan pendaftaran anda sebelum anda boleh melihat sebarang data pesakit.';

  @override
  String get onboardingDoctorDoneTitle => 'Hampir selesai';

  @override
  String get onboardingDoneSubtitle =>
      'Semua yang anda rekodkan mulai sekarang disimpan bersama di satu tempat.';

  @override
  String get onboardingDoneTitle => 'Profil anda sudah sedia';

  @override
  String get onboardingNotPregnantInfo =>
      'Kami akan sediakan penjejakan kitaran dan kesihatan wanita umum. Anda boleh mula kehamilan kemudian dari profil anda.';

  @override
  String get onboardingPersonalSubtitle =>
      'Ini membantu kami memperibadikan penjagaan anda.';

  @override
  String get onboardingPersonalTitle => 'Tentang anda';

  @override
  String get onboardingPregnancySubtitle =>
      'Ini menentukan skrin utama anda. Anda boleh mengubahnya bila-bila masa.';

  @override
  String get onboardingPregnancyTitle => 'Adakah anda sedang hamil?';

  @override
  String get onboardingRoleSubtitle =>
      'Pilih satu. Anda hanya boleh melihat apa yang dibenarkan untuk peranan anda.';

  @override
  String get onboardingRoleTitle => 'Siapa yang menggunakan aplikasi?';

  @override
  String onboardingStepOf(int current, int total) {
    return 'Langkah $current daripada $total';
  }

  @override
  String get onboardingVerifySubtitle =>
      'Pilih telefon atau e-mel dan kami akan menghantar kod sekali guna.';

  @override
  String get onboardingVerifyTitle => 'Sahkan akaun anda';

  @override
  String otpSentTo(String destination) {
    return 'Kod dihantar ke $destination';
  }

  @override
  String get outsideRangeBody =>
      'Bacaan anda telah disimpan. Ia di luar julat biasa dalam tetapan pasukan penjagaan anda. Jika anda berasa tidak sihat atau melihat sebarang tanda amaran, hubungi pasukan penjagaan anda. Ini bukan diagnosis.';

  @override
  String get outsideRangeTitle => 'Bacaan di luar julat biasa';

  @override
  String get painMild => 'Ringan';

  @override
  String get painModerate => 'Sederhana';

  @override
  String get painSevere => 'Teruk';

  @override
  String get past => 'Lepas';

  @override
  String get patientId => 'ID pesakit';

  @override
  String get patientSearchEmpty => 'Tiada pesakit sepadan.';

  @override
  String get patientSearchHint => 'Cari nama, ID, telefon atau tarikh jangkaan';

  @override
  String percentileFromReport(String value) {
    return 'Persentil ke-$value (daripada laporan)';
  }

  @override
  String get periodDayTitle => 'Log haid dan kitaran';

  @override
  String get permissionsBody =>
      'Aplikasi meminta kebenaran pemberitahuan, Bluetooth, kamera atau foto hanya apabila anda mula menggunakan ciri yang memerlukannya. Anda boleh mengubahnya bila-bila masa dalam tetapan telefon.';

  @override
  String get permissionsTitle => 'Kebenaran';

  @override
  String get portionHint => 'cth. 1 pinggan, 250 ml';

  @override
  String postpartumSince(int weeks, int days) {
    return '$weeks minggu $days hari selepas bersalin';
  }

  @override
  String get pregnancyStartInfo =>
      'Menyimpan akan memulakan kehamilan baharu dalam rekod anda. Sejarah terdahulu kekal.';

  @override
  String get privacyIntro =>
      'Rekod kesihatan anda adalah milik anda. Hanya doktor yang anda pautkan boleh melihatnya, dan hanya bahagian yang anda pilih untuk dikongsi.';

  @override
  String get purposeHint => 'cth. Pemeriksaan antenatal';

  @override
  String get rangeAbove => 'Melebihi julat';

  @override
  String get rangeBelow => 'Bawah julat';

  @override
  String get rangeWithin => 'Dalam julat';

  @override
  String get readingsTitle => 'Bacaan';

  @override
  String get recentFoods => 'Makanan terkini';

  @override
  String reminderAppointmentToday(String purpose, String time) {
    return 'Temu janji anda ($purpose) ialah hari ini pada $time.';
  }

  @override
  String reminderAppointmentTomorrow(String purpose, String time) {
    return 'Temu janji anda ($purpose) ialah esok pada $time.';
  }

  @override
  String get reminderLogBloodPressure =>
      'Ingat untuk merekod tekanan darah hari ini.';

  @override
  String reminderMedication(int count) {
    return '$count dos lagi perlu diambil hari ini.';
  }

  @override
  String reminderVaccineDue(String name) {
    return 'Vaksinasi anda yang seterusnya mungkin perlu diambil: $name. Semak dengan pasukan penjagaan anda.';
  }

  @override
  String get remindersEmpty => 'Tiada peringatan buat masa ini.';

  @override
  String get remindersPushNote =>
      'Pemberitahuan telefon menggunakan perkataan umum seperti \"Anda ada peringatan baharu\", supaya butiran kesihatan tidak dipaparkan pada skrin kunci.';

  @override
  String get remindersTitle => 'Peringatan';

  @override
  String get riskFactors => 'Faktor risiko';

  @override
  String get roleDoctor => 'Doktor / Pentadbir';

  @override
  String get roleDoctorHint => 'Semak pesakit anda selepas pengesahan';

  @override
  String get rolePatient => 'Pesakit';

  @override
  String get rolePatientHint => 'Jejak kehamilan, kitaran dan kesihatan';

  @override
  String get savedMessage => 'Disimpan';

  @override
  String get scanTypeDefault => 'Ultrabunyi';

  @override
  String get scanTypeHint => 'cth. Imbasan pertumbuhan';

  @override
  String get scanning => 'Mengimbas…';

  @override
  String get securityTitle => 'Log masuk & keselamatan';

  @override
  String get shareCycle => 'Haid dan kitaran';

  @override
  String get shareDocuments => 'Dokumen perubatan';

  @override
  String get shareIntimacy => 'Aktiviti seksual';

  @override
  String get shareNutrition => 'Makanan dan kalori';

  @override
  String get sharePregnancy => 'Kehamilan dan imbasan';

  @override
  String get shareVitals => 'Log kesihatan dan tanda vital';

  @override
  String get sharingTitle => 'Dikongsi dengan doktor saya';

  @override
  String get signOutConfirm => 'Log keluar dari peranti ini?';

  @override
  String get statAlerts => 'Amaran untuk disemak';

  @override
  String get statAverage => 'Purata';

  @override
  String get statHighest => 'Tertinggi';

  @override
  String get statLowest => 'Terendah';

  @override
  String get statNewRequests => 'Permintaan pesakit baharu';

  @override
  String get statTodaysAppointments => 'Temu janji hari ini';

  @override
  String get statTotalPatients => 'Pesakit';

  @override
  String get statusConnected => 'Bersambung';

  @override
  String get statusNotConnected => 'Tidak bersambung';

  @override
  String get symptomLogged => 'Simptom';

  @override
  String get symptomsEmpty => 'Tiada simptom direkodkan.';

  @override
  String get symptomsHistoryTitle => 'Simptom terkini';

  @override
  String get symptomsLogTitle => 'Rekod simptom';

  @override
  String get symptomsTitle => 'Simptom';

  @override
  String syncedReadings(int count) {
    return '$count bacaan disegerakkan';
  }

  @override
  String get tabCycle => 'Kitaran haid';

  @override
  String get tabGrowth => 'Pertumbuhan';

  @override
  String get tabPregnancyTimeline => 'Kehamilan';

  @override
  String get tabSummary => 'Ringkasan';

  @override
  String get tabTimeline => 'Garis masa';

  @override
  String get tabVitals => 'Tanda vital';

  @override
  String get targetSetByClinician => 'Ditetapkan oleh pasukan penjagaan';

  @override
  String get taskCountKicks => 'Kira pergerakan bayi';

  @override
  String get taskDone => 'Selesai';

  @override
  String get taskDrinkWater => 'Minum air';

  @override
  String get taskNotDone => 'Belum selesai';

  @override
  String taskTakeMedication(String name, String dose) {
    return 'Ambil $name $dose';
  }

  @override
  String get timelineDueDate => 'Tarikh jangkaan bersalin';

  @override
  String get timelineStart => 'Kehamilan dikira dari';

  @override
  String timelineTrimesterStarts(String name) {
    return '$name bermula';
  }

  @override
  String get today => 'Hari ini';

  @override
  String get totpBody =>
      'Log masuk dengan kod 6 digit daripada Google Authenticator, Microsoft Authenticator atau aplikasi serupa. Ia berfungsi tanpa SMS atau internet.';

  @override
  String get totpCodeLabel => 'Kod pengesah';

  @override
  String get totpEnable => 'Sahkan dan hidupkan';

  @override
  String get totpKeyLabel => 'Kunci persediaan';

  @override
  String get totpNoApp =>
      'Tiada aplikasi pengesah ditemui. Pasang Google Authenticator, kemudian cuba lagi atau taip kunci persediaan.';

  @override
  String get totpOn =>
      'Aplikasi pengesah dihidupkan. Semasa log masuk, masukkan kod yang dipaparkan.';

  @override
  String get totpOpenApp => 'Buka aplikasi pengesah';

  @override
  String get totpSetup => 'Sediakan aplikasi pengesah';

  @override
  String get totpStep1 =>
      '1. Ketik \"Buka aplikasi pengesah\", atau imbas kod QR ini dengan telefon lain, atau taip kunci persediaan ke dalam aplikasi.';

  @override
  String get totpStep2 =>
      '2. Masukkan kod 6 digit yang dipaparkan oleh aplikasi.';

  @override
  String get totpTitle => 'Aplikasi pengesah';

  @override
  String get totpTurnOff => 'Matikan';

  @override
  String get trimesterFirst => 'Trimester pertama';

  @override
  String get trimesterLabel => 'Trimester';

  @override
  String get trimesterSecond => 'Trimester kedua';

  @override
  String get trimesterThird => 'Trimester ketiga';

  @override
  String get ultrasoundCopyHint =>
      'Salin nombor daripada laporan imbasan anda. Biarkan kosong jika tiada dalam laporan.';

  @override
  String get ultrasoundNeedOneValue =>
      'Sila masukkan sekurang-kurangnya satu ukuran.';

  @override
  String get unitBpm => 'bpm';

  @override
  String get unitHours => 'jam';

  @override
  String get unitSteps => 'langkah';

  @override
  String get unitWeeksShort => 'minggu';

  @override
  String get upcoming => 'Akan datang';

  @override
  String uploadedBy(String name) {
    return 'Ditambah oleh $name';
  }

  @override
  String vaccinationPurpose(String name) {
    return 'Vaksinasi: $name';
  }

  @override
  String get vaccineAlreadyHad => 'Saya sudah mengambilnya – rekodkan';

  @override
  String get vaccineBook => 'Tempah temu janji vaksinasi';

  @override
  String get vaccineBookHint => 'Tandakan kotak di atas untuk menempah.';

  @override
  String get vaccineConfirmRead =>
      'Saya telah membaca fungsi vaksin ini dan harganya.';

  @override
  String get vaccineDemoPrice => 'Harga demo, untuk contoh sahaja.';

  @override
  String get vaccineDoctorConfirms =>
      'Doktor anda akan mengesahkan semasa temu janji sama ada vaksin ini sesuai untuk anda.';

  @override
  String get vaccineDueNow => 'Perlu sekarang';

  @override
  String get vaccineGiven => 'Sudah diberi';

  @override
  String vaccineGivenOn(String date) {
    return 'Diberi pada $date';
  }

  @override
  String get vaccineHistory => 'Sejarah vaksinasi';

  @override
  String get vaccineHistoryEmpty => 'Tiada vaksinasi direkodkan.';

  @override
  String get vaccineNoDescription => 'Klinik anda belum menambah penerangan.';

  @override
  String get vaccinePending => 'Belum diambil';

  @override
  String vaccinePriceAt(String clinic) {
    return 'Di $clinic';
  }

  @override
  String get vaccinePriceLabel => 'Harga';

  @override
  String get vaccinePriceUnknown => 'Tanya klinik anda tentang harga.';

  @override
  String get vaccineTapForDetails => 'Butiran dan harga';

  @override
  String get vaccineWhatItDoes => 'Fungsinya';

  @override
  String get vaccineWhen => 'Bila';

  @override
  String get vaccinesTitle => 'Vaksin';

  @override
  String get verificationStatus => 'Pengesahan';

  @override
  String get verified => 'Disahkan';

  @override
  String versionLabel(String version) {
    return 'Versi $version';
  }

  @override
  String get warningSignLogNow => 'Saya mengalaminya sekarang — rekod';

  @override
  String get warningSignsIntro =>
      'Jika anda mengalami mana-mana tanda ini, dapatkan bantuan sekarang. Jangan tunggu temu janji seterusnya.';

  @override
  String get warningSignsTitle => 'Tanda amaran';

  @override
  String waterTodayMl(String amount) {
    return '$amount ml hari ini';
  }

  @override
  String get welcomeCreateAccount => 'Cipta akaun';

  @override
  String welcomeDemoHint(String code) {
    return 'Binaan demo: log masuk sebagai demo.patient@example.com (Gwen, hamil), demo.cycle@example.com (Aina, jejak kitaran) atau demo.doctor@example.com, dengan kod $code. Data demo ditetapkan semula apabila aplikasi dimulakan semula.';
  }

  @override
  String get welcomeSignIn => 'Saya sudah ada akaun';

  @override
  String get welcomeTagline =>
      'Rekod kehamilan, kitaran haid dan kesihatan wanita anda, dikongsi bersama pasukan penjagaan anda.';

  @override
  String get yourDoctors => 'Doktor anda';
}
