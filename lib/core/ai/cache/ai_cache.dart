import 'dart:async';

import 'upstash_client.dart';

class AICache {
  AICache({UpstashClient? upstashClient, DateTime Function()? now})
      : _upstash = upstashClient,
        _now = now ?? DateTime.now;

  final UpstashClient? _upstash;
  final DateTime Function() _now;
  final Map<String, _MemoryCacheEntry> _memory = {};
  bool _upstashAvailable = true;

  Future<String?> get(String key) async {
    if (_canTryUpstash) {
      try {
        final value = await _upstash!.get(key);
        if (value != null) {
          return value;
        }
      } catch (_) {
        _upstashAvailable = false;
      }
    }

    final entry = _memory[key];
    if (entry == null) {
      return null;
    }
    if (entry.isExpired(_now())) {
      _memory.remove(key);
      return null;
    }
    return entry.value;
  }

  Future<void> set(String key, String value, {Duration? ttl}) async {
    if (_canTryUpstash) {
      try {
        await _upstash!.set(key, value, ttl: ttl);
        return;
      } catch (_) {
        _upstashAvailable = false;
      }
    }

    _memory[key] = _MemoryCacheEntry(
      value: value,
      expiresAt: ttl == null ? null : _now().add(ttl),
    );
  }

  Future<void> delete(String key) async {
    _memory.remove(key);
    if (_canTryUpstash) {
      try {
        await _upstash!.delete(key);
      } catch (_) {
        _upstashAvailable = false;
      }
    }
  }

  bool get _canTryUpstash =>
      _upstashAvailable && _upstash != null && _upstash.isConfigured;
}

class _MemoryCacheEntry {
  const _MemoryCacheEntry({required this.value, this.expiresAt});

  final String value;
  final DateTime? expiresAt;

  bool isExpired(DateTime now) => expiresAt != null && !expiresAt!.isAfter(now);
}
