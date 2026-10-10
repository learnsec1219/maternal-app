import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Text in each app language. Falls back to English when a language is
/// missing, so new content never shows blank.
class LocalText {
  const LocalText(this._byLang);

  factory LocalText.fromJson(Object? json) => LocalText({
    for (final e in (json as Map? ?? const {}).entries)
      e.key as String: e.value as String,
  });

  final Map<String, String> _byLang;

  String of(String languageCode) =>
      _byLang[languageCode] ?? _byLang['en'] ?? '';
}

class WarningSign {
  const WarningSign(this.code, this.journeys, this.title, this.advice);
  final String code;
  final List<String> journeys;
  final LocalText title, advice;
}

class SymptomOption {
  const SymptomOption(this.code, this.label);
  final String code;
  final LocalText label;
}

class VaccineSchedule {
  const VaccineSchedule({
    required this.key,
    required this.startWeek,
    required this.endWeek,
    required this.postpartum,
    required this.name,
    required this.window,
    required this.description,
  });
  final String key;
  final int startWeek, endWeek;
  final bool postpartum;
  final LocalText name, window, description;
}

class ReferenceRange {
  const ReferenceRange(this.low, this.high);
  final double? low, high;
}

/// Clinical rules and wording. Every value is pending review by a qualified
/// clinician and lives in `assets/content/clinical_content.json`, not in code.
class ClinicalContent {
  ClinicalContent(Map<String, dynamic> j)
    : version = j['version'] as String,
      emergencyNumber = j['emergencyNumber'] as String,
      dating = (j['dating'] as Map).cast<String, num>(),
      cycle = (j['cycle'] as Map).cast<String, num>(),
      counters = (j['counters'] as Map).cast<String, num>(),
      activityFactors = ((j['energy'] as Map)['activityFactors'] as Map)
          .cast<String, num>(),
      pregnancyExtraKcal = ((j['energy'] as Map)['pregnancyExtraKcal'] as Map)
          .cast<String, num>(),
      ranges = {
        for (final r in j['ranges'] as List)
          r['key'] as String: ReferenceRange(
            (r['low'] as num?)?.toDouble(),
            (r['high'] as num?)?.toDouble(),
          ),
      },
      warningSigns = [
        for (final w in j['warningSigns'] as List)
          WarningSign(
            w['code'] as String,
            (w['journeys'] as List).cast<String>(),
            LocalText.fromJson(w['title']),
            LocalText.fromJson(w['advice']),
          ),
      ],
      symptoms = [
        for (final s in j['symptoms'] as List)
          SymptomOption(s['code'] as String, LocalText.fromJson(s['label'])),
      ],
      vaccines = [
        for (final v in j['vaccines'] as List)
          VaccineSchedule(
            key: v['key'] as String,
            startWeek: (v['startWeek'] as num).toInt(),
            endWeek: (v['endWeek'] as num).toInt(),
            postpartum: v['postpartum'] as bool,
            name: LocalText.fromJson(v['name']),
            window: LocalText.fromJson(v['window']),
            description: LocalText.fromJson(v['description']),
          ),
      ],
      education = {
        for (final e in (j['education'] as Map).entries)
          e.key as String: LocalText.fromJson(e.value),
      };

  static const assetPath = 'assets/content/clinical_content.json';

  static Future<ClinicalContent> load([AssetBundle? bundle]) async {
    final raw = await (bundle ?? rootBundle).loadString(assetPath);
    return ClinicalContent(jsonDecode(raw) as Map<String, dynamic>);
  }

  final String version, emergencyNumber;
  final Map<String, num> dating, cycle, counters;
  final Map<String, num> activityFactors, pregnancyExtraKcal;
  final Map<String, ReferenceRange> ranges;
  final List<WarningSign> warningSigns;
  final List<SymptomOption> symptoms;
  final List<VaccineSchedule> vaccines;
  final Map<String, LocalText> education;

  String symptomLabel(String code, String lang) {
    for (final s in symptoms) {
      if (s.code == code) return s.label.of(lang);
    }
    for (final w in warningSigns) {
      if (w.code == code) return w.title.of(lang);
    }
    return code;
  }

  bool isWarningSign(String code) => warningSigns.any((w) => w.code == code);
}

/// Loaded in `main()` before the app starts.
final contentProvider = Provider<ClinicalContent>(
  (ref) => throw UnimplementedError('contentProvider not overridden'),
);
