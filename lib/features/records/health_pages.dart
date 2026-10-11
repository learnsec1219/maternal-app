import 'package:flutter/material.dart' hide Flow;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/content/clinical_content.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/clock.dart';
import '../../core/util/dates.dart';
import '../../core/util/l10n.dart';
import '../../core/util/labels.dart';
import '../../core/util/phone.dart';
import '../../core/widgets/charts.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../../data/models.dart';
import '../../domain/health_rules.dart';
import '../../l10n/app_localizations.dart';
import '../patient/patient_data.dart';

double? parseNumber(String s) => double.tryParse(s.trim().replaceAll(',', '.'));

String unitFor(AppLocalizations l, ObsType t) => switch (t) {
  ObsType.hr => l.unitBpm,
  ObsType.sleep => l.unitHours,
  ObsType.steps => l.unitSteps,
  _ => obsStyle(t).unit,
};

/// Add a reading: blood pressure, glucose, weight, water, mood and more.
class AddLogPage extends ConsumerStatefulWidget {
  const AddLogPage({super.key, this.type});
  final ObsType? type;

  @override
  ConsumerState<AddLogPage> createState() => _AddLogPageState();
}

class _AddLogPageState extends ConsumerState<AddLogPage> {
  late ObsType _type = widget.type ?? ObsType.bp;
  GlucoseContext _ctx = GlucoseContext.fasting;
  int _mood = 3;
  final _v1 = TextEditingController(),
      _v2 = TextEditingController(),
      _note = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _v1.dispose();
    _v2.dispose();
    _note.dispose();
    super.dispose();
  }

  void _save() {
    final l = context.l10n;
    final lim = obsLimits[_type]!;
    final v = _type == ObsType.mood ? _mood.toDouble() : parseNumber(_v1.text);
    final v2 = _type == ObsType.bp ? parseNumber(_v2.text) : null;
    String fmt(double x) => context.formatNumber(x);
    if (v == null || (_type == ObsType.bp && v2 == null)) {
      setState(() => _error = l.errorEnterNumber);
      return;
    }
    if (v < lim[0] || v > lim[1]) {
      setState(() => _error = l.errorOutOfRange(fmt(lim[0]), fmt(lim[1])));
      return;
    }
    if (_type == ObsType.bp && (v2! < lim[2] || v2 > lim[3])) {
      setState(() => _error = l.errorOutOfRange(fmt(lim[2]), fmt(lim[3])));
      return;
    }
    final me = mineOf(ref).me;
    final o = Observation(
      me.id,
      DateTime.now(),
      _type,
      v,
      value2: v2,
      ctx: _type == ObsType.glu ? _ctx : null,
      note: _note.text.trim().isEmpty ? null : _note.text.trim(),
    );
    ref.read(demoStoreProvider.notifier).addObservation(o);
    final r = rangeOf(o, ref.read(contentProvider));
    final nav = Navigator.of(context);
    if (r == RangeClass.above || r == RangeClass.below) {
      showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(l.outsideRangeTitle),
          content: Text(l.outsideRangeBody),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l.actionOk),
            ),
          ],
        ),
      ).then((_) => nav.maybePop());
    } else {
      showToast(context, l.savedMessage);
      nav.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final unit = unitFor(l, _type);
    final numeric = const TextInputType.numberWithOptions(decimal: true);
    return PageScaffold(
      title: l.addHealthLogTitle,
      bottom: PrimaryButton(
        l.actionSave,
        key: const Key('log-save'),
        onPressed: _save,
      ),
      children: [
        LabeledField(
          label: l.fieldMeasurement,
          child: ChoiceChips<ObsType>(
            options: [for (final t in ObsType.values) (t, l.obs(t))],
            selected: _type,
            onSelected: (t) => setState(() {
              _type = t;
              _v1.clear();
              _v2.clear();
              _error = null;
            }),
          ),
        ),
        if (_type == ObsType.bp)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  fieldKey: const Key('log-v1'),
                  label: l.fieldSystolic,
                  controller: _v1,
                  keyboardType: numeric,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppTextField(
                  fieldKey: const Key('log-v2'),
                  label: l.fieldDiastolic,
                  controller: _v2,
                  keyboardType: numeric,
                ),
              ),
            ],
          )
        else if (_type == ObsType.mood)
          ChoiceChips<int>(
            options: [for (var i = 1; i <= 5; i++) (i, l.mood(i))],
            selected: _mood,
            onSelected: (v) => setState(() => _mood = v),
          )
        else
          AppTextField(
            fieldKey: const Key('log-v1'),
            label: unit.isEmpty ? l.obs(_type) : '${l.obs(_type)} ($unit)',
            controller: _v1,
            keyboardType: numeric,
          ),
        if (_type == ObsType.glu)
          LabeledField(
            label: l.fieldGlucoseContext,
            child: ChoiceChips<GlucoseContext>(
              options: [
                for (final c in GlucoseContext.values) (c, l.glucoseCtx(c)),
              ],
              selected: _ctx,
              onSelected: (c) => setState(() => _ctx = c),
            ),
          ),
        if (_error != null) InfoBanner(_error!, tone: Tone.alert),
        AppTextField(
          label: l.fieldNotesOptional,
          controller: _note,
          maxLines: 2,
        ),
      ],
    );
  }
}

