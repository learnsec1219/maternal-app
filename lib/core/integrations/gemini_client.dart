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
  const AssistantException(this.error, [this.detail = '']);
  final AssistantError error;
  final String detail;

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
    final model = config[IntegrationKey.geminiModel].isEmpty
        ? 'gemini-flash-latest'
        : config[IntegrationKey.geminiModel];
    final uri = Uri.https(
      'generativelanguage.googleapis.com',
      '/v1beta/models/$model:generateContent',
    );
    final body = {
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
      'generationConfig': {'temperature': 0.4, 'maxOutputTokens': 1024},
    };
    final http.Response res;
    try {
      res = await _http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'x-goog-api-key': config[IntegrationKey.geminiApiKey],
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 45));
    } on Exception catch (e) {
      throw AssistantException(AssistantError.network, '$e');
    }
    final Map<String, dynamic> j;
    try {
      j = jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
    } on FormatException {
      throw AssistantException(AssistantError.failed, 'HTTP ${res.statusCode}');
    }
    if (res.statusCode != 200) {
      final msg = (j['error'] as Map?)?['message']?.toString() ?? '';
      throw AssistantException(
        res.statusCode == 400 || res.statusCode == 401 || res.statusCode == 403
            ? AssistantError.badKey
            : AssistantError.failed,
        'HTTP ${res.statusCode} $msg',
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
      throw AssistantException(
        AssistantError.blocked,
        '${(j['promptFeedback'] as Map?)?['blockReason'] ?? ''}',
      );
    }
    return text;
  }
}
