import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'test_app.dart';

/// Every main screen on a small phone with large text, in every language.
/// Any "BOTTOM OVERFLOWED" or other layout overflow fails the test.
void main() {
  setUpAll(() => initializeDateFormatting());

  const small = Size(320, 568);
  for (final lang in ['en', 'ms', 'zh', 'ta']) {
    for (final who in ['p1', 'p5']) {
      testWidgets('patient $who screens fit on a small phone ($lang)', (
        tester,
      ) async {
        await pumpApp(
          tester,
          signedIn: who,
          language: lang,
          size: small,
          textScale: 1.3,
        );
        Future<void> scrollAll(Finder list) async {
          for (var i = 0; i < 30; i++) {
            await tester.drag(list, const Offset(0, -300));
            await tester.pump();
          }
          await tester.pumpAndSettle();
        }

        await scrollAll(find.byKey(const Key('home-list')));
        await tester.tap(find.byKey(const Key('nav-create')));
        await tester.pumpAndSettle();
        await scrollAll(find.byKey(const Key('create-sheet')));
        await tester.tapAt(const Offset(10, 10));
        await tester.pumpAndSettle();

        for (final (tab, list) in [
          ('calendar', 'calendar-list'),
          ('calories', 'calories-list'),
          ('profile', 'profile-list'),
        ]) {
          await tester.tap(find.byKey(Key('nav-$tab')));
          await tester.pumpAndSettle();
          await scrollAll(find.byKey(Key(list)));
        }
        if (who == 'p1') {
          // Pregnant: also the menstrual-cycle tab of the calendar.
          await tester.tap(find.byKey(const Key('nav-calendar')));
          await tester.pumpAndSettle();
          await tester.tap(find.byKey(const Key('tab-1')));
          await tester.pumpAndSettle();
          await scrollAll(find.byKey(const Key('calendar-list')));
        }
      });
    }

    testWidgets('welcome and doctor screens fit on a small phone ($lang)', (
      tester,
    ) async {
      await pumpApp(tester, language: lang, size: small, textScale: 1.3);
      await tester.drag(find.byType(ListView).first, const Offset(0, -2000));
      await tester.pumpAndSettle();
    });
  }

  for (final lang in ['ta', 'zh']) {
    testWidgets('every Create page fits on a small phone ($lang)', (
      tester,
    ) async {
      await pumpApp(
        tester,
        signedIn: 'p1',
        language: lang,
        size: small,
        textScale: 1.3,
      );
      for (final key in [
        'create-healthlog',
        'create-symptoms',
        'create-medication',
        'create-ai',
        'create-kicks',
        'create-contractions',
        'create-scan',
        'create-milestone',
        'create-appointment',
        'create-vaccine',
        'create-document',
        'create-food',
        'create-water',
      ]) {
        await tester.tap(find.byKey(const Key('nav-create')));
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          find.byKey(Key(key)),
          100,
          scrollable: find.descendant(
            of: find.byKey(const Key('create-sheet')),
            matching: find.byType(Scrollable),
          ),
        );
        await tester.tap(find.byKey(Key(key)));
        await tester.pumpAndSettle();
        await tester.drag(find.byType(ListView).last, const Offset(0, -3000));
        await tester.pumpAndSettle();
        await tester
            .state<NavigatorState>(find.byType(Navigator).first)
            .maybePop();
        await tester.pumpAndSettle();
      }
    });

    testWidgets(
      'profile pages and the day sheet fit on a small phone ($lang)',
      (tester) async {
        await pumpApp(
          tester,
          signedIn: 'p1',
          language: lang,
          size: small,
          textScale: 1.3,
        );
        await tester.tap(find.byKey(const Key('nav-calendar')));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key('tab-1')));
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.byKey(const Key('day-2026-10-6')));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key('day-2026-10-6')));
        await tester.pumpAndSettle();
        await tester.drag(
          find.byKey(const Key('day-sheet')),
          const Offset(0, -2000),
        );
        await tester.pumpAndSettle();
        await tester.tapAt(const Offset(10, 10));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key('nav-profile')));
        await tester.pumpAndSettle();
        final rows = find.descendant(
          of: find.byKey(const Key('profile-list')),
          matching: find.byIcon(Icons.chevron_right_rounded),
        );
        final count = rows.evaluate().length;
        for (var i = 0; i < count; i++) {
          final row = find
              .descendant(
                of: find.byKey(const Key('profile-list')),
                matching: find.byIcon(Icons.chevron_right_rounded),
              )
              .at(i);
          await tester.ensureVisible(row);
          await tester.pumpAndSettle();
          await tester.tap(row);
          await tester.pumpAndSettle();
          await tester.drag(find.byType(ListView).last, const Offset(0, -3000));
          await tester.pumpAndSettle();
          await tester
              .state<NavigatorState>(find.byType(Navigator).first)
              .maybePop();
          await tester.pumpAndSettle();
        }
      },
    );

    testWidgets('doctor screens fit on a small phone ($lang)', (tester) async {
      await pumpApp(
        tester,
        signedIn: 'd1',
        language: lang,
        size: small,
        textScale: 1.3,
      );
      for (final tab in ['dash', 'patients', 'appts', 'profile']) {
        await tester.tap(find.byKey(Key('dnav-$tab')));
        await tester.pumpAndSettle();
        await tester.drag(
          find.byType(ListView).hitTestable().first,
          const Offset(0, -3000),
        );
        await tester.pumpAndSettle();
      }
    });
  }

  for (final lang in ['en', 'zh', 'ta']) {
    testWidgets('sign-up fits on a small phone and lands on Home ($lang)', (
      tester,
    ) async {
      await pumpApp(tester, language: lang, size: small, textScale: 1.3);
      Future<void> next() async {
        final b = find.byKey(const Key('onboarding-next'));
        await tester.ensureVisible(b);
        await tester.pumpAndSettle();
        await tester.tap(b);
        await tester.pumpAndSettle();
      }

      await tester.scrollUntilVisible(find.byType(FilledButton), 200);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byIcon(Icons.person_outline_rounded).first,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.person_outline_rounded).first);
      await tester.pumpAndSettle();
      await next();
      await tester.enterText(find.byType(TextField).first, '+60123456789');
      await next();
      await tester.enterText(find.byType(TextField).last, '123456');
      await next();
      await tester.enterText(find.byType(TextField).first, 'Test Person');
      await tester.ensureVisible(find.byIcon(Icons.calendar_today_outlined));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.calendar_today_outlined));
      await tester.pumpAndSettle();
      await tester.tap(
        find
            .descendant(
              of: find.byType(Dialog),
              matching: find.byType(TextButton),
            )
            .last,
      );
      await tester.pumpAndSettle();
      await next();
      await next(); // body
      await tester.ensureVisible(find.byIcon(Icons.circle_outlined));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.circle_outlined));
      await tester.pumpAndSettle();
      await next(); // not pregnant
      await next(); // done
      expect(find.byKey(const Key('home-list')), findsOneWidget);
    });
  }
}