/// Last 30 days of one reading, with the typical range shaded.
class TrendPage extends ConsumerWidget {
  const TrendPage({super.key, required this.type});
  final ObsType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final c = ref.watch(contentProvider);
    final today = ref.watch(todayProvider);
    final all = m.of(m.data.obs).where((o) => o.type == type).toList()
      ..sort((a, b) => b.at.compareTo(a.at));
    final from = addDays(today, -29);
    final recent = all.where((o) => !o.at.isBefore(from)).toList();
    final bandKey = switch (type) {
      ObsType.bp => 'systolic',
      ObsType.hr => 'heart_rate',
      ObsType.temp => 'temperature',
      ObsType.spo2 => 'spo2',
      _ => null,
    };
    final band = bandKey == null ? null : c.ranges[bandKey];
    double x(DateTime at) => daysBetween(from, at) + at.hour / 24;
    return PageScaffold(
      title: l.obs(type),
      bottom: PrimaryButton(
        l.actionAdd,
        onPressed: () => pushPage(context, AddLogPage(type: type)),
      ),
      children: [
        AppCard(
          child: recent.isEmpty
              ? EmptyNote(l.noReadingsInPeriod)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LineChart(
                      points: [
                        for (final o in recent)
                          ChartPoint(
                            x(o.at),
                            o.value,
                            context.formatShortDate(o.at),
                          ),
                      ],
                      second: type == ObsType.bp
                          ? [
                              for (final o in recent)
                                if (o.value2 != null)
                                  ChartPoint(x(o.at), o.value2!),
                            ]
                          : null,
                      band: band == null ? null : (band.low, band.high),
                      semanticLabel: l.chartSummary(
                        l.obs(type),
                        recent.length,
                        obsValue(context, recent.first),
                      ),
                    ),
                    if (band != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          l.chartBandNote,
                          style: TextStyle(fontSize: 12.5, color: p.muted),
                        ),
                      ),
                  ],
                ),
        ),
        SectionHeader(l.readingsTitle),
        if (all.isEmpty)
          AppCard(child: EmptyNote(l.noReadingsYet))
        else
          ListCard(
            rows: [
              for (final o in all.take(30))
                ListRow(
                  title: obsValue(context, o),
                  subtitle: context.formatDateTime(o.at),
                  trailing: rangePill(context, rangeOf(o, c)),
                ),
            ],
          ),
      ],
    );
  }
}

/// Warning signs first (with a call button), then everyday symptoms.
class SymptomsPage extends ConsumerStatefulWidget {
  const SymptomsPage({super.key});

  @override
  ConsumerState<SymptomsPage> createState() => _SymptomsPageState();
}

class _SymptomsPageState extends ConsumerState<SymptomsPage> {
  final _sel = <String>{};
  int _sev = 1;

  void _warn(WarningSign w) {
    final l = context.l10n, p = context.pal, lang = context.lang;
    final m = mineOf(ref);
    final c = ref.read(contentProvider);
    ref
        .read(demoStoreProvider.notifier)
        .addSymptom(
          SymptomEntry(m.me.id, DateTime.now(), w.code, 3, warning: true),
        );
    final linked = m.data.links[m.me.id] == LinkState.active;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(w.title.of(lang)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                w.advice.of(lang),
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(l.emergencyNumberNote(c.emergencyNumber)),
              const SizedBox(height: 16),
              if (linked) ...[
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: p.alert,
                      foregroundColor: p.onRose,
                    ),
                    onPressed: () => callNumber(ctx, DemoDoctor.phone),
                    icon: const Icon(Icons.call_rounded),
                    label: Text(
                      l.callDoctor(DemoDoctor.name),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 8),
                  child: Center(
                    child: SelectableText(
                      '${DemoDoctor.clinic} · ${DemoDoctor.phone}',
                      style: TextStyle(fontSize: 12.5, color: p.muted),
                    ),
                  ),
                ),
              ],
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => callNumber(ctx, c.emergencyNumber),
                  icon: const Icon(Icons.call_rounded),
                  label: Text(l.callEmergency(c.emergencyNumber)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l.actionUnderstood),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal, lang = context.lang;
    final m = mineOf(ref);
    final c = ref.watch(contentProvider);
    final signs = c.warningSigns
        .where((w) => w.journeys.contains(m.me.journey.name))
        .toList();
    final history = m.of(m.data.symptoms)..sort((a, b) => b.at.compareTo(a.at));
    return PageScaffold(
      title: l.symptomsTitle,
      children: [
        SectionHeader(l.warningSignsTitle),
        InfoBanner(l.warningSignsIntro, tone: Tone.alert),
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Column(
            children: [
              for (final (i, w) in signs.indexed)
                Container(
                  decoration: BoxDecoration(
                    border: i == 0
                        ? null
                        : Border(top: BorderSide(color: p.line)),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.warning_amber_rounded, color: p.alert),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(w.title.of(lang)),
                            Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 8),
                              child: Text(
                                w.advice.of(lang),
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: p.alert,
                                ),
                              ),
                            ),
                            TonalButton(
                              l.warningSignLogNow,
                              onPressed: () => _warn(w),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SectionHeader(l.symptomsLogTitle),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final s in c.symptoms)
                    SelectChip(
                      label: s.label.of(lang),
                      selected: _sel.contains(s.code),
                      onTap: () => setState(
                        () => _sel.contains(s.code)
                            ? _sel.remove(s.code)
                            : _sel.add(s.code),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              LabeledField(
                label: l.fieldSeverity,
                child: ChoiceChips<int>(
                  options: [for (var i = 1; i <= 3; i++) (i, l.severity(i))],
                  selected: _sev,
                  onSelected: (v) => setState(() => _sev = v),
                ),
              ),
              PrimaryButton(
                l.actionSave,
                onPressed: _sel.isEmpty
                    ? null
                    : () {
                        final store = ref.read(demoStoreProvider.notifier);
                        for (final code in _sel) {
                          store.addSymptom(
                            SymptomEntry(m.me.id, DateTime.now(), code, _sev),
                          );
                        }
                        setState(_sel.clear);
                        showToast(context, l.savedMessage);
                      },
              ),
            ],
          ),
        ),
        SectionHeader(l.symptomsHistoryTitle),
        if (history.isEmpty)
          AppCard(child: EmptyNote(l.symptomsEmpty))
        else
          ListCard(
            rows: [
              for (final s in history.take(12))
                ListRow(
                  leading: Icon(
                    s.warning
                        ? Icons.warning_amber_rounded
                        : Icons.healing_outlined,
                    color: s.warning ? p.alert : p.rose,
                  ),
                  title: c.symptomLabel(s.code, lang),
                  subtitle:
                      '${context.formatDateTime(s.at)} · ${l.severity(s.severity)}',
                ),
            ],
          ),
      ],
    );
  }
}

