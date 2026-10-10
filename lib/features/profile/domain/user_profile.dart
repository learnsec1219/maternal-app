import '../../calories/domain/calorie_target.dart';

enum UserRole { patient, doctor }

class UserProfile {
  const UserProfile({
    this.name = '',
    this.dateOfBirth,
    this.heightCm,
    this.preWeightKg,
    this.isPregnant = false,
    this.dueDate,
    this.babies = 1,
    this.activity = ActivityLevel.light,
    this.calorieTargetOverride,
    this.role = UserRole.patient,
  });

  final String name;
  final DateTime? dateOfBirth;
  final double? heightCm;
  final double? preWeightKg;
  final bool isPregnant;
  final DateTime? dueDate;
  final int babies;
  final ActivityLevel activity;

  /// Daily calorie target set by a clinician or dietitian, if any.
  final int? calorieTargetOverride;
  final UserRole role;

  int? ageOn(DateTime today) {
    final dob = dateOfBirth;
    if (dob == null) return null;
    var age = today.year - dob.year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  UserProfile copyWith({
    String? name,
    DateTime? dateOfBirth,
    double? heightCm,
    double? preWeightKg,
    bool? isPregnant,
    DateTime? dueDate,
    int? babies,
    ActivityLevel? activity,
    int? Function()? calorieTargetOverride,
    UserRole? role,
  }) => UserProfile(
    name: name ?? this.name,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    heightCm: heightCm ?? this.heightCm,
    preWeightKg: preWeightKg ?? this.preWeightKg,
    isPregnant: isPregnant ?? this.isPregnant,
    dueDate: dueDate ?? this.dueDate,
    babies: babies ?? this.babies,
    activity: activity ?? this.activity,
    calorieTargetOverride: calorieTargetOverride != null
        ? calorieTargetOverride()
        : this.calorieTargetOverride,
    role: role ?? this.role,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    if (dateOfBirth != null) 'dateOfBirth': dateOfBirth!.toIso8601String(),
    if (heightCm != null) 'heightCm': heightCm,
    if (preWeightKg != null) 'preWeightKg': preWeightKg,
    'isPregnant': isPregnant,
    if (dueDate != null) 'dueDate': dueDate!.toIso8601String(),
    'babies': babies,
    'activity': activity.name,
    if (calorieTargetOverride != null)
      'calorieTargetOverride': calorieTargetOverride,
    'role': role.name,
  };

  factory UserProfile.fromJson(Map<String, dynamic> j) {
    DateTime? date(String k) =>
        j[k] == null ? null : DateTime.tryParse(j[k] as String);
    return UserProfile(
      name: j['name'] as String? ?? '',
      dateOfBirth: date('dateOfBirth'),
      heightCm: (j['heightCm'] as num?)?.toDouble(),
      preWeightKg: (j['preWeightKg'] as num?)?.toDouble(),
      isPregnant: j['isPregnant'] as bool? ?? false,
      dueDate: date('dueDate'),
      babies: j['babies'] as int? ?? 1,
      activity:
          ActivityLevel.values.asNameMap()[j['activity']] ??
          ActivityLevel.light,
      calorieTargetOverride: j['calorieTargetOverride'] as int?,
      role: UserRole.values.asNameMap()[j['role']] ?? UserRole.patient,
    );
  }
}
