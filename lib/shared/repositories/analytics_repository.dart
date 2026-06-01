import '../models/analytics_event.dart';

/// Public API surface for `UserAnalyticsStats`.
class UserAnalyticsStats {
  const UserAnalyticsStats({
    required this.userId,
    required this.totalEvents,
    required this.projectCreatedCount,
    required this.generationStartedCount,
    this.lastEventAt,
  });

  final String userId;
  final int totalEvents;
  final int projectCreatedCount;
  final int generationStartedCount;
  final DateTime? lastEventAt;
}

/// Contract for AnalyticsRepository implementations.
///
/// Implementations may be backed by mock memory stores, Supabase, or the
/// Fastify API. Callers should depend on this abstraction through Riverpod
/// providers so feature code stays portable across local and production modes.
abstract class AnalyticsRepository {
  Future<void> trackEvent(AnalyticsEvent event);

  Future<List<AnalyticsEvent>> getEvents({String? userId});

  Future<UserAnalyticsStats> getUserStats(String userId);

  Stream<List<AnalyticsEvent>> watchEvents({String? userId});
}
