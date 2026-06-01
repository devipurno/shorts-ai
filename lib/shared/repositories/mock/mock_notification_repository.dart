import 'dart:async';

import 'package:faker/faker.dart';

import '../../../core/errors/app_exception.dart';
import '../../models/notification.dart';
import '../notification_repository.dart';
import 'mock_repository_utils.dart';

/// Public API surface for `MockNotificationRepository`.
class MockNotificationRepository implements NotificationRepository {
  MockNotificationRepository({
    MockRepositoryConfig config = const MockRepositoryConfig(),
  })  : _runtime = MockRepositoryRuntime(config),
        _faker = Faker() {
    _notifications.addAll(_seedNotifications());
  }

  final MockRepositoryRuntime _runtime;
  final Faker _faker;
  final _controller = StreamController<void>.broadcast();
  final _notifications = <AppNotification>[];

  @override
  Future<List<AppNotification>> getAll({
    String? userId,
    bool unreadOnly = false,
  }) async {
    await _runtime.simulateNetwork();
    return List<AppNotification>.unmodifiable(_filter(userId, unreadOnly));
  }

  @override
  Future<AppNotification?> getById(String id) async {
    await _runtime.simulateNetwork();
    return _notifications.where((item) => item.id == id).firstOrNull;
  }

  @override
  Future<AppNotification> create(AppNotification notification) async {
    await _runtime.simulateNetwork();
    _notifications.add(notification);
    _emit();
    return notification;
  }

  @override
  Future<AppNotification> update(AppNotification notification) async {
    await _runtime.simulateNetwork();
    final index =
        _notifications.indexWhere((item) => item.id == notification.id);
    if (index == -1) {
      throw const NotFoundException(
        'Notification not found.',
        code: 'notification_not_found',
      );
    }
    _notifications[index] = notification;
    _emit();
    return notification;
  }

  @override
  Future<AppNotification> markRead(String id) async {
    await _runtime.simulateNetwork();
    final index = _notifications.indexWhere((item) => item.id == id);
    if (index == -1) {
      throw const NotFoundException(
        'Notification not found.',
        code: 'notification_not_found',
      );
    }
    final updated = _notifications[index].copyWith(isRead: true);
    _notifications[index] = updated;
    _emit();
    return updated;
  }

  @override
  Future<void> delete(String id) async {
    await _runtime.simulateNetwork();
    _notifications.removeWhere((notification) => notification.id == id);
    _emit();
  }

  @override
  Stream<List<AppNotification>> watch({
    String? userId,
    bool unreadOnly = false,
  }) async* {
    await _runtime.simulateNetwork();
    yield List<AppNotification>.unmodifiable(_filter(userId, unreadOnly));
    yield* _controller.stream.map(
      (_) => List<AppNotification>.unmodifiable(_filter(userId, unreadOnly)),
    );
  }

  List<AppNotification> _seedNotifications() {
    return List<AppNotification>.generate(8, (index) {
      return AppNotification(
        id: 'notification_${index + 1}',
        userId: 'user_${index % 3 + 1}',
        title: index.isEven ? 'Short ready' : 'Template unlocked',
        body: _faker.lorem.sentence(),
        type: index.isEven ? 'success' : 'info',
        deepLink: index.isEven ? '/library' : '/templates',
        isRead: index % 3 == 0,
        createdAt:
            DateTime.now().toUtc().subtract(Duration(minutes: index * 12)),
      );
    });
  }

  List<AppNotification> _filter(String? userId, bool unreadOnly) {
    return _notifications.where((notification) {
      final matchesUser = userId == null || notification.userId == userId;
      final matchesRead = !unreadOnly || !notification.isRead;
      return matchesUser && matchesRead;
    }).toList();
  }

  void _emit() => _controller.add(null);
}
