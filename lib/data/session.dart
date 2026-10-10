import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/storage/local_store.dart';
import 'demo_store.dart';
import 'models.dart';

/// Who is signed in, by profile id. Null means the welcome screen shows.
final sessionProvider = NotifierProvider<SessionController, String?>(
  SessionController.new,
);

class SessionController extends Notifier<String?> {
  static const _key = 'session.personId';

  @override
  String? build() {
    final id = ref.read(localStoreProvider).readString(_key);
    // Only demo accounts survive a restart; new sign-ups live in memory.
    if (id == null || id.isEmpty) return null;
    return ref.read(demoStoreProvider).profiles.containsKey(id) ? id : null;
  }

  void signIn(String personId) {
    state = personId;
    ref.read(localStoreProvider).writeString(_key, personId);
  }

  void signOut() {
    state = null;
    ref.read(localStoreProvider).writeString(_key, '');
  }
}

/// The signed-in person's profile.
final meProvider = Provider<Profile?>((ref) {
  final id = ref.watch(sessionProvider);
  if (id == null) return null;
  return ref.watch(demoStoreProvider).profiles[id];
});

/// Light (default), Dark, or follow the phone.
final appearanceProvider = NotifierProvider<AppearanceController, Appearance>(
  AppearanceController.new,
);

class AppearanceController extends Notifier<Appearance> {
  static const _key = 'settings.appearance';

  @override
  Appearance build() {
    final raw = ref.read(localStoreProvider).readString(_key);
    return Appearance.values.firstWhere(
      (a) => a.name == raw,
      orElse: () => Appearance.light,
    );
  }

  void set(Appearance a) {
    state = a;
    ref.read(localStoreProvider).writeString(_key, a.name);
  }
}

extension AppearanceMode on Appearance {
  ThemeMode get themeMode => switch (this) {
    Appearance.light => ThemeMode.light,
    Appearance.dark => ThemeMode.dark,
    Appearance.system => ThemeMode.system,
  };
}
