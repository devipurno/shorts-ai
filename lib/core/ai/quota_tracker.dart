import 'dart:convert';

import '../../shared/services/preferences_service.dart';

class QuotaTracker {
  QuotaTracker({
    PreferencesService? preferences,
    DateTime Function()? now,
    Map<String, int?> quotas = defaultQuotas,
  })  : _preferences = preferences,
        _now = now ?? DateTime.now,
        _quotas = quotas;

  static const defaultQuotas = <String, int?>{
    'gemini': 1500,
    'groq': 6000,
    'groq_whisper': 30,
    'deepseek': null,
  };

  static const _storageKey = 'ai.quota.usage';

  final PreferencesService? _preferences;
  final DateTime Function() _now;
  final Map<String, int?> _quotas;
  final Map<String, _QuotaUsage> _memory = {};

  Future<bool> canUseProvider(String name) async {
    final quota = _quotas[name];
    if (quota == null) {
      return true;
    }
    final usage = await _usageFor(name);
    return usage.count < quota;
  }

  Future<void> recordUsage(String name, {int amount = 1}) async {
    final usage = await _usageFor(name);
    _memory[name] = usage.copyWith(count: usage.count + amount);
    await _persist();
  }

  Future<int?> getRemainingQuota(String name) async {
    final quota = _quotas[name];
    if (quota == null) {
      return null;
    }
    final usage = await _usageFor(name);
    return (quota - usage.count).clamp(0, quota).toInt();
  }

  Future<_QuotaUsage> _usageFor(String name) async {
    await _load();
    final today = _dateKey(_now().toUtc().add(const Duration(hours: 7)));
    final usage = _memory[name];
    if (usage == null || usage.dateKey != today) {
      final fresh = _QuotaUsage(dateKey: today, count: 0);
      _memory[name] = fresh;
      await _persist();
      return fresh;
    }
    return usage;
  }

  Future<void> _load() async {
    if (_memory.isNotEmpty || _preferences == null) {
      return;
    }
    final raw = _preferences.getString(_storageKey);
    if (raw == null || raw.isEmpty) {
      return;
    }
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    for (final entry in decoded.entries) {
      _memory[entry.key] = _QuotaUsage.fromJson(
        Map<String, Object?>.from(entry.value as Map),
      );
    }
  }

  Future<void> _persist() async {
    final preferences = _preferences;
    if (preferences == null) {
      return;
    }
    final data = {
      for (final entry in _memory.entries) entry.key: entry.value.toJson(),
    };
    await preferences.setString(_storageKey, jsonEncode(data));
  }

  String _dateKey(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '${value.year}-$month-$day';
  }
}

class _QuotaUsage {
  const _QuotaUsage({required this.dateKey, required this.count});

  final String dateKey;
  final int count;

  _QuotaUsage copyWith({int? count}) {
    return _QuotaUsage(dateKey: dateKey, count: count ?? this.count);
  }

  Map<String, Object?> toJson() => {'date': dateKey, 'count': count};

  factory _QuotaUsage.fromJson(Map<String, Object?> json) {
    return _QuotaUsage(
      dateKey: json['date']?.toString() ?? '',
      count: (json['count'] as num?)?.toInt() ?? 0,
    );
  }
}
