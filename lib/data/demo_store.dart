import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/util/clock.dart';
import '../core/util/dates.dart';
import 'demo_seed.dart';
import 'models.dart';

/// The demo doctor shown everywhere in the demo build.
abstract final class DemoDoctor {
  static const id = 'd1';
  static const name = 'Dr. Chua Wang Ching (Arlies)';
  static const clinic = 'KPJ Sentosa KL';
  static const phone = '+60 3-0000 0000';
  static const mmc = 'DEMO-00000';
}

/// Demo sign-in accounts and the one-time code that works for all of them.
abstract final class DemoAccounts {
  static const code = '123456';
  static const patient = 'demo.patient@example.com';
  static const cycle = 'demo.cycle@example.com';
  static const doctor = 'demo.doctor@example.com';
}

/// All demo records. Lists are shared; [rev] changes on every edit so
/// widgets watching the store rebuild.
class DemoData {
  DemoData({
    required this.profiles,
    required this.links,
    required this.obs,
    required this.kicks,
    required this.contractions,
    required this.scans,
    required this.milestones,
    required this.periods,
    required this.foods,
    required this.vaccines,
    required this.offers,
    required this.appointments,
    required this.meds,
    required this.intakes,
    required this.symptoms,
    required this.documents,
    required this.notes,
    this.wearableConnected = false,
    this.rev = 0,
  });

  final Map<String, Profile> profiles;
  final Map<String, LinkState> links;
  final List<Observation> obs;
  final List<Kick> kicks;
  final List<Contraction> contractions;
  final List<Scan> scans;
  final List<Milestone> milestones;
  final List<PeriodDay> periods;
  final List<FoodEntry> foods;
  final List<VaccineRecord> vaccines;
  final List<VaccineOffer> offers;
  final List<Appointment> appointments;
  final List<Medication> meds;
  final List<Intake> intakes;
  final List<SymptomEntry> symptoms;
  final List<MedicalDocument> documents;
  final List<DayNote> notes;
  bool wearableConnected;
  final int rev;

  DemoData bumped() => DemoData(
    profiles: profiles,
    links: links,
    obs: obs,
    kicks: kicks,
    contractions: contractions,
    scans: scans,
    milestones: milestones,
    periods: periods,
    foods: foods,
    vaccines: vaccines,
    offers: offers,
    appointments: appointments,
    meds: meds,
    intakes: intakes,
    symptoms: symptoms,
    documents: documents,
    notes: notes,
    wearableConnected: wearableConnected,
    rev: rev + 1,
  );

  Profile? profileByEmail(String email) {
    for (final p in profiles.values) {
      if (p.email?.toLowerCase() == email.toLowerCase()) return p;
    }
    return null;
  }

  /// The records of one person, newest first where it matters to callers.
  List<T> of<T extends Object>(List<T> list, String personId) => [
    for (final x in list)
      if (_owner(x) == personId) x,
  ];

  static String _owner(Object x) => switch (x) {
    Observation o => o.personId,
    Kick k => k.personId,
    Contraction c => c.personId,
    Scan s => s.personId,
    Milestone m => m.personId,
    PeriodDay p => p.personId,
    FoodEntry f => f.personId,
    VaccineRecord v => v.personId,
    Appointment a => a.personId,
    Medication m => m.personId,
    Intake i => i.personId,
    SymptomEntry s => s.personId,
    MedicalDocument d => d.personId,
    DayNote n => n.personId,
    _ => '',
  };
}

final demoStoreProvider = NotifierProvider<DemoStore, DemoData>(DemoStore.new);

/// In-memory demo database. Data resets when the app restarts, as the
/// demo banner says; a real build replaces this with the backend.
class DemoStore extends Notifier<DemoData> {
  @override
  DemoData build() => seedDemoData(ref.read(todayProvider), DateTime.now());

  void _edit(void Function(DemoData d) change) {
    change(state);
    state = state.bumped();
  }

  void addObservation(Observation o) => _edit((d) => d.obs.add(o));
  void addKick(Kick k) => _edit((d) => d.kicks.add(k));
  void removeKick(Kick k) => _edit((d) => d.kicks.remove(k));
  void addContraction(Contraction c) => _edit((d) => d.contractions.add(c));
  void addScan(Scan s) => _edit((d) => d.scans.add(s));
  void addMilestone(Milestone m) => _edit((d) => d.milestones.add(m));
  void addFood(FoodEntry f) => _edit((d) => d.foods.add(f));
  void addVaccine(VaccineRecord v) => _edit((d) => d.vaccines.add(v));
  void addAppointment(Appointment a) => _edit((d) => d.appointments.add(a));
  void addSymptom(SymptomEntry s) => _edit((d) => d.symptoms.add(s));
  void addDocument(MedicalDocument m) => _edit((d) => d.documents.add(m));
  void addNote(DayNote n) => _edit((d) => d.notes.add(n));
  void addProfile(Profile p, {LinkState link = LinkState.active}) => _edit((d) {
    d.profiles[p.id] = p;
    if (p.role == UserRole.patient) d.links[p.id] = link;
  });
  void updateProfile(Profile p) => _edit((d) => d.profiles[p.id] = p);
  void setLink(String personId, LinkState state) =>
      _edit((d) => d.links[personId] = state);
  void setWearable(bool on) => _edit((d) => d.wearableConnected = on);

  void setPeriod(String personId, DateTime day, Flow flow) => _edit((d) {
    d.periods.removeWhere(
      (x) => x.personId == personId && isSameDay(x.date, day),
    );
    d.periods.add(PeriodDay(personId, dateOnly(day), flow));
  });

  void takeDose(String personId, String medId, String slot, DateTime day) =>
      _edit((d) => d.intakes.add(Intake(personId, medId, slot, dateOnly(day))));

  void saveOffer(VaccineOffer o) => _edit((d) {
    d.offers.removeWhere((x) => x.id == o.id);
    d.offers.add(o);
  });

  void deleteOffer(String id) =>
      _edit((d) => d.offers.removeWhere((x) => x.id == id));
}
