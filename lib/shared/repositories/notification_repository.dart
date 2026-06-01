import '../models/notification.dart';

/// Contract for NotificationRepository implementations.
///
/// Implementations may be backed by mock memory stores, Supabase, or the
/// Fastify API. Callers should depend on this abstraction through Riverpod
/// providers so feature code stays portable across local and production modes.
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
