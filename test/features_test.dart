import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:maternal/core/integrations/gemini_client.dart';
import 'package:maternal/core/integrations/google_auth.dart';
import 'package:maternal/core/integrations/totp.dart';
import 'package:maternal/core/integrations/verification.dart';
import 'package:maternal/core/integrations/watch_service.dart';

import 'test_app.dart';

class FakeAssistant implements AssistantClient {
  final calls = <(String, List<ChatTurn>)>[];

  @override
  Future<String> answer({
    required String language,
    required List<ChatTurn> turns,
    String? aboutMe,
  }) async {
    calls.add((language, turns));
    return language == 'zh'
        ? '懷孕期間適量運動通常是安全的。'
        : 'Gentle exercise is usually safe.';
  }
}

class FakeVerification implements VerificationService {
  final emails = <String>[];

  @override
  Future<void> sendEmailCode(String email) async => emails.add(email);

  @override
  bool checkEmailCode(String email, String code) => code == '654321';
}

class FakeGoogle implements GoogleAuth {
  FakeGoogle(this.profile);
  final GoogleProfile? profile;
  int signOuts = 0;

  @override
  Future<GoogleProfile?> signIn() async => profile;

  @override
  Future<void> signOut() async => signOuts++;
}

void main() {
  setUpAll(() => initializeDateFormatting());

  group('authenticator codes (RFC 6238)', () {
    // The RFC's test secret, "12345678901234567890" in base32.
    const secret = 'GEZDGNBVGY3TQOJQGEZDGNBVGY3TQOJQ';

    test('match the published test vectors', () {
      DateTime at(int s) => DateTime.fromMillisecondsSinceEpoch(s * 1000);
      expect(Totp.codeAt(secret, at(59)), '287082');
      expect(Totp.codeAt(secret, at(1111111109)), '081804');
      expect(Totp.codeAt(secret, at(1234567890)), '005924');
    });

    test('accept the neighbouring 30-second window only', () {
      final now = DateTime.fromMillisecondsSinceEpoch(1111111109 * 1000);
      expect(Totp.verify(secret, '081804', now), isTrue);
      expect(
        Totp.verify(secret, '081804', now.add(const Duration(seconds: 30))),
        isTrue,
      );
      expect(
        Totp.verify(secret, '081804', now.add(const Duration(minutes: 2))),
        isFalse,
      );
    });

    test('new secrets round-trip through base32', () {
      final s = Totp.newSecret();
      expect(s.length, 32);
      expect(base32Encode(base32Decode(s)), s);
    });
  });

  test('heart-rate values are read in 8 and 16 bits', () {
    expect(parseHeartRate([0x00, 72]), 72);
    expect(parseHeartRate([0x01, 0x2c, 0x01]), 300);
    expect(parseHeartRate([0x00]), isNull);
  });

  testWidgets('kick counter shows the footprint and counts each tap', (
    tester,
  ) async {
    await pumpApp(tester, signedIn: 'p1');
    await tapAndSettle(tester, find.byKey(const Key('nav-create')));
    await tapAndSettle(tester, find.byKey(const Key('create-kicks')));
    expect(find.byKey(const Key('kick-foot')), findsOneWidget);
    expect(find.byIcon(Icons.child_care_rounded), findsNothing);
    await tester.tap(find.byKey(const Key('kick-tap')));
    await tester.pump(const Duration(milliseconds: 120));
    expect(find.text('+1'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('+1'), findsNothing);
  });

  testWidgets('AI chat answers through the AI service in the chosen language', (
    tester,
  ) async {
    final ai = FakeAssistant();
    await pumpApp(
      tester,
      signedIn: 'p1',
      overrides: [assistantClientProvider.overrideWithValue(ai)],
    );
    await tapAndSettle(tester, find.byKey(const Key('nav-create')));
    await tapAndSettle(tester, find.byKey(const Key('create-ai')));
    // No key in tests: the page says what to set up.
    expect(find.byKey(const Key('assistant-setup')), findsOneWidget);
    await tapAndSettle(tester, find.text('中文'));
    await tester.enterText(
      find.byKey(const Key('assistant-input')),
      'Is it safe to exercise?',
    );
    await tapAndSettle(tester, find.byKey(const Key('assistant-send')));
    expect(ai.calls.single.$1, 'zh');
    expect(find.text('懷孕期間適量運動通常是安全的。'), findsOneWidget);
    expect(find.text('衛教資訊'), findsOneWidget);
  });

  testWidgets('a warning sign in a question shows the urgent card', (
    tester,
  ) async {
    await pumpApp(
      tester,
      signedIn: 'p1',
      overrides: [assistantClientProvider.overrideWithValue(FakeAssistant())],
    );
    await tapAndSettle(tester, find.byKey(const Key('nav-create')));
    await tapAndSettle(tester, find.byKey(const Key('create-ai')));
    await tester.enterText(
      find.byKey(const Key('assistant-input')),
      'My baby is not moving today',
    );
    await tapAndSettle(tester, find.byKey(const Key('assistant-send')));
    expect(find.byKey(const Key('assistant-urgent')), findsOneWidget);
  });

  test('the AI rules keep to maternity topics and the chosen language', () {
    final r = assistantRules('zh', null);
    expect(r, contains('ONLY in Traditional Chinese'));
    expect(r, contains('only help with pregnancy, maternity'));
  });

  testWidgets('the cycle calendar shows predicted periods for later months', (
    tester,
  ) async {
    await pumpApp(tester, signedIn: 'p5');
    await tapAndSettle(tester, find.byKey(const Key('nav-calendar')));
    expect(find.byKey(const Key('cycle-upcoming')), findsNWidgets(3));
    await tapAndSettle(tester, find.byKey(const Key('cal-next')));
    expect(
      find.byWidgetPredicate(
        (w) =>
            w.key is ValueKey<String> &&
            (w.key! as ValueKey<String>).value.startsWith('predicted-'),
      ),
      findsWidgets,
    );
  });

  testWidgets('signs in with an authenticator app code', (tester) async {
    final secret = Totp.newSecret();
    await pumpApp(
      tester,
      prefs: {
        'auth.totpSecrets': jsonEncode({'p1': secret}),
      },
    );
    await tapAndSettle(tester, find.text('I already have an account'));
    await tester.enterText(
      find.byKey(const Key('login-id')),
      'demo.patient@example.com',
    );
    await tapAndSettle(tester, find.byKey(const Key('login-submit')));
    expect(find.text('Authenticator code'), findsOneWidget);
    await tester.enterText(
      find.byKey(const Key('login-code')),
      Totp.codeAt(secret, DateTime.now()),
    );
    await tapAndSettle(tester, find.byKey(const Key('login-submit')));
    expect(find.text('Hi, Gwen'), findsOneWidget);
  });

  testWidgets('sets up the authenticator app from Profile', (tester) async {
    await pumpApp(tester, signedIn: 'p1');
    await tapAndSettle(tester, find.byKey(const Key('nav-profile')));
    await tapAndSettle(tester, find.text('Sign-in & security'));
    await tapAndSettle(tester, find.byKey(const Key('totp-setup')));
    final shown = tester
        .widget<SelectableText>(find.byKey(const Key('totp-secret')))
        .data!;
    final secret = shown.replaceAll(' ', '');
    await tester.enterText(
      find.byKey(const Key('totp-code')),
      Totp.codeAt(secret, DateTime.now()),
    );
    await tapAndSettle(tester, find.byKey(const Key('totp-enable')));
    expect(find.byKey(const Key('totp-off')), findsOneWidget);
  });

  testWidgets('a real email code signs up a new person', (tester) async {
    final v = FakeVerification();
    await pumpApp(
      tester,
      prefs: const {
        'integration.EMAILJS_SERVICE_ID': 'service_x',
        'integration.EMAILJS_TEMPLATE_ID': 'template_x',
        'integration.EMAILJS_PUBLIC_KEY': 'public_x',
      },
      overrides: [verificationProvider.overrideWithValue(v)],
    );
    await tapAndSettle(tester, find.text('I already have an account'));
    await tester.enterText(
      find.byKey(const Key('login-id')),
      'new.mum@gmail.com',
    );
    await tapAndSettle(tester, find.byKey(const Key('login-submit')));
    expect(v.emails, ['new.mum@gmail.com']);
    expect(find.text('Code sent to new.mum@gmail.com'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('login-code')), '000000');
    await tapAndSettle(tester, find.byKey(const Key('login-submit')));
    expect(
      find.text('That code is not right. Please check and try again.'),
      findsOneWidget,
    );
    await tester.enterText(find.byKey(const Key('login-code')), '654321');
    await tapAndSettle(tester, find.byKey(const Key('login-submit')));
    // Verified with no account yet: sign-up starts with the email kept.
    expect(find.byKey(const Key('login-submit')), findsNothing);
  });

  testWidgets('first sign-in shows the Bluetooth permission box once', (
    tester,
  ) async {
    final watch = FakeWatch();
    await pumpApp(tester, signedIn: 'p1', askedForWatch: false, watch: watch);
    expect(watch.permissionAsks, 1);
    // Signing out and in again does not ask a second time.
    await tapAndSettle(tester, find.byKey(const Key('nav-profile')));
    await tester.scrollUntilVisible(
      find.byKey(const Key('sign-out')),
      300,
      scrollable: find.descendant(
        of: find.byKey(const Key('profile-list')),
        matching: find.byType(Scrollable),
      ),
    );
    await tapAndSettle(tester, find.byKey(const Key('sign-out')));
    await tapAndSettle(tester, find.byKey(const Key('sign-out-confirm')));
    await tapAndSettle(tester, find.text('I already have an account'));
    await tester.enterText(
      find.byKey(const Key('login-id')),
      'demo.patient@example.com',
    );
    await tapAndSettle(tester, find.byKey(const Key('login-submit')));
    await tester.enterText(find.byKey(const Key('login-code')), '123456');
    await tapAndSettle(tester, find.byKey(const Key('login-submit')));
    expect(find.text('Hi, Gwen'), findsOneWidget);
    expect(watch.permissionAsks, 1);
  });

  testWidgets('pairs a watch and syncs heart rate', (tester) async {
    final watch = FakeWatch();
    await pumpApp(tester, signedIn: 'p1', watch: watch);
    await tapAndSettle(tester, find.byKey(const Key('nav-profile')));
    await tapAndSettle(tester, find.text('Connected devices'));
    await tapAndSettle(tester, find.byKey(const Key('watch-find')));
    expect(watch.prepared, isTrue);
    await tapAndSettle(tester, find.text('Band 8'));
    watch.readings.add(88);
    await tester.pumpAndSettle();
    expect(find.text('88 bpm'), findsOneWidget);
    expect(find.text('Battery 80%'), findsOneWidget);
    expect(find.text('1 reading synced'), findsOneWidget);
  });

  testWidgets('Google sign-in copies the Google details after asking', (
    tester,
  ) async {
    final google = FakeGoogle(
      const GoogleProfile(email: 'Siti.Aminah@gmail.com', name: 'Siti Aminah'),
    );
    await pumpApp(
      tester,
      overrides: [googleAuthProvider.overrideWithValue(google)],
    );
    await tapAndSettle(tester, find.byKey(const Key('google-sign-in')));
    expect(find.byKey(const Key('google-consent')), findsOneWidget);
    expect(find.text('Siti Aminah'), findsOneWidget);
    expect(find.text('siti.aminah@gmail.com'), findsOneWidget);
    await tapAndSettle(tester, find.byKey(const Key('google-allow')));
    expect(find.text('Hi, Siti'), findsOneWidget);
    await tapAndSettle(tester, find.byKey(const Key('nav-profile')));
    await tapAndSettle(tester, find.text('Personal information'));
    expect(find.text('siti.aminah@gmail.com'), findsOneWidget);
  });

  testWidgets('Google sign-in with a known email goes straight in', (
    tester,
  ) async {
    final google = FakeGoogle(
      const GoogleProfile(email: 'demo.patient@example.com', name: 'Gwen'),
    );
    await pumpApp(
      tester,
      overrides: [googleAuthProvider.overrideWithValue(google)],
    );
    await tapAndSettle(tester, find.byKey(const Key('google-sign-in')));
    expect(find.byKey(const Key('google-consent')), findsNothing);
    expect(find.text('Hi, Gwen'), findsOneWidget);
  });

  testWidgets('declining the Google details goes to sign-up with the email', (
    tester,
  ) async {
    final google = FakeGoogle(
      const GoogleProfile(email: 'new.mum@gmail.com', name: 'New Mum'),
    );
    await pumpApp(
      tester,
      overrides: [googleAuthProvider.overrideWithValue(google)],
    );
    await tapAndSettle(tester, find.byKey(const Key('google-sign-in')));
    await tapAndSettle(tester, find.byKey(const Key('google-manual')));
    expect(find.byKey(const Key('onboarding-next')), findsOneWidget);
    expect(find.text('Hi, New'), findsNothing);
  });

  testWidgets('Google sign-in says so when it is not set up', (tester) async {
    await pumpApp(tester);
    await tapAndSettle(tester, find.byKey(const Key('google-sign-in')));
    expect(
      find.text(
        'Google sign-in is not set up in this build yet. Please use your email.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('sign-up asks for an email only', (tester) async {
    await pumpApp(tester);
    await tapAndSettle(tester, find.text('Create an account'));
    await tapAndSettle(tester, find.byIcon(Icons.person_outline_rounded).first);
    await tapAndSettle(tester, find.byKey(const Key('onboarding-next')));
    expect(find.byKey(const Key('signup-email')), findsOneWidget);
    expect(find.text('Phone'), findsNothing);
  });
}
