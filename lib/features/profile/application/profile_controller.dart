import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/local_store.dart';
import '../../../core/util/clock.dart';
import '../../pregnancy/domain/gestation.dart';
import '../domain/user_profile.dart';

final profileProvider = NotifierProvider<ProfileController, UserProfile>(
  ProfileController.new,
);

class ProfileController extends Notifier<UserProfile> {
  static const _key = 'profile';

  @override
  UserProfile build() {
    final json = ref.read(localStoreProvider).readMap(_key);
    return json == null ? const UserProfile() : UserProfile.fromJson(json);
  }

  void save(UserProfile profile) {
    state = profile;
    ref.read(localStoreProvider).writeJson(_key, profile.toJson());
  }

  void setRole(UserRole role) => save(state.copyWith(role: role));
}

/// Gestational age today, or null when not pregnant or no due date is set.
final gestationProvider = Provider<Gestation?>((ref) {
  final profile = ref.watch(profileProvider);
  final due = profile.dueDate;
  if (!profile.isPregnant || due == null) return null;
  return Gestation.fromDueDate(due, today: ref.watch(todayProvider));
});
