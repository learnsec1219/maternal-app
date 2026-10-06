// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'Maternal';

  @override
  String get navHome => 'Utama';

  @override
  String get navCalendar => 'Kalendar';

  @override
  String get navCreate => 'Tambah';

  @override
  String get navCalories => 'Kalori';

  @override
  String get navProfile => 'Profil';

  @override
  String get createTitle => 'Apa yang anda ingin tambah?';

  @override
  String get createHealthLog => 'Log kesihatan';

  @override
  String get createSymptoms => 'Simptom';

  @override
  String get createPeriod => 'Haid';

  @override
  String get createMeal => 'Makanan';

  @override
  String get createPregnancyRecord => 'Rekod kehamilan';

  @override
  String get createVaccine => 'Vaksin';

  @override
  String get createAppointment => 'Temu janji';

  @override
  String get createDocument => 'Dokumen perubatan';

  @override
  String get comingSoon =>
      'Akan datang. Bahagian ini dirancang untuk langkah seterusnya.';

  @override
  String get soonBadge => 'Akan datang';

  @override
  String homeGreeting(String name) {
    return 'Helo, $name';
  }

  @override
  String get homeGreetingNoName => 'Helo';

  @override
  String get pregnancyOverview => 'Ringkasan kehamilan';

  @override
  String weeksDays(int weeks, int days) {
    return '$weeks minggu $days hari';
  }

  @override
  String dueDateLabel(String date) {
    return 'Tarikh jangka bersalin $date';
  }

  @override
  String daysToGo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hari lagi',
      zero: 'Tarikh jangka hari ini',
    );
    return '$_temp0';
  }

  @override
  String daysPastDue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hari melepasi tarikh jangka',
    );
    return '$_temp0';
  }

  @override
  String get trimesterFirst => 'Trimester pertama';

  @override
  String get trimesterSecond => 'Trimester kedua';

  @override
  String get trimesterThird => 'Trimester ketiga';

  @override
  String babiesCount(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '1': 'Tunggal',
      '2': 'Kembar dua',
      '3': 'Kembar tiga',
      'other': '$count bayi',
    });
    return '$_temp0';
  }

  @override
  String get setDueDatePrompt =>
      'Masukkan tarikh jangka bersalin dalam Profil untuk melihat kemajuan kehamilan anda.';

  @override
  String get cycleOverview => 'Ringkasan kitaran';

  @override
  String nextPeriodEstimate(String date) {
    return 'Haid seterusnya (anggaran): $date';
  }

  @override
  String get noCycleData =>
      'Log haid dari Tambah untuk mula membuat anggaran kitaran.';

  @override
  String get todaysHealth => 'Kesihatan hari ini';

  @override
  String get noData => 'Tiada data';

  @override
  String get metricWeight => 'Berat';

  @override
  String get metricBloodPressure => 'Tekanan darah';

  @override
  String get metricHeartRate => 'Kadar jantung';

  @override
  String get metricGlucose => 'Glukosa darah';

  @override
  String get metricTemperature => 'Suhu';

  @override
  String get metricSpo2 => 'SpO2';

  @override
  String get metricSleep => 'Tidur';

  @override
  String get metricWater => 'Air';

  @override
  String get metricFetalMovement => 'Pergerakan janin';

  @override
  String get metricSymptom => 'Simptom';

  @override
  String get statusLow => 'Rendah';

  @override
  String get statusNormal => 'Biasa';

  @override
  String get statusHigh => 'Tinggi';

  @override
  String get todaysTasks => 'Tugasan hari ini';

  @override
  String get taskLogBp => 'Rekod tekanan darah';

  @override
  String get taskKicks => 'Rekod pergerakan janin';

  @override
  String get taskWater => 'Minum 8 gelas air';

  @override
  String get taskLogMeal => 'Log makanan anda';

  @override
  String get recentActivity => 'Aktiviti kesihatan terkini';

  @override
  String get noActivity =>
      'Belum ada log. Tekan Tambah untuk catatan pertama anda.';

  @override
  String get warningSigns => 'Tanda amaran';

  @override
  String get warningSignsIntro =>
      'Dapatkan nasihat perubatan jika anda mengalami mana-mana tanda ini. Aplikasi ini tidak membuat diagnosis.';

  @override
  String get disclaimer =>
      'Prototaip untuk reka bentuk aliran kerja klinikal. Bukan peranti perubatan berdaftar.';

  @override
  String get healthLogTitle => 'Tambah log kesihatan';

  @override
  String get measurement => 'Ukuran';

  @override
  String get systolic => 'Sistolik (mmHg)';

  @override
  String get diastolic => 'Diastolik (mmHg)';

  @override
  String valueWithUnit(String unit) {
    return 'Nilai ($unit)';
  }

  @override
  String get noteOptional => 'Nota (pilihan)';

  @override
  String get save => 'Simpan';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Padam';

  @override
  String get invalidNumber => 'Masukkan nombor yang sah';

  @override
  String get required => 'Wajib';

  @override
  String get saved => 'Disimpan';

  @override
  String get quickKick => 'Tambah 1 tendangan';

  @override
  String kicksToday(int count) {
    return '$count tendangan hari ini';
  }

  @override
  String get symptomTitle => 'Log simptom';

  @override
  String get symptomCommon => 'Biasa';

  @override
  String get symptomWarning => 'Perlukan rawatan perubatan';

  @override
  String get symptomLogged => 'Simptom dilog';

  @override
  String get sym_nausea => 'Loya';

  @override
  String get sym_fatigue => 'Keletihan';

  @override
  String get sym_backPain => 'Sakit belakang';

  @override
  String get sym_heartburn => 'Pedih ulu hati';

  @override
  String get sym_cramps => 'Kekejangan';

  @override
  String get sym_headache => 'Sakit kepala';

  @override
  String get sym_reducedMovements => 'Pergerakan janin berkurang atau tiada';

  @override
  String get sym_bleeding => 'Pendarahan faraj';

  @override
  String get sym_severeHeadacheVision =>
      'Sakit kepala teruk dengan perubahan penglihatan';

  @override
  String get sym_suddenSwelling =>
      'Bengkak mengejut pada muka, tangan atau kaki';

  @override
  String get sym_severeAbdominalPain =>
      'Sakit perut yang teruk atau berterusan';

  @override
  String get sym_fluidLeak => 'Lelehan cecair berair dari faraj';

  @override
  String get sym_feverUnwell => 'Demam atau berasa sangat tidak sihat';

  @override
  String get act_reducedMovements =>
      'Hubungi wad bersalin hospital atau pasukan obstetrik anda dengan segera.';

  @override
  String get act_bleeding =>
      'Pergi ke jabatan kecemasan atau wad bersalin hospital terdekat sekarang.';

  @override
  String get act_severeHeadacheVision =>
      'Dapatkan pemeriksaan perubatan segera hari ini.';

  @override
  String get act_suddenSwelling =>
      'Hubungi pasukan penjagaan anda hari ini untuk pemeriksaan tekanan darah dan air kencing.';

  @override
  String get act_severeAbdominalPain => 'Dapatkan rawatan perubatan segera.';

  @override
  String get act_fluidLeak =>
      'Hubungi wad bersalin hospital anda dengan segera.';

  @override
  String get act_feverUnwell =>
      'Hubungi pasukan penjagaan anda pada hari yang sama.';

  @override
  String get periodTitle => 'Log haid';

  @override
  String get periodStart => 'Tarikh mula';

  @override
  String get periodEnd => 'Tarikh tamat (pilihan)';

  @override
  String get flow => 'Aliran';

  @override
  String get flow_spotting => 'Tompok';

  @override
  String get flow_light => 'Sedikit';

  @override
  String get flow_medium => 'Sederhana';

  @override
  String get flow_heavy => 'Banyak';

  @override
  String get endBeforeStart => 'Tarikh tamat tidak boleh sebelum tarikh mula';

  @override
  String get legendPeriod => 'Haid';

  @override
  String get legendPredicted => 'Jangkaan haid';

  @override
  String get legendFertile => 'Tempoh subur';

  @override
  String get legendOvulation => 'Ovulasi';

  @override
  String avgCycle(int days) {
    return 'Purata kitaran $days hari';
  }

  @override
  String avgPeriod(int days) {
    return 'Purata haid $days hari';
  }

  @override
  String get estimatesNote =>
      'Ramalan ialah anggaran, bukan fakta perubatan. Jangan bergantung padanya untuk kontrasepsi.';

  @override
  String get irregularNote =>
      'Kitaran anda sangat berbeza-beza. Ramalan mungkin kurang tepat.';

  @override
  String get dayEmpty => 'Tiada rekod pada hari ini.';

  @override
  String get logPeriodThisDay => 'Log haid bermula hari ini';

  @override
  String get pregnancyTimeline => 'Garis masa kehamilan';

  @override
  String milestoneWeek(int week) {
    return 'Minggu $week';
  }

  @override
  String get ms_firstTrimesterEnds => 'Trimester pertama tamat';

  @override
  String get ms_halfway => 'Separuh jalan';

  @override
  String get ms_thirdTrimester => 'Trimester ketiga bermula';

  @override
  String get ms_fullTerm => 'Cukup bulan';

  @override
  String get ms_dueDate => 'Tarikh jangka bersalin';

  @override
  String get calorieTarget => 'Sasaran harian';

  @override
  String get consumed => 'Diambil';

  @override
  String get remaining => 'Baki';

  @override
  String overBy(int kcal) {
    return 'Melebihi $kcal kcal';
  }

  @override
  String kcalValue(int kcal) {
    return '$kcal kcal';
  }

  @override
  String get meal_breakfast => 'Sarapan';

  @override
  String get meal_lunch => 'Makan tengah hari';

  @override
  String get meal_dinner => 'Makan malam';

  @override
  String get meal_snack => 'Snek';

  @override
  String get meal_drink => 'Minuman';

  @override
  String get addFood => 'Tambah makanan';

  @override
  String get foodName => 'Nama makanan';

  @override
  String get portion => 'Hidangan (pilihan)';

  @override
  String get caloriesKcal => 'Kalori (kcal)';

  @override
  String get proteinG => 'Protein (g)';

  @override
  String get carbsG => 'Karbohidrat (g)';

  @override
  String get fatG => 'Lemak (g)';

  @override
  String macros(String p, String c, String f) {
    return 'Protein $p g · Karbohidrat $c g · Lemak $f g';
  }

  @override
  String get targetEstimateNote =>
      'Sasaran ini ialah anggaran daripada profil anda, bukan preskripsi perubatan. Doktor atau pakar diet anda boleh menetapkan sasaran dalam Profil.';

  @override
  String get targetCustomNote =>
      'Sasaran ditetapkan oleh pasukan penjagaan anda.';

  @override
  String get nothingLogged => 'Tiada log';

  @override
  String get profileTitle => 'Profil';

  @override
  String get fullName => 'Nama penuh';

  @override
  String get dateOfBirth => 'Tarikh lahir';

  @override
  String get heightCm => 'Tinggi (cm)';

  @override
  String get preWeightKg => 'Berat sebelum hamil (kg)';

  @override
  String get pregnantQuestion => 'Adakah anda sedang hamil?';

  @override
  String get yes => 'Ya';

  @override
  String get no => 'Tidak';

  @override
  String get expectedDueDate => 'Tarikh jangka bersalin';

  @override
  String get numberOfBabies => 'Bilangan bayi';

  @override
  String get activityLevel => 'Tahap aktiviti';

  @override
  String get act_low => 'Rendah';

  @override
  String get act_light => 'Ringan';

  @override
  String get act_moderate => 'Sederhana';

  @override
  String get act_high => 'Tinggi';

  @override
  String get customCalorieTarget =>
      'Sasaran kalori daripada pasukan penjagaan (kcal, pilihan)';

  @override
  String get role => 'Peranan';

  @override
  String get rolePatient => 'Pesakit';

  @override
  String get roleDoctor => 'Doktor / Pentadbir';

  @override
  String get language => 'Bahasa';

  @override
  String get saveProfile => 'Simpan profil';

  @override
  String get selectDate => 'Pilih tarikh';

  @override
  String get privacyNote =>
      'Dalam versi awal ini, data anda disimpan hanya pada peranti ini dan belum disulitkan. Jangan masukkan data pesakit sebenar.';

  @override
  String get doctorDashboard => 'Papan pemuka doktor';

  @override
  String get totalPatients => 'Pesakit';

  @override
  String get todaysAppointments => 'Temu janji hari ini';

  @override
  String get alertsToReview => 'Amaran untuk disemak';

  @override
  String get patients => 'Pesakit';

  @override
  String get searchPatients => 'Cari mengikut nama, ID atau telefon';

  @override
  String get doctorDemoNote =>
      'Data demo. Rekod pesakit akan datang dari pelayan klinik dalam langkah seterusnya.';

  @override
  String get noMatches => 'Tiada pesakit sepadan';
}
