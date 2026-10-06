import 'dart:math';

final _rand = Random();

/// Locally unique id for records created on the device.
String newId() =>
    '${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}'
    '${_rand.nextInt(1 << 32).toRadixString(36)}';
