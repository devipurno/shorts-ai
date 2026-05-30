import '../models/notification.dart';

abstract class NotificationRepository {
  Future<List<AppNotification>> getAll({
    String? userId,
    bool unreadOnly = false,
  });

  Future<AppNotification?> getById(String id);

  Future<AppNotification> create(AppNotification notification);

  Future<AppNotification> update(AppNotification notification);

  Future<AppNotification> markRead(String id);

  Future<void> delete(String id);

  Stream<List<AppNotification>> watch({
    String? userId,
    bool unreadOnly = false,
  });
}
