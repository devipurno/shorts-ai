import '../models/analytics_event.dart';

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

abstract class AnalyticsRepository {
  Future<void> trackEvent(AnalyticsEvent event);

  Future<List<AnalyticsEvent>> getEvents({String? userId});

  Future<UserAnalyticsStats> getUserStats(String userId);

  Stream<List<AnalyticsEvent>> watchEvents({String? userId});
}
