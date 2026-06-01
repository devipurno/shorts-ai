import 'package:dio/dio.dart';

import '../../models/notification.dart';
import '../notification_repository.dart';
import 'api_repository_helpers.dart';

/// Public API surface for `ApiNotificationRepository`.
class ApiNotificationRepository implements NotificationRepository {
  ApiNotificationRepository({Dio? dio})
      : _client = ApiResourceClient<AppNotification>(
          path: '/notifications',
          fromJson: AppNotification.fromJson,
          toJson: (notification) => notification.toJson(),
          idOf: (notification) => notification.id,
          dio: dio,
        );

  final ApiResourceClient<AppNotification> _client;

  @override
  Future<List<AppNotification>> getAll({
    String? userId,
    bool unreadOnly = false,
  }) {
    return _client.getAll(query: {
      'user_id': userId,
      'unread_only': unreadOnly ? 'true' : null,
    });
  }

  @override
  Future<AppNotification?> getById(String id) => _client.getById(id);

  @override
  Future<AppNotification> create(AppNotification notification) {
    return _client.create(notification);
  }

  @override
  Future<AppNotification> update(AppNotification notification) {
    return _client.update(notification);
  }

  @override
  Future<AppNotification> markRead(String id) async {
    final existing = await getById(id);
    if (existing == null) {
      throw StateError('Notification not found: $id');
    }
    return update(existing.copyWith(isRead: true));
  }

  @override
  Future<void> delete(String id) => _client.delete(id);

  @override
  Stream<List<AppNotification>> watch({
    String? userId,
    bool unreadOnly = false,
  }) async* {
    yield await getAll(userId: userId, unreadOnly: unreadOnly);
  }
}
