import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:maternal/app.dart';
import 'package:maternal/core/content/clinical_content.dart';
import 'package:maternal/core/integrations/watch_service.dart';
import 'package:maternal/core/storage/local_store.dart';
import 'package:maternal/core/util/clock.dart';
import 'package:shared_preferences/shared_preferences.dart';

final testToday = DateTime(2026, 10, 6);

ClinicalContent loadContent() => ClinicalContent(
  jsonDecode(File('assets/content/clinical_content.json').readAsStringSync())
      as Map<String, dynamic>,
);

/// Pumps the whole app. [signedIn] is a demo profile id (p1 Gwen, p5 Aina,
/// d1 the doctor) or null for the welcome screen.
Future<void> pumpApp(
  WidgetTester tester, {
  String? signedIn,
  String? language,
  Size size = const Size(412, 915),
  double textScale = 1,
  bool askedForWatch = true,
  Map<String, Object> prefs = const {},
  List<Override> overrides = const [],
  WatchService? watch,
}) async {
  SharedPreferences.setMockInitialValues({
    'session.personId': ?signedIn,
    'settings.locale': ?language,
    if (askedForWatch) 'watch.asked': 'yes',
    ...prefs,
  });
  final sp = await SharedPreferences.getInstance();
  tester.view.physicalSize = size * 2;
  tester.view.devicePixelRatio = 2;
  tester.platformDispatcher.textScaleFactorTestValue = textScale;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sp),
        contentProvider.overrideWithValue(loadContent()),
        todayProvider.overrideWithValue(testToday),
        watchServiceProvider.overrideWithValue(watch ?? FakeWatch()),
        ...overrides,
      ],
      child: const MaternalApp(),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> tapAndSettle(WidgetTester tester, Finder f) async {
  await tester.ensureVisible(f);
  await tester.pumpAndSettle();
  await tester.tap(f);
  await tester.pumpAndSettle();
}

/// A watch that shares heart rate, so Bluetooth pages work in tests.
class FakeWatch implements WatchService {
  final readings = StreamController<int>.broadcast();
  WatchReady ready = WatchReady.ready;
  bool prepared = false;

  @override
  Future<WatchReady> prepare() async {
    prepared = true;
    return ready;
  }

  @override
  Stream<WatchDevice> scan() => Stream.fromIterable(const [
    WatchDevice('AA:01', 'Band 8', rssi: -50, heartRate: true),
    WatchDevice('AA:02', 'Speaker', rssi: -70),
  ]);

  @override
  Future<void> stopScan() async {}

  @override
  Future<Stream<int>> connectHeartRate(String id) async {
    if (id != 'AA:01') throw const WatchUnsupported();
    return readings.stream;
  }

  @override
  Future<int?> readBattery(String id) async => 80;

  @override
  Future<void> disconnect(String id) async {}
}
