import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'test_app.dart';

void main() {
  setUpAll(() => initializeDateFormatting());

  testWidgets('starts on the welcome screen, not Home', (tester) async {
    await pumpApp(tester);
    expect(find.text('Create an account'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.textContaining('Phone'), findsNothing);
    expect(find.text('Home'), findsNothing);
  });

  testWidgets('signs in with the demo account and code', (tester) async {
    await pumpApp(tester);
    await tapAndSettle(tester, find.text('I already have an account'));
    await tester.enterText(
      find.byKey(const Key('login-id')),
      'demo.patient@example.com',
    );
    await tapAndSettle(tester, find.byKey(const Key('login-submit')));
    await tester.enterText(find.byKey(const Key('login-code')), '123456');
    await tapAndSettle(tester, find.byKey(const Key('login-submit')));
    expect(find.text('Hi, Gwen'), findsOneWidget);
    expect(find.text('32 weeks 4 days'), findsOneWidget);
  });

  testWidgets('a wrong code is refused', (tester) async {
    await pumpApp(tester);
    await tapAndSettle(tester, find.text('I already have an account'));
    await tester.enterText(
      find.byKey(const Key('login-id')),
      'demo.patient@example.com',
    );
    await tapAndSettle(tester, find.byKey(const Key('login-submit')));
    await tester.enterText(find.byKey(const Key('login-code')), '000000');
    await tapAndSettle(tester, find.byKey(const Key('login-submit')));
    expect(
      find.text('That code is not right. Please check and try again.'),
      findsOneWidget,
    );
    expect(find.text('Hi, Gwen'), findsNothing);
  });

  testWidgets('Create shows the grouped actions', (tester) async {
    await pumpApp(tester, signedIn: 'p1');
    await tapAndSettle(tester, find.byKey(const Key('nav-create')));
    for (final t in [
      'Health',
      'Pregnancy',
      'Care',
      'Nutrition',
      'Health log',
      'Symptoms',
      'Medication',
      'Kick counter',
      'Contractions',
      'Scan results',
      'Milestone',
      'Appointment',
      'Vaccine',
      'Document',
      'Food',
      'Water',
    ]) {
      expect(find.text(t), findsWidgets, reason: t);
    }
  });

  testWidgets('tapping a calendar date adds a note for that day', (
    tester,
  ) async {
    await pumpApp(tester, signedIn: 'p5');
    await tapAndSettle(tester, find.text('Calendar').last);
    for (final t in [
      'Period',
      'Appointment',
      'Health log',
      'Medication taken',
      'Symptoms',
    ]) {
      expect(
        find.descendant(
          of: find.byKey(const Key('calendar-legend')),
          matching: find.text(t),
        ),
        findsOneWidget,
        reason: t,
      );
    }
    await tapAndSettle(tester, find.byKey(const Key('day-2026-10-6')));
    expect(find.byKey(const Key('day-sheet')), findsOneWidget);
    await tapAndSettle(tester, find.byKey(const Key('day-add-note')));
    await tester.enterText(
      find.byKey(const Key('note-text')),
      'Felt tired after work',
    );
    await tapAndSettle(tester, find.byKey(const Key('note-save')));
    expect(find.text('• Felt tired after work'), findsOneWidget);
  });

  testWidgets('pregnancy timeline shows the path with a Today marker', (
    tester,
  ) async {
    await pumpApp(tester, signedIn: 'p1');
    await tapAndSettle(tester, find.text('Calendar').last);
    expect(find.byKey(const Key('timeline-today')), findsOneWidget);
    expect(find.text('Due date'), findsOneWidget);
  });

  testWidgets('profile has dark mode and signs out', (tester) async {
    await pumpApp(tester, signedIn: 'p1');
    await tapAndSettle(tester, find.text('Profile').last);
    await tapAndSettle(tester, find.text('Appearance'));
    await tapAndSettle(tester, find.text('Dark'));
    final ctx = tester.element(find.text('Dark'));
    expect(Theme.of(ctx).brightness, Brightness.dark);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tapAndSettle(tester, find.byKey(const Key('sign-out')));
    await tapAndSettle(tester, find.byKey(const Key('sign-out-confirm')));
    expect(find.text('Create an account'), findsOneWidget);
  });

  testWidgets('language bubble switches between all four languages', (
    tester,
  ) async {
    await pumpApp(tester, signedIn: 'p1');

    Future<void> pick(String code) async {
      await tester.tap(find.byKey(const Key('language-switcher')).first);
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

  testWidgets('doctor sees the dashboard', (tester) async {
    await pumpApp(tester, signedIn: 'd1');
    expect(find.text('Good day, Dr. Chua Wang Ching (Arlies)'), findsOneWidget);
    expect(find.text('Alerts to review'), findsWidgets);
  });
}
