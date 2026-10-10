import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/common.dart';
import 'l10n.dart';

/// Opens the phone dialer with [number]; says so if the phone can't.
Future<void> callNumber(BuildContext context, String number) async {
  final uri = Uri(
    scheme: 'tel',
    path: number.replaceAll(RegExp(r'[^\d+]'), ''),
  );
  final msg = context.l10n.callManually(number);
  var ok = false;
  try {
    ok = await launchUrl(uri);
  } catch (_) {
    ok = false;
  }
  if (!ok && context.mounted) showToast(context, msg);
}
