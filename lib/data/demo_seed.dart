import '../core/util/dates.dart';
import 'demo_store.dart';
import 'models.dart';

/// Demo records, all relative to [today] so the demo always looks current.
/// Every person is clearly a demo account.
DemoData seedDemoData(DateTime today, DateTime now) {
  DateTime at(DateTime d, int h, [int m = 0]) =>
      DateTime(d.year, d.month, d.day, h, m);
  final due = addDays(today, 52);
  final lmp = addDays(due, -280);
  const gwen = 'p1', aina = 'p5';

  final profiles = <String, Profile>{
    gwen: Profile(
      id: gwen,
      name: 'Gwen',
      email: DemoAccounts.patient,
      dob: DateTime(1993, 5, 14),
      phone: '+60120000001',
      height: 160,
      weight: 62,
      activity: ActivityLevel.light,
      blood: 'O Rh+',
      allergies: 'Penicillin',
      emergency: 'Demo Partner (Husband) +60120000002',
      journey: Journey.pregnancy,
      due: due,
      journeyStart: lmp,
      gp: 'G3 P1+1',
      history: 'Gestational diabetes in this pregnancy (diet and metformin).',
      risks: 'Gestational diabetes',
    ),
    'p2': Profile(
      id: 'p2',
      name: 'Demo Patient B',
      dob: DateTime(1997, 2, 3),
      blood: 'A Rh+',
      journey: Journey.pregnancy,
      due: addDays(today, 140),
      babies: 2,
      gp: 'G1 P0',
    ),
    'p3': Profile(
      id: 'p3',
      name: 'Demo Patient C',
      dob: DateTime(1990, 11, 21),
      journey: Journey.postpartum,
      journeyStart: addDays(today, -42),
      gp: 'G2 P2',
    ),
    'p4': Profile(
      id: 'p4',
      name: 'Demo Patient D',
      dob: DateTime(1999, 8, 9),
      journey: Journey.pregnancy,
      due: addDays(today, 210),
      gp: 'G1 P0',
    ),
    aina: Profile(
      id: aina,
      name: 'Aina',
      email: DemoAccounts.cycle,
      dob: DateTime(1996, 4, 2),
      phone: '+60120000006',
      height: 158,
      weight: 55,
      activity: ActivityLevel.moderate,
      blood: 'A Rh+',
      allergies: 'None known',
      journey: Journey.general,
      journeyStart: addDays(today, -400),
      gp: 'G0 P0',
    ),
    DemoDoctor.id: Profile(
      id: DemoDoctor.id,
      name: DemoDoctor.name,
      email: DemoAccounts.doctor,
      role: UserRole.doctor,
      journey: Journey.general,
    ),
  };

  final periods = <PeriodDay>[];
  final obs = <Observation>[];
  // Aina: periods every 28-30 days. She is on day 3 of her current period.
  var start = addDays(today, -2);
  const gaps = [29, 28, 30, 29, 28, 30, 29, 28];
  const flows = [Flow.medium, Flow.heavy, Flow.medium, Flow.light, Flow.light];
  for (var c = 0; c <= gaps.length; c++) {
    final days = c == 0 ? 3 : 5;
    for (var d = 0; d < days; d++) {
      periods.add(PeriodDay(aina, addDays(start, d), flows[d]));
    }
    if (c < gaps.length) start = addDays(start, -gaps[c]);
  }
  for (var b = 6; b >= 0; b -= 2) {
    obs.add(
      Observation(
        aina,
        at(addDays(today, -b), 8),
        ObsType.weight,
        55.2 - b * 0.05,
      ),
    );
  }
  // Gwen's periods before this pregnancy.
  var st = addDays(lmp, -143);
  for (final len in const [29, 27, 30, 28, 29, 0]) {
    const f = [Flow.heavy, Flow.heavy, Flow.medium, Flow.light, Flow.light];
    for (var d = 0; d < 5; d++) {
      periods.add(PeriodDay(gwen, addDays(st, d), f[d]));
    }
    if (len == 0) break;
    st = addDays(st, len);
  }
  for (var back = 20; back >= 0; back--) {
    final day = addDays(today, -back);
    final w = (back * 7) % 5;
    if (back.isEven) {
      obs.add(
        Observation(
          gwen,
          at(day, 8),
          ObsType.bp,
          back > 0 ? 112.0 + w * 2 : 118,
          value2: back > 0 ? 70.0 + w : 76,
        ),
      );
      obs.add(
        Observation(
          gwen,
          at(day, 7),
          ObsType.glu,
          back > 0 ? 4.6 + w / 10 : 4.9,
          ctx: GlucoseContext.fasting,
        ),
      );
    }
    obs.add(
      Observation(
        gwen,
        at(day, 8, 5),
        ObsType.hr,
        back > 0 ? 76.0 + w * 2 : 78,
      ),
    );
    obs.add(Observation(gwen, at(day, 6, 30), ObsType.sleep, 6.5 + w / 4));
    if (back > 0) {
      obs.add(Observation(gwen, at(day, 21), ObsType.steps, 3200.0 + w * 900));
    }
    if (back % 7 == 0) {
      obs.add(
        Observation(
          gwen,
          at(day, 7, 30),
          ObsType.weight,
          68.2 - back / 7 * 0.5,
        ),
      );
    }
    if (back % 5 == 0) {
      obs.add(Observation(gwen, at(day, 8, 10), ObsType.spo2, 98));
    }
  }

  final kicks = [
    for (final m in const [300, 290, 120, 40, 25, 10])
      Kick(gwen, now.subtract(Duration(minutes: m))),
  ];

  Scan scan(
    int g,
    String type,
    Map<String, double> m, {
    double? pct,
    String? pres,
  }) => Scan(
    gwen,
    addDays(lmp, g),
    g,
    type,
    m,
    percentile: pct,
    presentation: pres,
  );
  final scans = [
    scan(58, 'Dating scan', {'crl': 17, 'fhr': 165}),
    scan(91, 'Nuchal scan', {'crl': 62, 'nt': 1.6, 'fhr': 158}),
    scan(141, 'Anomaly scan', {
      'bpd': 47,
      'hc': 175,
      'ac': 150,
      'fl': 32,
      'efw': 330,
      'afi': 13.5,
      'fhr': 148,
    }, pres: 'Variable'),
    scan(
      224,
      'Growth scan',
      {
        'bpd': 81,
        'hc': 295,
        'ac': 280,
        'fl': 61,
        'efw': 1900,
        'afi': 14.2,
        'fhr': 140,
      },
      pct: 55,
      pres: 'Cephalic',
    ),
  ];

  Appointment appt(String p, DateTime when, String purpose) =>
      Appointment(p, when, DemoDoctor.name, DemoDoctor.clinic, purpose);
  final appointments = [
    appt(gwen, at(addDays(today, 1), 10, 30), 'Antenatal review'),
    appt(gwen, at(addDays(today, 14), 9), 'Growth scan'),
    appt(gwen, at(addDays(lmp, 224), 9), 'Growth scan'),
    appt(gwen, at(addDays(lmp, 141), 11), 'Anomaly scan'),
    appt('p2', at(today, 14), 'Blood pressure review'),
    appt('p3', at(addDays(today, 3), 11), 'Postnatal check'),
    appt(aina, at(addDays(today, 6), 15), 'Well-woman check'),
  ];

  VaccineOffer offer(
    String id,
    String name,
    String desc,
    double price, [
    String? key,
  ]) => VaccineOffer(
    id: id,
    name: name,
    description: desc,
    price: price,
    clinic: DemoDoctor.clinic,
    key: key,
  );

  final foods = <FoodEntry>[];
  for (var back = 10; back >= 1; back--) {
    final day = addDays(today, -back);
    final w = (back * 3) % 4;
    foods.addAll([
      FoodEntry(
        gwen,
        at(day, 7, 30),
        Meal.breakfast,
        'Oats with milk',
        320,
        protein: 12,
        carbs: 52,
        fat: 7,
      ),
      FoodEntry(
        gwen,
        at(day, 12, 30),
        Meal.lunch,
        'Chicken rice',
        520.0 + w * 30,
        protein: 28,
        carbs: 70,
        fat: 14,
      ),
      FoodEntry(
        gwen,
        at(day, 16),
        Meal.snack,
        'Apple',
        95,
        protein: .5,
        carbs: 25,
        fat: .3,
      ),
      FoodEntry(
        gwen,
        at(day, 19, 30),
        Meal.dinner,
        'Fish, rice and vegetables',
        610.0 + w * 40,
        protein: 35,
        carbs: 72,
        fat: 16,
      ),
      FoodEntry(
        gwen,
        at(day, 20, 30),
        Meal.drink,
        'Low-fat milk',
        130,
        protein: 9,
        carbs: 12,
        fat: 5,
      ),
    ]);
  }
  foods.addAll([
    FoodEntry(
      gwen,
      at(today, 7, 30),
      Meal.breakfast,
      'Wholemeal bread and egg',
      310,
      protein: 16,
      carbs: 30,
      fat: 13,
    ),
    FoodEntry(
      gwen,
      at(today, 12, 30),
      Meal.lunch,
      'Nasi lemak, small',
      520,
      protein: 14,
      carbs: 62,
      fat: 24,
    ),
  ]);

  return DemoData(
    profiles: profiles,
    links: {
      gwen: LinkState.active,
      'p2': LinkState.active,
      'p3': LinkState.active,
      'p4': LinkState.pending,
      aina: LinkState.active,
    },
    obs: [
      ...obs,
      Observation('p2', at(addDays(today, -3), 9), ObsType.bp, 138, value2: 88),
      Observation('p2', at(addDays(today, -1), 9), ObsType.bp, 146, value2: 94),
      Observation(
        'p3',
        at(addDays(today, -2), 10),
        ObsType.bp,
        116,
        value2: 74,
      ),
    ],
    kicks: kicks,
    contractions: [],
    scans: scans,
    milestones: [Milestone(gwen, addDays(lmp, 133), 'Felt first movements')],
    periods: periods,
    foods: foods,
    vaccines: [
      VaccineRecord(
        gwen,
        addDays(lmp, 150),
        'Influenza (flu)',
        key: 'influenza',
        place: DemoDoctor.clinic,
      ),
    ],
    offers: [
      offer(
        'vx-tdap',
        'Tdap (whooping cough)',
        'Protects you against tetanus, diphtheria and whooping cough, and passes antibodies to your baby so she is protected in her first months, before her own vaccines.',
        120,
        'tdap',
      ),
      offer(
        'vx-flu',
        'Influenza (flu)',
        'Lowers the chance of serious flu for you during pregnancy and for your baby after birth. Safe in any trimester.',
        75,
        'influenza',
      ),
      offer(
        'vx-rsv',
        'RSV vaccine',
        'Helps protect your newborn from RSV, a common cause of chest infections in babies, through antibodies you pass on in pregnancy.',
        1050,
        'rsv',
      ),
      offer(
        'vx-covid',
        'COVID-19',
        'Reduces the risk of severe COVID-19 for you, which lowers the risk of complications in pregnancy.',
        95,
        'covid19',
      ),
      offer(
        'vx-hpv',
        'HPV (Gardasil 9)',
        'Protects against the HPV types that cause most cervical cancers and genital warts. Usually given as 2 or 3 doses, not during pregnancy.',
        650,
      ),
      offer(
        'vx-hepb',
        'Hepatitis B',
        'Protects your liver against hepatitis B infection. Given as 3 doses over 6 months.',
        60,
      ),
    ],
    appointments: appointments,
    meds: [
      Medication('m1', gwen, 'Metformin', '500 mg', const ['08:00', '20:00']),
      Medication('m2', gwen, 'Prenatal multivitamin', '1 tablet', const [
        '08:00',
      ]),
      Medication('m3', gwen, 'Folic acid', '5 mg', const ['08:00']),
    ],
    intakes: [Intake(gwen, 'm2', '08:00', today)],
    symptoms: [
      SymptomEntry(gwen, at(addDays(today, -1), 21), 'back_pain', 1),
      SymptomEntry(gwen, at(addDays(today, -3), 22), 'heartburn', 2),
    ],
    documents: [
      MedicalDocument(
        gwen,
        addDays(lmp, 196),
        DocCategory.bloodTest,
        'Full blood count',
        description: 'Hb 11.2 g/dL (demo)',
        by: 'Gwen',
      ),
      MedicalDocument(
        gwen,
        addDays(lmp, 141),
        DocCategory.ultrasound,
        'Anomaly scan report',
        description: 'Structurally normal survey (demo)',
        by: DemoDoctor.name,
      ),
    ],
    notes: [],
  );
}
