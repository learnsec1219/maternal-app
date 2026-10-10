import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models.dart';
import '../../data/session.dart';
import '../auth/welcome_screen.dart';
import '../doctor/doctor_shell.dart';
import 'patient_shell.dart';

/// Nobody reaches Home without signing in: the welcome screen shows until a
/// session exists, then the patient or doctor app.
class RootGate extends ConsumerWidget {
  const RootGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(meProvider);
    if (me == null) return const WelcomeScreen();
    return me.role == UserRole.doctor
        ? const DoctorShell(key: ValueKey('doctor'))
        : PatientShell(key: ValueKey('patient-${me.id}'));
  }
}
