import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/integrations/totp.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';
import '../../data/session.dart';

/// Turn on sign-in with Google Authenticator (or any authenticator app).
class SecurityPage extends ConsumerStatefulWidget {
  const SecurityPage({super.key});

  @override
  ConsumerState<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends ConsumerState<SecurityPage> {
  final _code = TextEditingController();
  String? _secret;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _openApp(Uri uri) async {
    var ok = false;
    try {
      ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } on Object {
      ok = false;
    }
    if (!ok && mounted) showToast(context, context.l10n.totpNoApp);
  }

  Future<void> _enable(String personId) async {
    if (!Totp.verify(_secret!, _code.text, DateTime.now())) {
      setState(() => _error = context.l10n.authInvalidCode);
      return;
    }
    await ref.read(totpStoreProvider.notifier).enable(personId, _secret!);
    if (!mounted) return;
    setState(() {
      _secret = null;
      _error = null;
      _code.clear();
    });
    showToast(context, context.l10n.totpOn);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    final me = ref.watch(meProvider)!;
    final on = ref.watch(totpStoreProvider).containsKey(me.id);
    final account = me.email ?? me.phone ?? me.name;
    final secret = _secret;

    return PageScaffold(
      title: l.securityTitle,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l.totpTitle,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Pill(
                    on ? l.statusConnected : l.statusNotConnected,
                    background: on ? p.goodSoft : p.line,
                    foreground: on ? p.good : p.muted,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                on ? l.totpOn : l.totpBody,
                style: const TextStyle(height: 1.45),
              ),
              const SizedBox(height: 12),
              if (on)
                GhostButton(
                  l.totpTurnOff,
                  key: const Key('totp-off'),
                  onPressed: () =>
                      ref.read(totpStoreProvider.notifier).disable(me.id),
                )
              else if (secret == null)
                PrimaryButton(
                  l.totpSetup,
                  key: const Key('totp-setup'),
                  onPressed: () => setState(() => _secret = Totp.newSecret()),
                ),
            ],
          ),
        ),
        if (!on && secret != null) ...[
          Builder(
            builder: (context) {
              final uri = Totp.uri(secret: secret, account: account);
              return AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.totpStep1, style: const TextStyle(height: 1.45)),
                    const SizedBox(height: 10),
                    TonalButton(l.totpOpenApp, onPressed: () => _openApp(uri)),
                    const SizedBox(height: 12),
                    Center(
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(8),
                        child: QrImageView(
                          data: uri.toString(),
                          size: 180,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l.totpKeyLabel,
                      style: TextStyle(color: p.muted, fontSize: 12.5),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SelectableText(
                            secret.replaceAllMapped(
                              RegExp(r'.{4}'),
                              (m) => '${m[0]} ',
                            ),
                            key: const Key('totp-secret'),
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: l.actionCopy,
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: secret));
                            showToast(context, l.copied);
                          },
                          icon: const Icon(Icons.copy_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(l.totpStep2, style: const TextStyle(height: 1.45)),
                    AppTextField(
                      fieldKey: const Key('totp-code'),
                      label: l.totpCodeLabel,
                      controller: _code,
                      keyboardType: TextInputType.number,
                      error: _error,
                    ),
                    PrimaryButton(
                      l.totpEnable,
                      key: const Key('totp-enable'),
                      onPressed: () => _enable(me.id),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}
