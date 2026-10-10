import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:maternal/app.dart';
import 'package:maternal/core/storage/local_store.dart';
import 'package:maternal/core/util/clock.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> pumpApp(
  WidgetTester tester, {
  Map<String, Object> prefs = const {},
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final sp = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sp),
        todayProvider.overrideWithValue(DateTime(2026, 10, 6)),
      ],
      child: const MaternalApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() => initializeDateFormatting());

  testWidgets('shows the five-tab navigation and switches tabs', (
    tester,
  ) async {
    await pumpApp(tester);
    for (final label in ['Home', 'Calendar', 'Create', 'Calories', 'Profile']) {
      expect(find.text(label), findsWidgets);
    }
    await tester.tap(find.text('Calories').last);
    await tester.pumpAndSettle();
    expect(find.text('Daily target'), findsOneWidget);
  });

  testWidgets('Create opens the action sheet', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    expect(find.text('What would you like to add?'), findsOneWidget);
    expect(find.text('Health log'), findsOneWidget);
  });

  testWidgets('language bubble switches between all four languages', (
    tester,
  ) async {
    await pumpApp(tester);

    Future<void> pick(String code) async {
      await tester.tap(find.byKey(const Key('language-switcher')));
      // The water keeps rippling while open, so pump past the opening only.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 800));
      await tester.tap(find.byKey(Key('language-$code')));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('language-$code')), findsNothing);
    }

    await pick('ms');
    expect(find.text('Utama'), findsWidgets);
    await pick('ta');
    expect(find.text('முகப்பு'), findsWidgets);
    await pick('zh');
    expect(find.text('首頁'), findsWidgets);
    await pick('en');
    expect(find.text('Home'), findsWidgets);
  });

  testWidgets('tapping outside closes the language bubble', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byKey(const Key('language-switcher')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.byKey(const Key('language-ta')), findsOneWidget);
    await tester.tapAt(const Offset(20, 500));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('language-ta')), findsNothing);
    expect(find.text('Home'), findsWidgets);
  });

  testWidgets('pregnant profile shows gestational age on Home', (tester) async {
    await pumpApp(
      tester,
      prefs: {
        'profile': '{"name":"Aisha Tan","isPregnant":true,"dueDate":"2026-11-27T00:00:00.000","babies":1}',
      },
    );
    expect(find.text('Hello, Aisha'), findsOneWidget);
    expect(find.text('32 weeks 4 days'), findsOneWidget);
    expect(find.text('52 days to go'), findsOneWidget);
  });

  testWidgets('doctor role shows the doctor dashboard', (tester) async {
    await pumpApp(tester, prefs: {'profile': '{"role":"doctor"}'});
    expect(find.text('Doctor dashboard'), findsOneWidget);
    expect(find.text('Demo Patient A'), findsOneWidget);
  });
}
