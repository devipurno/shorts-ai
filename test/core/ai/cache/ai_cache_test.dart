import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/ai/cache/ai_cache.dart';
import 'package:shorts_ai/core/ai/cache/upstash_client.dart';

void main() {
  test('AICache get set delete uses in-memory fallback', () async {
    final cache = AICache();

    await cache.set('ai:test:key', 'value', ttl: const Duration(minutes: 1));
    expect(await cache.get('ai:test:key'), 'value');

    await cache.delete('ai:test:key');
    expect(await cache.get('ai:test:key'), isNull);
  });

  test('AICache falls back when Upstash is unreachable', () async {
    final cache = AICache(upstashClient: _FailingUpstashClient());

    await cache.set('ai:test:fallback', 'cached');
    expect(await cache.get('ai:test:fallback'), 'cached');
  });

  test('AICache expires in-memory entries by TTL', () async {
    var now = DateTime.utc(2026, 6, 1, 10);
    final cache = AICache(now: () => now);

    await cache.set('ai:test:ttl', 'short', ttl: const Duration(seconds: 5));
    expect(await cache.get('ai:test:ttl'), 'short');

    now = now.add(const Duration(seconds: 6));
    expect(await cache.get('ai:test:ttl'), isNull);
  });
}

class _FailingUpstashClient extends UpstashClient {
  _FailingUpstashClient() : super(restUrl: 'https://redis.test', token: 'token');

  @override
  bool get isConfigured => true;

  @override
  Future<String?> get(String key) => throw StateError('offline');

  @override
  Future<void> set(String key, String value, {Duration? ttl}) async {
    throw StateError('offline');
  }

  @override
  Future<void> delete(String key) async {
    throw StateError('offline');
  }
}
