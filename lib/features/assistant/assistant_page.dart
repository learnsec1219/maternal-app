import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/content/clinical_content.dart';
import '../../core/integrations/gemini_client.dart';
import '../../core/integrations/integration_config.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/clock.dart';
import '../../core/util/l10n.dart';
import '../../core/util/phone.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../../data/models.dart';
import '../../data/session.dart';
import '../../domain/health_rules.dart';
import '../../l10n/app_localizations.dart';
import '../settings/locale_controller.dart';

class _Msg {
  _Msg.user(this.text, this.urgent) : fromUser = true;
  _Msg.ai() : fromUser = false, urgent = const [];

  final bool fromUser;
  final List<String> urgent;
  String text = '';
  AssistantError? error;

  /// What the service said, shown small under the error to help support.
  String errorDetail = '';
  bool pending = false;
}

/// Ask a question. Answers come from Google Gemini in the chosen language and
/// stay on pregnancy, maternity and women's health topics.
class AssistantPage extends ConsumerStatefulWidget {
  const AssistantPage({super.key});

  @override
  ConsumerState<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends ConsumerState<AssistantPage> {
  final _c = TextEditingController();
  final _scroll = ScrollController();
  final _msgs = <_Msg>[];
  String? _lang;
  bool _details = false;
  bool _sending = false;

  @override
  void dispose() {
    _c.dispose();
    _scroll.dispose();
    super.dispose();
  }

  String get _chatLang => _lang ?? context.lang;

  /// Strings in the answer language, so status lines match the chat.
  AppLocalizations get _cl => lookupAppLocalizations(
    appLanguages
        .firstWhere(
          (a) => a.locale.languageCode == _chatLang,
          orElse: () => appLanguages[1],
        )
        .locale,
  );

  String? _aboutMe() {
    if (!_details) return null;
    final me = ref.read(meProvider);
    if (me == null) return null;
    final pr = PregnancyStatus.of(
      me,
      ref.read(todayProvider),
      ref.read(contentProvider),
    );
    if (me.journey == Journey.pregnancy && pr != null) {
      return 'Pregnant, ${pr.gaDays ~/ 7} weeks ${pr.gaDays % 7} days, '
          '${pr.babies} baby/babies.';
    }
    return me.journey == Journey.postpartum
        ? 'Recently gave birth (postpartum).'
        : 'Not pregnant; uses the app for cycle and general health tracking.';
  }

  void _toBottom() => WidgetsBinding.instance.addPostFrameCallback((_) {
    if (_scroll.hasClients) {
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  });

  Future<void> _send([String? preset]) async {
    final text = (preset ?? _c.text).trim();
    if (text.isEmpty || _sending) return;
    final content = ref.read(contentProvider).assistant;
    final ai = _Msg.ai()..pending = true;
    setState(() {
      _msgs
        ..add(_Msg.user(text, content.redFlags(text)))
        ..add(ai);
      _c.clear();
      _sending = true;
    });
    _toBottom();
    await _ask(ai);
  }

  Future<void> _ask(_Msg ai) async {
    final turns = [
      for (final m in _msgs)
        if (m != ai && m.error == null && m.text.isNotEmpty)
          ChatTurn(fromUser: m.fromUser, text: m.text),
    ];
    final recent = turns.length > 12 ? turns.sublist(turns.length - 12) : turns;
    try {
      final out = await ref
          .read(assistantClientProvider)
          .answer(language: _chatLang, turns: recent, aboutMe: _aboutMe());
      ai
        ..text = out
        ..error = null;
    } on AssistantException catch (e) {
      ai
        ..error = e.error
        ..errorDetail = e.detail;
    } catch (e) {
      ai
        ..error = AssistantError.failed
        ..errorDetail = '$e';
    }
    if (!mounted) return;
    setState(() {
      ai.pending = false;
      _sending = false;
    });
    _toBottom();
  }

  Future<void> _retry(_Msg ai) async {
    setState(() {
      ai
        ..pending = true
        ..error = null;
      _sending = true;
    });
    await _ask(ai);
  }

  String _errorText(AssistantError e) {
    final l = _cl;
    return switch (e) {
      AssistantError.notConfigured => l.assistantNotConfigured,
      AssistantError.badKey => l.assistantBadKey,
      AssistantError.network => l.assistantNetwork,
      AssistantError.blocked => l.assistantBlocked,
      AssistantError.failed => l.assistantFailed,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    final content = ref.watch(contentProvider);
    final as = content.assistant;
    final ready = ref.watch(integrationConfigProvider).hasGemini;
    final lang = _chatLang;
    final cl = _cl;

    Widget bubble(_Msg m) {
      if (m.fromUser) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 8, left: 40),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: p.roseSoft,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(m.text),
              ),
            ),
            if (m.urgent.isNotEmpty) _UrgentCard(codes: m.urgent, lang: lang),
          ],
        );
      }
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          key: const Key('assistant-answer'),
          margin: const EdgeInsets.only(bottom: 12, right: 40),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: p.card,
            border: Border.all(color: p.line),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AiLogo(size: 20),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Pill(cl.assistantEducational, background: p.sky),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              if (m.pending)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 8),
                    Flexible(child: Text(cl.assistantThinking)),
                  ],
                )
              else if (m.error != null) ...[
                Text(_errorText(m.error!), style: TextStyle(color: p.alert)),
                if (m.errorDetail.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      m.errorDetail,
                      key: const Key('assistant-error-detail'),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: p.muted, fontSize: 11.5),
                    ),
                  ),
                Wrap(
                  spacing: 4,
                  children: [
                    TextButton(
                      onPressed: () => _retry(m),
                      child: Text(cl.actionRetry),
                    ),
                  ],
                ),
              ] else
                SelectableText(m.text, style: const TextStyle(height: 1.45)),
            ],
          ),
        ),
      );
    }

    return PageScaffold(
      title: l.assistantTitle,
      controller: _scroll,
      actions: [
        if (_msgs.isNotEmpty)
          IconButton(
            tooltip: l.assistantNewChat,
            onPressed: _sending ? null : () => setState(_msgs.clear),
            icon: const Icon(Icons.add_comment_outlined),
          ),
      ],
      bottom: Row(
        children: [
          Expanded(
            child: TextField(
              key: const Key('assistant-input'),
              controller: _c,
              minLines: 1,
              maxLines: 4,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _send(),
              decoration: InputDecoration(hintText: cl.assistantInputHint),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            key: const Key('assistant-send'),
            tooltip: l.assistantSend,
            onPressed: _sending ? null : _send,
            icon: const Icon(Icons.send_rounded),
          ),
        ],
      ),
      children: [
        LabeledField(
          label: l.assistantLanguage,
          child: ChoiceChips<String>(
            options: const [
              ('en', 'English'),
              ('ms', 'BM'),
              ('zh', '中文'),
              ('ta', 'தமிழ்'),
            ],
            selected: lang,
            onSelected: (v) => setState(() => _lang = v),
          ),
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: _details,
          onChanged: (v) => setState(() => _details = v ?? false),
          title: Text(
            l.assistantUseDetails,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(l.assistantUseDetailsHelp),
        ),
        InfoBanner(as.disclaimer.of(lang)),
        if (!ready)
          InfoBanner(
            cl.assistantNotConfigured,
            tone: Tone.warn,
            key: const Key('assistant-setup'),
          ),
        if (_msgs.isEmpty) ...[
          AppCard(
            color: p.roseTint,
            child: Text(as.intro.of(lang), style: const TextStyle(height: 1.5)),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final (i, s) in as.suggestions.indexed)
                ActionChip(
                  key: Key('assistant-suggest-$i'),
                  label: Text(s.of(lang)),
                  onPressed: () => _send(s.of(lang)),
                ),
            ],
          ),
          const SizedBox(height: 12),
        ],
        for (final m in _msgs) bubble(m),
        const Disclaimer(),
      ],
    );
  }
}

/// Shown under a question that mentions a warning sign, before any answer.
class _UrgentCard extends ConsumerWidget {
  const _UrgentCard({required this.codes, required this.lang});
  final List<String> codes;
  final String lang;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final c = ref.watch(contentProvider);
    final data = ref.watch(demoStoreProvider);
    final me = ref.watch(meProvider);
    final linked = me != null && data.links[me.id] == LinkState.active;
    return AppCard(
      key: const Key('assistant-urgent'),
      color: p.alertSoft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: p.alert),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  c.assistant.urgentTitle.of(lang),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          for (final w in c.warningSigns.where((w) => codes.contains(w.code)))
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${w.title.of(lang)}\n',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: w.advice.of(lang)),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 10),
          if (linked)
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: p.alert,
                  foregroundColor: p.onRose,
                ),
                onPressed: () => callNumber(context, DemoDoctor.phone),
                icon: const Icon(Icons.call_rounded),
                label: Text(l.callDoctor(DemoDoctor.name)),
              ),
            ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => callNumber(context, c.emergencyNumber),
              icon: const Icon(Icons.call_rounded),
              label: Text(l.callEmergency(c.emergencyNumber)),
            ),
          ),
        ],
      ),
    );
  }
}
