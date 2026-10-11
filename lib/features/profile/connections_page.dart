import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/integrations/integration_config.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';

/// Keys for the AI assistant and email codes. Values typed here are kept on this phone and win over the ones
/// built into the APK, so a tester can try a service without a new build.
class ConnectionsPage extends ConsumerStatefulWidget {
  const ConnectionsPage({super.key});

  @override
  ConsumerState<ConnectionsPage> createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends ConsumerState<ConnectionsPage> {
  late final _fields = {
    for (final k in IntegrationKey.values)
      k: TextEditingController(
        text: ref.read(integrationConfigProvider.notifier).isLocal(k)
            ? ref.read(integrationConfigProvider)[k]
            : '',
      ),
  };

  @override
  void dispose() {
    for (final c in _fields.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final ctrl = ref.read(integrationConfigProvider.notifier);
    for (final e in _fields.entries) {
      await ctrl.set(e.key, e.value.text);
    }
    if (mounted) showToast(context, context.l10n.savedMessage);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    final cfg = ref.watch(integrationConfigProvider);
    final ctrl = ref.read(integrationConfigProvider.notifier);

    Widget status(bool ok) => Pill(
      ok ? l.statusConnected : l.statusNotConnected,
      background: ok ? p.goodSoft : p.line,
      foreground: ok ? p.good : p.muted,
    );

    Widget field(IntegrationKey k) {
      final built = k.buildValue.isNotEmpty;
      return AppTextField(
        fieldKey: Key('conn-${k.envName}'),
        label: k.envName,
        controller: _fields[k]!,
        obscure: k.secret,
        helper: ctrl.isLocal(k)
            ? l.connectionsSetHere
            : built
            ? l.connectionsBuiltIn
            : l.connectionsMissing,
      );
    }

    Widget section(
      String title,
      bool ok,
      String body,
      List<IntegrationKey> keys, {
      Widget? extra,
    }) => AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              status(ok),
            ],
          ),
          const SizedBox(height: 6),
          Text(body, style: TextStyle(color: p.muted, height: 1.45)),
          const SizedBox(height: 10),
          for (final k in keys) field(k),
          ?extra,
        ],
      ),
    );

    return PageScaffold(
      title: l.connectionsTitle,
      bottom: PrimaryButton(
        l.actionSave,
        key: const Key('conn-save'),
        onPressed: _save,
      ),
      children: [
        InfoBanner(l.connectionsIntro),
        section(l.connectionsAiTitle, cfg.hasGemini, l.connectionsAiBody, [
          IntegrationKey.geminiApiKey,
          IntegrationKey.geminiModel,
        ]),
        section(l.connectionsEmailTitle, cfg.hasEmail, l.connectionsEmailBody, [
          IntegrationKey.emailJsServiceId,
          IntegrationKey.emailJsTemplateId,
          IntegrationKey.emailJsPublicKey,
          IntegrationKey.emailJsPrivateKey,
        ]),
      ],
    );
  }
}
