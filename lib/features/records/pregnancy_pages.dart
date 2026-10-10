import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/content/clinical_content.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/clock.dart';
import '../../core/util/dates.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/charts.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../../data/models.dart';
import '../../domain/health_rules.dart';
import '../patient/patient_data.dart';
import 'health_pages.dart';

/// Tap for each movement. Taps within a few seconds count as one.
class KickPage extends ConsumerStatefulWidget {
  const KickPage({super.key});

  @override
  ConsumerState<KickPage> createState() => _KickPageState();
}

class _KickPageState extends ConsumerState<KickPage> {
  bool _guarded = false;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final c = ref.watch(contentProvider);
    final today = ref.watch(todayProvider);
    final all = m.of(m.data.kicks)..sort((a, b) => b.at.compareTo(a.at));
    final td = all.where((k) => isSameDay(k.at, today)).toList();
    final hours = List<double>.filled(24, 0);
    for (final k in td) {
      hours[k.at.hour]++;
    }
    final hourFmt = DateFormat.j(context.intlLocale);
    final labels = [
      for (var h = 0; h < 24; h++)
        h % 4 == 0 ? hourFmt.format(DateTime(2000, 1, 1, h)) : '',
    ];
    final store = ref.read(demoStoreProvider.notifier);
    final guard = Duration(
      seconds: c.counters['kickTapGuardSeconds']?.toInt() ?? 3,
    );

