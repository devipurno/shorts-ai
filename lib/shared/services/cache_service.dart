import 'dart:convert';

import 'preferences_service.dart';

/// JSON cache service with expiry semantics for lightweight local data.
class CacheService {
  CacheService(
    this._preferences, {
    DateTime Function()? now,
    this.defaultTtl = const Duration(minutes: 30),
  }) : _now = now ?? DateTime.now;

  static const _prefix = 'cache.json.';

  final PreferencesService _preferences;
  final DateTime Function() _now;
  final Duration defaultTtl;

  Future<bool> setJson(
    String key,
    Map<String, dynamic> value, {
    Duration? ttl,
  }) {
    return _preferences.setString(
      _cacheKey(key),
      _encode(value, ttl ?? defaultTtl),
    );
  }

  Future<bool> setJsonList(
    String key,
    List<Map<String, dynamic>> value, {
    Duration? ttl,
  }) {
    return _preferences.setString(
      _cacheKey(key),
      _encode(value, ttl ?? defaultTtl),
    );
  }

  Map<String, dynamic>? getJson(String key) {
    final value = _readValue(key);
    if (value == null) {
      return null;
    }

    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return null;
  }

  List<Map<String, dynamic>>? getJsonList(String key) {
    final value = _readValue(key);
    if (value == null) {
      return null;
    }

    if (value is! List) {
      return null;
    }

    return value.map((item) => Map<String, dynamic>.from(item as Map)).toList();
  }

  bool containsFresh(String key) => _readValue(key) != null;

  Future<bool> remove(String key) => _preferences.remove(_cacheKey(key));

  Future<void> clearExpired() async {
    final keys = _preferences.getKeys().where((key) => key.startsWith(_prefix));
    for (final key in keys) {
      final payload = _decodePayload(_preferences.getString(key));
      if (payload == null || _isExpired(payload)) {
        await _preferences.remove(key);
      }
    }
  }

  Future<void> clearAll() async {
    final keys = _preferences.getKeys().where((key) => key.startsWith(_prefix));
    for (final key in keys) {
      await _preferences.remove(key);
    }
  }

  Object? _readValue(String key) {
    final cacheKey = _cacheKey(key);
    final payload = _decodePayload(_preferences.getString(cacheKey));
    if (payload == null || _isExpired(payload)) {
      _preferences.remove(cacheKey);
      return null;
    }

    return payload['value'];
  }

  String _encode(Object? value, Duration ttl) {
    final now = _now().toUtc();
    return jsonEncode({
      'cached_at': now.toIso8601String(),
      'expires_at': now.add(ttl).toIso8601String(),
      'value': value,
    });
  }

  Map<String, dynamic>? _decodePayload(String? raw) {
    if (raw == null || raw.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  bool _isExpired(Map<String, dynamic> payload) {
    final expiresAt =
        DateTime.tryParse(payload['expires_at']?.toString() ?? '');
    if (expiresAt == null) {
      return true;
    }
    return !_now().toUtc().isBefore(expiresAt.toUtc());
  }

  String _cacheKey(String key) => '$_prefix$key';
}
