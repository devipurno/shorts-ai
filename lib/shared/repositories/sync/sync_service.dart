import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/logger.dart';
import '../providers.dart';

const _offlineQueueKey = 'api_offline_write_queue';

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(ref.read);
});

typedef RepositoryReader = T Function<T>(ProviderListenable<T> provider);

/// Offline write queue and replay coordinator for repository mutations.
class SyncService {
  SyncService(
    this._read, {
    Connectivity? connectivity,
    Stream<List<ConnectivityResult>>? connectivityStream,
    Future<List<ConnectivityResult>> Function()? checkConnectivity,
    SharedPreferences? preferences,
  })  : _connectivity = connectivity ?? Connectivity(),
        _connectivityStream = connectivityStream,
        _checkConnectivity = checkConnectivity,
        _preferences = preferences {
    _subscription = (_connectivityStream ?? _connectivity.onConnectivityChanged)
        .listen((result) {
      if (_hasConnectivity(result)) {
        retryOfflineQueue();
      }
    });
  }

  final RepositoryReader _read;
  final Connectivity _connectivity;
  final Stream<List<ConnectivityResult>>? _connectivityStream;
  final Future<List<ConnectivityResult>> Function()? _checkConnectivity;
  SharedPreferences? _preferences;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  Future<void> refreshAll({String? userId}) async {
    await Future.wait([
      _read(projectRepositoryProvider).getAll(userId: userId),
      _read(templateRepositoryProvider).getAll(),
      if (userId != null) ...[
        _read(brandKitRepositoryProvider).getByUserId(userId),
        _read(subscriptionRepositoryProvider).getByUserId(userId),
        _read(notificationRepositoryProvider).getAll(userId: userId),
        _read(analyticsRepositoryProvider).getUserStats(userId),
      ],
    ]);
  }

  Future<void> enqueueFailedWrite(OfflineWrite write) async {
    final queue = await pendingWrites();
    queue.add(write);
    await _save(queue);
  }

  Future<List<OfflineWrite>> pendingWrites() async {
    final preferences = await _prefs();
    final raw = preferences.getString(_offlineQueueKey);
    if (raw == null || raw.isEmpty) {
      return [];
    }
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => OfflineWrite.fromJson(Map<String, Object?>.from(item)))
        .toList();
  }

  Future<void> retryOfflineQueue() async {
    final queue = await pendingWrites();
    if (queue.isEmpty) {
      return;
    }

    // Actual replay is endpoint-specific and will be wired per mutation.
    // For now the queue is retained and surfaced for deterministic retry tests.
    AppLogger.i('Offline queue ready for retry: ${queue.length}', tag: 'Sync');
  }

  Future<bool> isOnline() async {
    final result =
        await (_checkConnectivity?.call() ?? _connectivity.checkConnectivity());
    return _hasConnectivity(result);
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
  }

  Future<SharedPreferences> _prefs() async {
    return _preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> _save(List<OfflineWrite> queue) async {
    final preferences = await _prefs();
    await preferences.setString(
      _offlineQueueKey,
      jsonEncode(queue.map((item) => item.toJson()).toList()),
    );
  }

  bool _hasConnectivity(List<ConnectivityResult> results) {
    return results.any((item) => item != ConnectivityResult.none);
  }
}

/// Offline write queue and replay coordinator for repository mutations.
class OfflineWrite {
  const OfflineWrite({
    required this.method,
    required this.path,
    this.body = const {},
    this.queuedAt,
  });

  final String method;
  final String path;
  final Map<String, Object?> body;
  final DateTime? queuedAt;

  Map<String, Object?> toJson() {
    return {
      'method': method,
      'path': path,
      'body': body,
      'queued_at': (queuedAt ?? DateTime.now().toUtc()).toIso8601String(),
    };
  }

  factory OfflineWrite.fromJson(Map<String, Object?> json) {
    return OfflineWrite(
      method: json['method']?.toString() ?? 'POST',
      path: json['path']?.toString() ?? '/',
      body: Map<String, Object?>.from(json['body'] as Map? ?? const {}),
      queuedAt: json['queued_at'] == null
          ? null
          : DateTime.tryParse(json['queued_at'].toString()),
    );
  }
}