class MedsPage extends ConsumerWidget {
  const MedsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final today = ref.watch(todayProvider);
    final doses = dosesFor(m, today);
    return PageScaffold(
      title: l.medicationsTitle,
      children: [
        SectionHeader(l.medicationsToday),
        if (doses.isEmpty)
          AppCard(child: EmptyNote(l.medicationsNoneToday))
        else
          ListCard(
            rows: [
              for (final d in doses)
                ListRow(
                  leading: Checkbox(
                    value: d.taken,
                    activeColor: p.good,
                    onChanged: d.taken
                        ? null
                        : (_) => ref
                              .read(demoStoreProvider.notifier)
                              .takeDose(m.me.id, d.med.id, d.slot, today),
                  ),
                  title: '${d.med.name} ${d.med.dose}',
                  subtitle: d.slot,
                ),
            ],
          ),
        InfoBanner(l.medicationSafetyNote),
      ],
    );
  }
}

/// Log the flow for one day. Saving a period day circles it on the calendar.
class PeriodPage extends ConsumerStatefulWidget {
  const PeriodPage({super.key, this.day});
  final DateTime? day;

  @override
  ConsumerState<PeriodPage> createState() => _PeriodPageState();
}

class _PeriodPageState extends ConsumerState<PeriodPage> {
  Flow? _flow;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final m = mineOf(ref);
    final day = dateOnly(widget.day ?? ref.watch(todayProvider));
    if (_flow == null) {
      for (final x in m.of(m.data.periods)) {
        if (isSameDay(x.date, day)) _flow = x.flow;
      }
      _flow ??= Flow.medium;
    }
    return PageScaffold(
      title: l.periodDayTitle,
      bottom: PrimaryButton(
        l.actionSave,
        key: const Key('period-save'),
        onPressed: () {
          ref.read(demoStoreProvider.notifier).setPeriod(m.me.id, day, _flow!);
          if (hasFlow(_flow!)) {
            ref.read(calendarUiProvider.notifier).circle(day);
          }
          showToast(context, l.savedMessage);
          Navigator.pop(context);
        },
      ),
      children: [
        Text(
          context.formatLongDate(day),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const SizedBox(height: 12),
        LabeledField(
          label: l.fieldFlow,
          child: ChoiceChips<Flow>(
            options: [for (final f in Flow.values) (f, l.flow(f))],
            selected: _flow,
            onSelected: (f) => setState(() => _flow = f),
          ),
        ),
        InfoBanner(l.intimacyPrivateNote),
      ],
    );
  }
}

class RemindersPage extends ConsumerWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final m = mineOf(ref);
    final rem = remindersFor(
      context,
      m,
      ref.watch(todayProvider),
      DateTime.now(),
      ref.watch(contentProvider),
    );
    return PageScaffold(
      title: l.remindersTitle,
      children: [
        if (rem.isEmpty) EmptyNote(l.remindersEmpty),
        for (final (tone, msg) in rem) InfoBanner(msg, tone: tone),
        Text(
          l.remindersPushNote,
          style: TextStyle(fontSize: 12.5, color: p.muted, height: 1.5),
        ),
      ],
    );
  }
}
