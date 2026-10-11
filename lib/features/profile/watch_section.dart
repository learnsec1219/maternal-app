import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/integrations/watch_service.dart';
import '../../core/storage/local_store.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/l10n.dart';
import '../../core/widgets/common.dart';
import '../../data/demo_store.dart';
import '../../data/models.dart';
import '../../data/session.dart';
import '../../l10n/app_localizations.dart';
import '../patient/patient_data.dart';

/// What the paired watch is doing.
class WatchState {
  const WatchState({
    this.deviceId,
    this.name,
    this.connected = false,
    this.connecting = false,
    this.heartRate,
    this.battery,
    this.saved = 0,
    this.problem,
  });

  final String? deviceId, name;
  final bool connected, connecting;
  final int? heartRate, battery;

  /// Heart-rate readings saved into Health log this session.
  final int saved;
  final WatchProblem? problem;

  WatchState copy({
    bool? connected,
    bool? connecting,
    int? heartRate,
    int? battery,
    int? saved,
    WatchProblem? problem,
    bool clearProblem = false,
  }) => WatchState(
    deviceId: deviceId,
    name: name,
    connected: connected ?? this.connected,
    connecting: connecting ?? this.connecting,
    heartRate: heartRate ?? this.heartRate,
    battery: battery ?? this.battery,
    saved: saved ?? this.saved,
    problem: clearProblem ? null : problem ?? this.problem,
  );
}

enum WatchProblem { denied, off, unsupported, noHeartRate, connectFailed, lost }

final watchProvider = NotifierProvider<WatchController, WatchState>(
  WatchController.new,
);

class WatchController extends Notifier<WatchState> {
  static const _idKey = 'watch.deviceId', _nameKey = 'watch.name';
  StreamSubscription<int>? _sub;
  DateTime? _lastSaved;

  @override
  WatchState build() {
    ref.onDispose(() => _sub?.cancel());
    final store = ref.read(localStoreProvider);
    final id = store.readString(_idKey);
    return WatchState(
      deviceId: id == null || id.isEmpty ? null : id,
      name: store.readString(_nameKey),
    );
  }

  Future<WatchReady> prepare() async {
    final r = await ref.read(watchServiceProvider).prepare();
    state = state.copy(
      problem: switch (r) {
        WatchReady.ready => null,
        WatchReady.denied => WatchProblem.denied,
        WatchReady.off => WatchProblem.off,
        WatchReady.unsupported => WatchProblem.unsupported,
      },
      clearProblem: r == WatchReady.ready,
    );
    return r;
  }

  Future<bool> connect(WatchDevice d) async {
    final svc = ref.read(watchServiceProvider);
    await _sub?.cancel();
    state = WatchState(deviceId: d.id, name: d.name, connecting: true);
    final store = ref.read(localStoreProvider);
    await store.writeString(_idKey, d.id);
    await store.writeString(_nameKey, d.name);
    try {
      final stream = await svc.connectHeartRate(d.id);
      final battery = await svc.readBattery(d.id);
      state = state.copy(connected: true, connecting: false, battery: battery);
      _sub = stream.listen(
        _onHeartRate,
        onError: (_) =>
            state = state.copy(connected: false, problem: WatchProblem.lost),
        onDone: () => state = state.copy(connected: false),
      );
      return true;
    } on WatchUnsupported {
      await svc.disconnect(d.id);
      state = state.copy(connecting: false, problem: WatchProblem.noHeartRate);
    } on Object {
      state = state.copy(
        connecting: false,
        problem: WatchProblem.connectFailed,
      );
    }
    return false;
  }

  /// Keeps one reading a minute in Health log, so the chart isn't flooded.
  void _onHeartRate(int bpm) {
    final now = DateTime.now();
    var saved = state.saved;
    final person = ref.read(sessionProvider);
    if (person != null &&
        (_lastSaved == null ||
            now.difference(_lastSaved!) >= const Duration(minutes: 1))) {
      _lastSaved = now;
      ref
          .read(demoStoreProvider.notifier)
          .addObservation(
            Observation(
              person,
              now,
              ObsType.hr,
              bpm.toDouble(),
              note: state.name,
            ),
          );
      saved++;
    }
    state = state.copy(heartRate: bpm, saved: saved);
  }

  Future<void> disconnect({bool forget = false}) async {
    await _sub?.cancel();
    _sub = null;
    final id = state.deviceId;
    if (id != null) await ref.read(watchServiceProvider).disconnect(id);
    if (forget) {
      final store = ref.read(localStoreProvider);
      await store.writeString(_idKey, '');
      await store.writeString(_nameKey, '');
      state = const WatchState();
    } else {
      state = state.copy(connected: false, connecting: false);
    }
  }
}

String watchProblemText(AppLocalizations l, WatchProblem p) => switch (p) {
  WatchProblem.denied => l.bluetoothDenied,
  WatchProblem.off => l.bluetoothOff,
  WatchProblem.unsupported => l.bluetoothUnsupported,
  WatchProblem.noHeartRate => l.bluetoothNoHeartRate,
  WatchProblem.connectFailed => l.bluetoothConnectFailed,
  WatchProblem.lost => l.bluetoothLost,
};

