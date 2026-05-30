import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorts_ai/shared/services/cache_service.dart';
import 'package:shorts_ai/shared/services/preferences_service.dart';
import 'package:shorts_ai/shared/services/providers.dart';
import 'package:shorts_ai/shared/services/secure_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PreferencesService', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('wraps primitive SharedPreferences operations', () async {
      final preferences = await SharedPreferences.getInstance();
      final service = PreferencesService(preferences);

      await service.setString('name', 'AutoShort');
      await service.setInt('count', 3);
      await service.setDouble('ratio', 1.5);
      await service.setBool('seen', true);
      await service.setStringList('tags', ['ai', 'shorts']);

      expect(service.getString('name'), 'AutoShort');
      expect(service.getInt('count'), 3);
      expect(service.getDouble('ratio'), 1.5);
      expect(service.getBool('seen'), isTrue);
      expect(service.getStringList('tags'), ['ai', 'shorts']);
      expect(service.containsKey('name'), isTrue);

      await service.remove('name');
      expect(service.getString('name'), isNull);

      await service.clear();
      expect(service.getKeys(), isEmpty);
    });
  });

  group('SecureStorageService', () {
    setUp(() {
      FlutterSecureStorage.setMockInitialValues({});
    });

    test('stores auth tokens and API keys securely', () async {
      const service = SecureStorageService(FlutterSecureStorageClient());

      await service.saveAuthTokens(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        userId: 'user_1',
      );
      await service.saveApiKey('OpenAI', 'sk-test');
      await service.writeJson('secret.profile', {'role': 'creator'});

      expect(await service.readAccessToken(), 'access-token');
      expect(await service.readRefreshToken(), 'refresh-token');
      expect(await service.readUserId(), 'user_1');
      expect(await service.readApiKey('openai'), 'sk-test');
      expect(await service.containsKey('secret.profile'), isTrue);
      expect(await service.readJson('secret.profile'), {'role': 'creator'});

      await service.deleteAuthTokens();
      expect(await service.readAccessToken(), isNull);
      expect(await service.readRefreshToken(), isNull);
      expect(await service.readUserId(), isNull);

      await service.clear();
      expect(await service.readApiKey('openai'), isNull);
    });
  });

  group('CacheService', () {
    late SharedPreferences preferences;
    late PreferencesService preferencesService;
    late DateTime now;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      preferences = await SharedPreferences.getInstance();
      preferencesService = PreferencesService(preferences);
      now = DateTime.utc(2026, 5, 30, 10);
    });

    test('caches JSON until expiry', () async {
      final cache = CacheService(
        preferencesService,
        now: () => now,
        defaultTtl: const Duration(minutes: 5),
      );

      await cache.setJson('project', {'id': 'project_1'});
      await cache.setJsonList('projects', [
        {'id': 'project_1'},
        {'id': 'project_2'},
      ]);

      expect(cache.getJson('project'), {'id': 'project_1'});
      expect(cache.getJsonList('projects'), [
        {'id': 'project_1'},
        {'id': 'project_2'},
      ]);
      expect(cache.containsFresh('project'), isTrue);

      now = now.add(const Duration(minutes: 6));

      expect(cache.getJson('project'), isNull);
      expect(cache.containsFresh('projects'), isFalse);
    });

    test('clears expired and all cache keys without touching other prefs',
        () async {
      final cache = CacheService(
        preferencesService,
        now: () => now,
        defaultTtl: const Duration(minutes: 5),
      );

      await preferencesService.setString('plain', 'keep');
      await cache.setJson('fresh', {'ok': true});
      await cache.setJson('expired', {'ok': false},
          ttl: const Duration(seconds: 1));

      now = now.add(const Duration(seconds: 2));
      await cache.clearExpired();

      expect(cache.getJson('fresh'), {'ok': true});
      expect(cache.getJson('expired'), isNull);
      expect(preferencesService.getString('plain'), 'keep');

      await cache.clearAll();
      expect(cache.getJson('fresh'), isNull);
      expect(preferencesService.getString('plain'), 'keep');
    });
  });

  test('service providers expose storage services', () async {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});

    final container = ProviderContainer();
    addTearDown(container.dispose);

    final preferences = await container.read(preferencesServiceProvider.future);
    final cache = await container.read(cacheServiceProvider.future);
    final secureStorage = container.read(secureStorageServiceProvider);

    await preferences.setString('provider.key', 'value');
    await cache.setJson('provider.cache', {'ok': true});
    await secureStorage.write('provider.secret', 'secret');

    expect(preferences.getString('provider.key'), 'value');
    expect(cache.getJson('provider.cache'), {'ok': true});
    expect(await secureStorage.read('provider.secret'), 'secret');
  });
}
