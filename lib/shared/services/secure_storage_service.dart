import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Public API surface for `SecureStorageClient`.
abstract class SecureStorageClient {
  Future<void> write({required String key, required String? value});

  Future<String?> read({required String key});

  Future<bool> containsKey({required String key});

  Future<void> delete({required String key});

  Future<void> deleteAll();
}

/// Secure storage wrapper for auth tokens and user-provided API keys.
class FlutterSecureStorageClient implements SecureStorageClient {
  const FlutterSecureStorageClient([
    this._storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        resetOnError: true,
        migrateOnAlgorithmChange: true,
      ),
    ),
  ]);

  final FlutterSecureStorage _storage;

  @override
  Future<bool> containsKey({required String key}) {
    return _storage.containsKey(key: key);
  }

  @override
  Future<void> delete({required String key}) {
    return _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() => _storage.deleteAll();

  @override
  Future<String?> read({required String key}) {
    return _storage.read(key: key);
  }

  @override
  Future<void> write({required String key, required String? value}) {
    return _storage.write(key: key, value: value);
  }
}

/// Secure storage wrapper for auth tokens and user-provided API keys.
class SecureStorageService {
  const SecureStorageService(this._client);

  static const accessTokenKey = 'auth.access_token';
  static const refreshTokenKey = 'auth.refresh_token';
  static const userIdKey = 'auth.user_id';
  static const apiKeyPrefix = 'api_key.';

  final SecureStorageClient _client;

  Future<void> write(String key, String value) {
    return _client.write(key: key, value: value);
  }

  Future<void> writeNullable(String key, String? value) {
    return _client.write(key: key, value: value);
  }

  Future<String?> read(String key) => _client.read(key: key);

  Future<bool> containsKey(String key) => _client.containsKey(key: key);

  Future<void> delete(String key) => _client.delete(key: key);

  Future<void> clear() => _client.deleteAll();

  Future<void> writeJson(String key, Map<String, dynamic> value) {
    return write(key, jsonEncode(value));
  }

  Future<Map<String, dynamic>?> readJson(String key) async {
    final value = await read(key);
    if (value == null || value.isEmpty) {
      return null;
    }

    final decoded = jsonDecode(value);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    if (decoded is Map) {
      return Map<String, dynamic>.from(decoded);
    }

    return null;
  }

  Future<void> saveAuthTokens({
    required String accessToken,
    required String refreshToken,
    String? userId,
  }) async {
    await write(accessTokenKey, accessToken);
    await write(refreshTokenKey, refreshToken);
    if (userId != null) {
      await write(userIdKey, userId);
    }
  }

  Future<String?> readAccessToken() => read(accessTokenKey);

  Future<String?> readRefreshToken() => read(refreshTokenKey);

  Future<String?> readUserId() => read(userIdKey);

  Future<void> deleteAuthTokens() async {
    await delete(accessTokenKey);
    await delete(refreshTokenKey);
    await delete(userIdKey);
  }

  Future<void> saveApiKey(String provider, String apiKey) {
    return write(_apiKey(provider), apiKey);
  }

  Future<String?> readApiKey(String provider) => read(_apiKey(provider));

  Future<void> deleteApiKey(String provider) => delete(_apiKey(provider));

  String _apiKey(String provider) {
    return '$apiKeyPrefix${provider.trim().toLowerCase()}';
  }
}
