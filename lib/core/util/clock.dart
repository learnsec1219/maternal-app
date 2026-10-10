import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dates.dart';

/// Today's date; overridden in tests to pin the calendar.
final todayProvider = Provider<DateTime>((ref) => dateOnly(DateTime.now()));
