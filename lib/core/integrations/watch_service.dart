import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_ble/universal_ble.dart';

/// Standard Bluetooth health services the app reads from a watch or band.
abstract final class BleIds {
  static const heartRateService = '0000180d-0000-1000-8000-00805f9b34fb';
  static const heartRateMeasurement = '00002a37-0000-1000-8000-00805f9b34fb';
  static const batteryService = '0000180f-0000-1000-8000-00805f9b34fb';
  static const batteryLevel = '00002a19-0000-1000-8000-00805f9b34fb';
}

/// Beats per minute from a Heart Rate Measurement value (Bluetooth SIG
/// 0x2A37): flag bit 0 says whether the rate is 8 or 16 bits.
int? parseHeartRate(List<int> v) {
  if (v.length < 2) return null;
  if (v[0] & 0x01 == 0) return v[1];
  if (v.length < 3) return null;
  return v[1] | (v[2] << 8);
}

enum WatchReady { ready, denied, off, unsupported }

class WatchDevice {
  const WatchDevice(this.id, this.name, {this.rssi, this.heartRate = false});
  final String id, name;
  final int? rssi;

  /// Advertises the standard heart-rate service.
  final bool heartRate;
}

class WatchUnsupported implements Exception {
  const WatchUnsupported();
}

/// Bluetooth access. The live one uses universal_ble; tests use a fake.
abstract class WatchService {
  /// Asks for Bluetooth permission and to turn Bluetooth on.
  Future<WatchReady> prepare();

  /// Devices already connected to the phone and nearby ones, as found.
  Stream<WatchDevice> scan();
  Future<void> stopScan();

  /// Connects and streams heart-rate readings. Throws [WatchUnsupported]
  /// when the device has no standard heart-rate service.
  Future<Stream<int>> connectHeartRate(String id);
  Future<int?> readBattery(String id);
  Future<void> disconnect(String id);
}

final watchServiceProvider = Provider<WatchService>((ref) => BleWatchService());

bool _same(String a, String b) {
  try {
    return BleUuidParser.string(a) == BleUuidParser.string(b);
  } on Object {
    return a.toLowerCase() == b.toLowerCase();
  }
}

class BleWatchService implements WatchService {
  StreamController<WatchDevice>? _scan;

  @override
  Future<WatchReady> prepare() async {
    try {
      final state = await UniversalBle.getBluetoothAvailabilityState();
      if (state == AvailabilityState.unsupported) return WatchReady.unsupported;
      try {
        await UniversalBle.requestPermissions();
      } on Object {
        return WatchReady.denied;
      }
      var now = await UniversalBle.getBluetoothAvailabilityState();
      if (now == AvailabilityState.unauthorized) return WatchReady.denied;
      if (now != AvailabilityState.poweredOn) {
        // Shows Android's "Allow this app to turn on Bluetooth?" dialog.
        try {
          await UniversalBle.enableBluetooth();
        } on Object {
          // The person said no, or this phone can't do it from an app.
        }
        now = await UniversalBle.getBluetoothAvailabilityState();
      }
      return now == AvailabilityState.poweredOn
          ? WatchReady.ready
          : WatchReady.off;
    } on Object {
      return WatchReady.unsupported;
    }
  }

  @override
  Stream<WatchDevice> scan() {
    _scan?.close();
    final out = _scan = StreamController<WatchDevice>();
    final seen = <String>{};
    void add(BleDevice d) {
      final name = d.name ?? d.rawName;
      if (name == null || name.trim().isEmpty || !seen.add(d.deviceId)) return;
      if (!out.isClosed) {
        out.add(
          WatchDevice(
            d.deviceId,
            name.trim(),
            rssi: d.rssi,
            heartRate: d.services.any((s) => _same(s, BleIds.heartRateService)),
          ),
        );
      }
    }

    UniversalBle.onScanResult = add;
    () async {
      try {
        // Watches already connected through their own app show up here.
        for (final d in await UniversalBle.getSystemDevices()) {
          add(d);
        }
      } on Object {
        // Not every phone lists these.
      }
      try {
        await UniversalBle.startScan();
      } on Object catch (e) {
        if (!out.isClosed) out.addError(e);
      }
    }();
    out.onCancel = stopScan;
    return out.stream;
  }

  @override
  Future<void> stopScan() async {
    UniversalBle.onScanResult = null;
    try {
      await UniversalBle.stopScan();
    } on Object {
      // Already stopped.
    }
  }

  @override
  Future<Stream<int>> connectHeartRate(String id) async {
    await UniversalBle.connect(id, timeout: const Duration(seconds: 20));
    final services = await UniversalBle.discoverServices(id);
    final hr = services.any(
      (s) =>
          _same(s.uuid, BleIds.heartRateService) &&
          s.characteristics.any(
            (c) => _same(c.uuid, BleIds.heartRateMeasurement),
          ),
    );
    if (!hr) throw const WatchUnsupported();
    final values = UniversalBle.characteristicValueStream(
      id,
      BleIds.heartRateMeasurement,
    );
    await UniversalBle.subscribeNotifications(
      id,
      BleIds.heartRateService,
      BleIds.heartRateMeasurement,
    );
    return values
        .map((Uint8List v) => parseHeartRate(v))
        .where((v) => v != null && v > 25 && v < 250)
        .cast<int>();
  }

  @override
  Future<int?> readBattery(String id) async {
    try {
      final v = await UniversalBle.read(
        id,
        BleIds.batteryService,
        BleIds.batteryLevel,
      );
      return v.isEmpty ? null : v.first;
    } on Object {
      return null;
    }
  }

  @override
  Future<void> disconnect(String id) async {
    try {
      await UniversalBle.disconnect(id);
    } on Object {
      // Already gone.
    }
  }
}
