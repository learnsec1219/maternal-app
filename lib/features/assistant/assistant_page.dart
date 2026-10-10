import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';

/// Ask a question. The AI service is not connected in this build, so the
/// page says so plainly instead of pretending to answer.
class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final _c = TextEditingController();
  final _sent = <String>[];
  String _lang = 'en';
  bool _details = false;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _send() {
    final t = _c.text.trim();
    if (t.isEmpty) return;
    setState(() {
      _sent.add(t);
      _c.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    return PageScaffold(
      title: l.assistantTitle,
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
              decoration: InputDecoration(hintText: l.assistantInputHint),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            tooltip: l.assistantSend,
            onPressed: _send,
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
            selected: _lang,
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
        InfoBanner(l.assistantNotConnected, tone: Tone.warn),
        for (final q in _sent) ...[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8, left: 40),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: p.roseSoft,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(q),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
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
                  Pill(l.demoModeTitle, background: p.sand),
                  const SizedBox(height: 6),
                  Text(l.assistantNotConnected),
                ],
              ),
            ),
          ),
        ],
        const Disclaimer(),
      ],
    );
  }
}
