import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorts_ai/shared/repositories/sync/sync_service.dart';

void main() {
  test('OfflineWrite JSON round-trips queued API mutations', () {
    final write = OfflineWrite(
      method: 'POST',
      path: '/projects',
      body: {'title': 'Launch'},
      queuedAt: DateTime.utc(2026, 6),
    );

    final copy = OfflineWrite.fromJson(write.toJson());

    expect(copy.method, 'POST');
    expect(copy.path, '/projects');
    expect(copy.body['title'], 'Launch');
    expect(copy.queuedAt, DateTime.utc(2026, 6));
  });

  test('SyncService stores failed writes and checks connectivity', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final controller = StreamController<List<ConnectivityResult>>();
    addTearDown(controller.close);
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final service = SyncService(
      container.read,
      preferences: preferences,
      connectivityStream: controller.stream,
      checkConnectivity: () async => [ConnectivityResult.wifi],
    );
    addTearDown(service.dispose);

    await service.enqueueFailedWrite(
      const OfflineWrite(method: 'PATCH', path: '/projects/project_1'),
    );

    expect(await service.pendingWrites(), hasLength(1));
    expect(await service.isOnline(), isTrue);
  });
}
