import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'integration_config.dart';

/// One turn of the conversation sent to the AI service.
class ChatTurn {
  const ChatTurn({required this.fromUser, required this.text});
  final bool fromUser;
  final String text;
}

/// Why an answer could not be fetched.
enum AssistantError { notConfigured, badKey, network, blocked, failed }

class AssistantException implements Exception {
  const AssistantException(
    this.error, [
    this.detail = '',
    this.tryAnotherModel = false,
  ]);
  final AssistantError error;
  final String detail;

  /// The model was busy, rate-limited or not found: another may work.
  final bool tryAnotherModel;

  @override
  String toString() => 'AssistantException($error, $detail)';
}

/// Answers questions. The real one calls Google Gemini; tests use a fake.
abstract class AssistantClient {
  Future<String> answer({
    required String language,
    required List<ChatTurn> turns,
    String? aboutMe,
  });
}

final assistantClientProvider = Provider<AssistantClient>(
  (ref) => GeminiClient(ref.watch(integrationConfigProvider)),
);

/// The standing instructions: maternity topics only, in the chosen language.
String assistantRules(String language, String? aboutMe) {
  final name = const {
    'en': 'English',
    'ms': 'Bahasa Melayu',
    'zh': 'Traditional Chinese (繁體中文)',
    'ta': 'Tamil (தமிழ்)',
  }[language]!;
  return '''
You are the educational assistant inside "Maternal", a pregnancy, maternity and women's health app used in Malaysia.

LANGUAGE: Write your whole answer ONLY in $name, even when the question is written in another language. Never switch language.

SCOPE: Only answer questions about pregnancy, trying to conceive, menstrual cycles, labour and birth, postpartum recovery, breastfeeding, newborn and baby care, maternal nutrition, exercise, sleep and mental health, prenatal tests, scans and vaccines, and how to use this app (kick counter, contractions timer, calendar, health logs, medications, appointments, vaccines, documents, calories). If the question is about anything else (for example coding, politics, sports, homework, other medical fields unrelated to women's or baby health), do not answer it: say kindly, in $name, that you can only help with pregnancy, maternity and women's health topics, and suggest one related question she could ask instead.

SAFETY: Give general educational information in plain, warm, simple words, in under 180 words. It is not a diagnosis, not a treatment plan, and never give medicine doses. When she describes symptoms, explain in general terms and tell her to contact her care team. For warning signs (heavy bleeding, reduced baby movements, severe headache or vision changes, severe abdominal pain, fluid leaking, fever, breathing problems, chest pain, fainting, fits) tell her to seek care now and that the emergency number in Malaysia is 999. When it helps, end with two or three short questions she could ask her doctor. Do not claim to be a doctor. Plain text only, no markdown headings or tables.
${aboutMe != null ? 'About her (shared with her permission): $aboutMe' : 'You know nothing about her personally.'}''';
}

class GeminiClient implements AssistantClient {
  GeminiClient(this.config, {http.Client? client})
    : _http = client ?? http.Client();

  final IntegrationConfig config;
  final http.Client _http;

  @override
  Future<String> answer({
    required String language,
    required List<ChatTurn> turns,
    String? aboutMe,
  }) async {
    if (!config.hasGemini) {
      throw const AssistantException(AssistantError.notConfigured);
    }
    final chosen = config[IntegrationKey.geminiModel].trim();
    // When a model is busy, rate-limited or retired, try the next one.
    final models = {
      if (chosen.isNotEmpty) chosen,
      'gemini-flash-latest',
      'gemini-2.5-flash',
      'gemini-2.0-flash',
    }.toList();
    final body = jsonEncode({
      'systemInstruction': {
        'parts': [
          {'text': assistantRules(language, aboutMe)},
        ],
      },
      'contents': [
        for (final t in turns)
          {
            'role': t.fromUser ? 'user' : 'model',
            'parts': [
              {'text': t.text},
            ],
          },
      ],
      'generationConfig': {'temperature': 0.4, 'maxOutputTokens': 2048},
    });
    AssistantException? last;
    for (final model in models) {
      try {
        return await _ask(model, body);
      } on AssistantException catch (e) {
        last = e;
        if (!e.tryAnotherModel) rethrow;
        await Future<void>.delayed(retryDelay);
      }
    }
    throw last!;
  }

  /// Pause before trying the next model; zero in tests.
  Duration retryDelay = const Duration(milliseconds: 800);

  Future<String> _ask(String model, String body) async {
    final uri = Uri.https(
      'generativelanguage.googleapis.com',
      '/v1beta/models/$model:generateContent',
    );
    final http.Response res;
    try {
      res = await _http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'x-goog-api-key': config[IntegrationKey.geminiApiKey],
            },
            body: body,
          )
          .timeout(const Duration(seconds: 45));
    } on Exception catch (e) {
      throw AssistantException(AssistantError.network, '$e');
    }
    final Map<String, dynamic> j;
    try {
      j = jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
    } on FormatException {
      throw AssistantException(
        AssistantError.failed,
        '$model HTTP ${res.statusCode}',
        res.statusCode >= 500,
      );
    }
    if (res.statusCode != 200) {
      final err = j['error'] as Map? ?? const {};
      final msg = err['message']?.toString() ?? '';
      final status = err['status']?.toString() ?? '';
      final keyProblem =
          res.statusCode == 401 ||
          res.statusCode == 403 ||
          status == 'PERMISSION_DENIED' ||
          status == 'UNAUTHENTICATED' ||
          msg.toLowerCase().contains('api key');
      throw AssistantException(
        keyProblem ? AssistantError.badKey : AssistantError.failed,
        '$model HTTP ${res.statusCode} $msg'.trim(),

        !keyProblem &&
            (res.statusCode == 404 ||
                res.statusCode == 429 ||
                res.statusCode >= 500),
      );
    }
    final candidates = j['candidates'] as List? ?? const [];
    final parts =
        ((candidates.isEmpty ? null : candidates.first as Map)?['content']
                as Map?)?['parts']
            as List? ??
        const [];
    final text = [
      for (final p in parts)
        if (p is Map && p['text'] is String && p['thought'] != true) p['text'],
    ].join().trim();
    if (text.isEmpty) {
      final block = (j['promptFeedback'] as Map?)?['blockReason'];
      final finish =
          (candidates.isEmpty ? null : candidates.first as Map)?['finishReason']
              ?.toString() ??
          '';
      final blocked =
          block != null ||
          const {'SAFETY', 'PROHIBITED_CONTENT', 'BLOCKLIST'}.contains(finish);
      // An empty answer for any other reason (e.g. the model ran out of room
      // while thinking) is worth one more try on another model.
      throw AssistantException(
        blocked ? AssistantError.blocked : AssistantError.failed,
        '$model ${block ?? finish}'.trim(),
        !blocked,
      );
    }
    return text;
  }
}