/// The Bluetooth watch card on the Devices page.
class WatchCard extends ConsumerWidget {
  const WatchCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n, p = context.pal;
    final w = ref.watch(watchProvider);
    final ctrl = ref.read(watchProvider.notifier);
    return AppCard(
      key: const Key('watch-card'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l.bluetoothTitle,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Pill(
                w.connected ? l.statusConnected : l.statusNotConnected,
                background: w.connected ? p.goodSoft : p.line,
                foreground: w.connected ? p.good : p.muted,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(l.bluetoothWatchBody, style: const TextStyle(height: 1.45)),
          if (w.problem != null) ...[
            const SizedBox(height: 8),
            InfoBanner(watchProblemText(l, w.problem!), tone: Tone.warn),
          ],
          if (w.connected) ...[
            const SizedBox(height: 10),
            Text(
              w.name ?? '',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.favorite_rounded, color: p.alert, size: 20),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    w.heartRate == null
                        ? l.bluetoothWaitingForReading
                        : l.bluetoothHeartRate(w.heartRate!),
                    key: const Key('watch-hr'),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            if (w.battery != null) Text(l.bluetoothBattery(w.battery!)),
            Text(
              l.syncedReadings(w.saved),
              style: TextStyle(color: p.muted, fontSize: 12.5),
            ),
            const SizedBox(height: 10),
            GhostButton(
              l.actionDisconnect,
              onPressed: () => ctrl.disconnect(forget: true),
            ),
          ] else if (w.connecting)
            const Padding(
              padding: EdgeInsets.all(12),
              child: Center(child: CircularProgressIndicator()),
            )
          else ...[
            const SizedBox(height: 12),
            if (w.deviceId != null && w.name != null && w.name!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TonalButton(
                  l.bluetoothReconnect(w.name!),
                  onPressed: () async {
                    if (await ctrl.prepare() != WatchReady.ready) return;
                    await ctrl.connect(WatchDevice(w.deviceId!, w.name!));
                  },
                ),
              ),
            PrimaryButton(
              l.bluetoothFindWatch,
              key: const Key('watch-find'),
              onPressed: () => findWatch(context, ref),
            ),
          ],
        ],
      ),
    );
  }
}

/// Explains why, asks for Bluetooth, then lists nearby watches.
Future<void> findWatch(BuildContext context, WidgetRef ref) async {
  final ready = await ref.read(watchProvider.notifier).prepare();
  if (ready != WatchReady.ready || !context.mounted) return;
  await pushPage(context, const WatchScanPage());
}

class WatchScanPage extends ConsumerStatefulWidget {
  const WatchScanPage({super.key});

  @override
  ConsumerState<WatchScanPage> createState() => _WatchScanPageState();
}

class _WatchScanPageState extends ConsumerState<WatchScanPage> {
  final _found = <String, WatchDevice>{};
  StreamSubscription<WatchDevice>? _sub;
  Timer? _stop;
  bool _scanning = false;
  bool _failed = false;
  late final WatchService _svc = ref.read(watchServiceProvider);

  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() {
    final svc = _svc;
    _sub?.cancel();
    setState(() {
      _scanning = true;
      _failed = false;
    });
    _sub = svc.scan().listen(
      (d) => setState(() => _found[d.id] = d),
      onError: (_) => setState(() {
        _failed = true;
        _scanning = false;
      }),
    );
    _stop?.cancel();
    _stop = Timer(const Duration(seconds: 15), _end);
  }

  void _end() {
    _sub?.cancel();
    _sub = null;
    _svc.stopScan();
    if (mounted) setState(() => _scanning = false);
  }

  @override
  void dispose() {
    _stop?.cancel();
    _sub?.cancel();
    _svc.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n, p = context.pal;
    final list = _found.values.toList()
      ..sort((a, b) {
        if (a.heartRate != b.heartRate) return a.heartRate ? -1 : 1;
        return (b.rssi ?? -999).compareTo(a.rssi ?? -999);
      });
    return PageScaffold(
      title: l.bluetoothFindWatch,
      children: [
        InfoBanner(l.bluetoothScanHelp),
        if (_scanning)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 10),
                Text(l.scanning),
              ],
            ),
          ),
        if (_failed) InfoBanner(l.bluetoothOff, tone: Tone.warn),
        if (list.isNotEmpty)
          ListCard(
            rows: [
              for (final d in list)
                ListRow(
                  key: Key('watch-${d.id}'),
                  leading: Icon(
                    d.heartRate ? Icons.monitor_heart_outlined : Icons.watch,
                  ),
                  title: d.name,
                  subtitle: d.heartRate ? l.bluetoothHasHeartRate : null,
                  trailing: Icon(Icons.chevron_right_rounded, color: p.muted),
                  onTap: () async {
                    _end();
                    final nav = Navigator.of(context);
                    final ok = await ref
                        .read(watchProvider.notifier)
                        .connect(d);
                    if (ok) nav.pop();
                  },
                ),
            ],
          )
        else if (!_scanning)
          Text(l.bluetoothNoneFound, style: TextStyle(color: p.muted)),
        if (ref.watch(watchProvider).problem case final pr?)
          InfoBanner(watchProblemText(l, pr), tone: Tone.warn),
        if (!_scanning) TonalButton(l.actionScan, onPressed: _start),
      ],
    );
  }
}

/// The first time each person signs in on this phone, shows Android's own
/// Bluetooth permission box (Allow / Don't allow). Pairing a watch happens
/// later from Profile > Connected devices.
Future<void> askForWatchOnce(BuildContext context, WidgetRef ref) async {
  final person = ref.read(sessionProvider);
  if (person == null) return;
  final key = 'watch.asked.$person';
  final store = ref.read(localStoreProvider);
  if (store.readString(key) == 'yes') return;
  await store.writeString(key, 'yes');
  await ref.read(watchServiceProvider).requestPermission();
}
