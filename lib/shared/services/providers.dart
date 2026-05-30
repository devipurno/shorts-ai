import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache_service.dart';
import 'preferences_service.dart';
import 'secure_storage_service.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});

final preferencesServiceProvider =
    FutureProvider<PreferencesService>((ref) async {
  final preferences = await ref.watch(sharedPreferencesProvider.future);
  return PreferencesService(preferences);
});

final secureStorageClientProvider = Provider<SecureStorageClient>((ref) {
  return const FlutterSecureStorageClient();
});

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService(ref.watch(secureStorageClientProvider));
});

final cacheServiceProvider = FutureProvider<CacheService>((ref) async {
  final preferences = await ref.watch(preferencesServiceProvider.future);
  return CacheService(preferences);
});