    return PageScaffold(
      title: l.kickCounterTitle,
      children: [
        InfoBanner(c.education['kicks']?.of(context.lang) ?? ''),
        Center(
          child: Semantics(
            button: true,
            label: l.kickTapButton,
            excludeSemantics: true,
            child: GestureDetector(
              key: const Key('kick-tap'),
              onTap: () {
                final now = DateTime.now();
                if (all.isNotEmpty && now.difference(all.first.at) < guard) {
                  setState(() => _guarded = true);
                  return;
                }
                setState(() => _guarded = false);
                store.addKick(Kick(m.me.id, now));
              },
              child: Container(
                width: 210,
                height: 210,
                margin: const EdgeInsets.only(top: 6, bottom: 12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: p.roseSoft,
                  border: Border.all(color: p.line, width: 12),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(
                    width: 150,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.child_care_rounded, size: 72, color: p.rose),
                        const SizedBox(height: 6),
                        Text(l.kickTapButton, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(
          l.kicksTodayCount(td.length),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
        ),
        if (td.isNotEmpty)
          Text(
            l.lastKickAt(context.formatTime(td.first.at)),
            textAlign: TextAlign.center,
            style: TextStyle(color: p.muted),
          ),
        if (_guarded)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              l.kickGuarded,
              textAlign: TextAlign.center,
              style: TextStyle(color: p.warn),
            ),
          ),
        if (td.isNotEmpty)
          Center(
            child: TextButton(
              onPressed: () => store.removeKick(td.first),
              child: Text('↶ ${l.actionUndoLast}'),
            ),
          ),
        SectionHeader(l.kicksPerHourTitle),
        AppCard(
          child: BarChart(
            values: hours,
            labels: labels,
            semanticLabel: l.kicksChartSummary(td.length),
          ),
        ),
        SectionHeader(l.kicksPastDays),
        ListCard(
          rows: [
            for (var b = 1; b <= 6; b++)
              ListRow(
                title: context.formatWeekdayDate(addDays(today, -b)),
                trailing: Text(
                  l.kicksCount(
                    all
                        .where((k) => isSameDay(k.at, addDays(today, -b)))
                        .length,
                  ),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// Start and stop each contraction; shows the last hour's averages.
class ContractionPage extends ConsumerStatefulWidget {
  const ContractionPage({super.key});

  @override
  ConsumerState<ContractionPage> createState() => _ContractionPageState();
}

class _ContractionPageState extends ConsumerState<ContractionPage> {
  DateTime? _start;
  Timer? _tick;

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  void _toggle() {
    final l = context.l10n;
    if (_start == null) {
      setState(() => _start = DateTime.now());
      _tick = Timer.periodic(
        const Duration(milliseconds: 500),
        (_) => setState(() {}),
      );
      return;
    }
    _tick?.cancel();
    final start = _start!, end = DateTime.now();
    setState(() => _start = null);
    final min =
        ref
            .read(contentProvider)
            .counters['contractionMinimumSeconds']
            ?.toInt() ??
        5;
    if (end.difference(start).inSeconds < min) {
      showToast(context, l.contractionTooShort);
      return;
    }
    ref
        .read(demoStoreProvider.notifier)
        .addContraction(Contraction(mineOf(ref).me.id, start, end));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final c = ref.watch(contentProvider);
    final now = DateTime.now();
    final items = m.of(m.data.contractions)
      ..sort((a, b) => b.start.compareTo(a.start));
    final rec =
        items
            .where(
              (x) =>
                  x.length.inSeconds >= 5 &&
                  now.difference(x.start) <= const Duration(hours: 1),
            )
            .toList()
          ..sort((a, b) => a.start.compareTo(b.start));
    final avgD = rec.isEmpty
        ? null
        : Duration(
            seconds:
                rec.fold<int>(0, (a, x) => a + x.length.inSeconds) ~/
                rec.length,
          );
    final avgI = rec.length > 1
        ? Duration(
            seconds:
                rec.last.start.difference(rec.first.start).inSeconds ~/
                (rec.length - 1),
          )
        : null;
    final running = _start != null;
    return PageScaffold(
      title: l.contractionTitle,
      bottom: Center(
        child: Semantics(
          button: true,
          label: running ? l.contractionStop : l.contractionStart,
          excludeSemantics: true,
          child: GestureDetector(
            key: const Key('contraction-toggle'),
            onTap: _toggle,
            child: Container(
              width: 150,
              height: 150,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: running ? p.alert : p.rose,
                border: Border.all(color: p.line, width: 10),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: running
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            formatDuration(now.difference(_start!)),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: p.onRose,
                            ),
                          ),
                          Text(
                            l.contractionTapToStop,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: p.onRose),
                          ),
                        ],
                      )
                    : Text(
                        l.contractionStart,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: p.onRose,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
      children: [
        InfoBanner(c.education['contractions']?.of(context.lang) ?? ''),
        AppCard(
          color: p.roseSoft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.contractionLastHour(rec.length),
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final (label, d) in [
                    (l.contractionAvgDuration, avgD),
                    (l.contractionAvgInterval, avgI),
                  ])
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: TextStyle(fontSize: 12.5, color: p.muted),
                          ),
                          Text(
                            d == null ? '—' : formatDuration(d),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        SectionHeader(l.contractionHistory),
        if (items.isEmpty)
          EmptyNote(l.contractionEmpty)
        else
          ListCard(
            rows: [
              for (final (i, x) in items.take(20).indexed)
                ListRow(
                  leading: CircleAvatar(
                    radius: 15,
                    backgroundColor: p.rose,
                    child: Text(
                      '${items.length - i}',
                      style: TextStyle(
                        color: p.onRose,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  title: l.contractionDuration(formatDuration(x.length)),
                  subtitle:
                      context.formatDateTime(x.start) +
                      (i + 1 < items.length
                          ? ' · ${l.contractionGap(formatDuration(x.start.difference(items[i + 1].start)))}'
                          : ''),
                ),
            ],
          ),
      ],
    );
  }
}

/// Copy numbers from the scan report.
class AddScanPage extends ConsumerStatefulWidget {
  const AddScanPage({super.key});

  @override
  ConsumerState<AddScanPage> createState() => _AddScanPageState();
}

class _AddScanPageState extends ConsumerState<AddScanPage> {
  final _type = TextEditingController();
  late final Map<String, TextEditingController> _f = {
    for (final k in const [
      'efw',
      'crl',
      'bpd',
      'hc',
      'ac',
      'fl',
      'afi',
      'fhr',
      'nt',
    ])
      k: TextEditingController(),
  };
  String? _error;

  @override
  void dispose() {
    _type.dispose();
    for (final c in _f.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final labels = {
      'efw': (l.fetalEfw, 'g'),
      'crl': (l.fetalCrl, 'mm'),
      'bpd': (l.fetalBpd, 'mm'),
      'hc': (l.fetalHc, 'mm'),
      'ac': (l.fetalAc, 'mm'),
      'fl': (l.fetalFl, 'mm'),
      'afi': (l.fetalAfi, 'cm'),
      'fhr': (l.fetalFhr, 'bpm'),
      'nt': (l.fetalNt, 'mm'),
    };
    return PageScaffold(
      title: l.addUltrasoundTitle,
      bottom: PrimaryButton(
        l.actionSave,
        onPressed: () {
          final measures = <String, double>{
            for (final e in _f.entries)
              if (parseNumber(e.value.text) != null)
                e.key: parseNumber(e.value.text)!,
          };
          if (measures.isEmpty) {
            setState(() => _error = l.ultrasoundNeedOneValue);
            return;
          }
          final me = mineOf(ref).me;
          final today = ref.read(todayProvider);
          ref
              .read(demoStoreProvider.notifier)
              .addScan(
                Scan(
                  me.id,
                  today,
                  me.due == null ? 0 : gaDaysFor(me.due!, today),
                  _type.text.trim().isEmpty
                      ? l.scanTypeDefault
                      : _type.text.trim(),
                  measures,
                ),
              );
          showToast(context, l.savedMessage);
          Navigator.pop(context);
        },
      ),
      children: [
        InfoBanner(l.ultrasoundCopyHint),
        AppTextField(
          label: l.fieldScanType,
          controller: _type,
          hint: l.scanTypeHint,
        ),
        for (final e in _f.entries)
          AppTextField(
            label: '${labels[e.key]!.$1} (${labels[e.key]!.$2})',
            controller: e.value,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        if (_error != null) InfoBanner(_error!, tone: Tone.alert),
      ],
    );
  }
}

class MilestonePage extends ConsumerStatefulWidget {
  const MilestonePage({super.key});

  @override
  ConsumerState<MilestonePage> createState() => _MilestonePageState();
}

class _MilestonePageState extends ConsumerState<MilestonePage> {
  final _c = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return PageScaffold(
      title: l.addMilestoneTitle,
      bottom: PrimaryButton(
        l.actionSave,
        onPressed: () {
          final t = _c.text.trim();
          if (t.isEmpty) {
            setState(() => _error = l.errorRequired);
            return;
          }
          ref
              .read(demoStoreProvider.notifier)
              .addMilestone(
                Milestone(mineOf(ref).me.id, ref.read(todayProvider), t),
              );
          showToast(context, l.savedMessage);
          Navigator.pop(context);
        },
      ),
      children: [
        AppTextField(
          label: l.fieldMilestone,
          controller: _c,
          hint: l.milestoneHint,
          error: _error,
        ),
      ],
    );
  }
}
