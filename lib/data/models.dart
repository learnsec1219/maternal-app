/// Plain records for the demo build. Everything belongs to a person by
/// [personId] so the doctor view can read the same lists.
library;

enum Journey { pregnancy, postpartum, general }

enum UserRole { patient, doctor }

enum ObsType { bp, hr, glu, temp, weight, spo2, water, sleep, steps, mood }

enum GlucoseContext { fasting, after, random }

enum Flow { none, spotting, light, medium, heavy }

enum Meal { breakfast, lunch, dinner, snack, drink }

enum ActivityLevel { sedentary, light, moderate, active }

enum DocCategory {
  bloodTest,
  ultrasound,
  hospital,
  prescription,
  vaccination,
  other,
}

enum Appearance { light, dark, system }

class Profile {
  Profile({
    required this.id,
    required this.name,
    required this.journey,
    this.role = UserRole.patient,
    this.email,
    this.dob,
    this.phone,
    this.height,
    this.weight,
    this.activity = ActivityLevel.light,
    this.blood,
    this.allergies,
    this.emergency,
    this.due,
    this.babies = 1,
    this.journeyStart,
    this.gp,
    this.history,
    this.risks,
    this.clinicianTarget,
  });

  final String id;
  String name;
  UserRole role;
  String? email;
  DateTime? dob;
  String? phone;
  double? height, weight;
  ActivityLevel activity;
  String? blood, allergies, emergency;
  Journey journey;
  DateTime? due;
  int babies;
  DateTime? journeyStart;
  String? gp, history, risks;
  int? clinicianTarget;
}

class Observation {
  Observation(
    this.personId,
    this.at,
    this.type,
    this.value, {
    this.value2,
    this.ctx,
    this.note,
  });
  final String personId;
  final DateTime at;
  final ObsType type;
  final double value;
  final double? value2;
  final GlucoseContext? ctx;
  final String? note;
}

class Kick {
  Kick(this.personId, this.at);
  final String personId;
  final DateTime at;
}

class Contraction {
  Contraction(this.personId, this.start, this.end);
  final String personId;
  final DateTime start, end;
  Duration get length => end.difference(start);
}

class Scan {
  Scan(
    this.personId,
    this.date,
    this.gaDays,
    this.type,
    this.measures, {
    this.percentile,
    this.presentation,
  });
  final String personId;
  final DateTime date;
  final int gaDays;
  final String type;
  final Map<String, double> measures;
  final double? percentile;
  final String? presentation;
}

class Milestone {
  Milestone(this.personId, this.date, this.title);
  final String personId;
  final DateTime date;
  final String title;
}

class PeriodDay {
  PeriodDay(this.personId, this.date, this.flow);
  final String personId;
  final DateTime date;
  Flow flow;
}

class FoodEntry {
  FoodEntry(
    this.personId,
    this.at,
    this.meal,
    this.name,
    this.kcal, {
    this.protein = 0,
    this.carbs = 0,
    this.fat = 0,
    this.portion,
  });
  final String personId;
  final DateTime at;
  final Meal meal;
  final String name;
  final String? portion;
  final double kcal, protein, carbs, fat;
}

class VaccineRecord {
  VaccineRecord(this.personId, this.date, this.name, {this.key, this.place});
  final String personId;
  final DateTime date;
  final String name;
  final String? key, place;
}

/// A vaccine the clinic offers, with its description and price.
class VaccineOffer {
  VaccineOffer({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.clinic,
    this.key,
    this.demo = true,
  });
  final String id;
  String name, description, clinic;
  double price;
  String? key;
  final bool demo;
}

class Appointment {
  Appointment(this.personId, this.at, this.doctor, this.clinic, this.purpose);
  final String personId;
  final DateTime at;
  final String doctor, clinic, purpose;
}

class Medication {
  Medication(this.id, this.personId, this.name, this.dose, this.times);
  final String id, personId, name, dose;
  final List<String> times;
}

class Intake {
  Intake(this.personId, this.medId, this.slot, this.date);
  final String personId, medId, slot;
  final DateTime date;
}

class SymptomEntry {
  SymptomEntry(
    this.personId,
    this.at,
    this.code,
    this.severity, {
    this.warning = false,
  });
  final String personId;
  final DateTime at;
  final String code;
  final int severity;
  final bool warning;
}

class MedicalDocument {
  MedicalDocument(
    this.personId,
    this.date,
    this.category,
    this.title, {
    this.description = '',
    required this.by,
  });
  final String personId;
  final DateTime date;
  final DocCategory category;
  final String title, description, by;
}

class DayNote {
  DayNote(this.personId, this.date, this.text);
  final String personId;
  final DateTime date;
  final String text;
}

enum LinkState { active, pending, revoked }
