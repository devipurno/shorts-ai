import 'package:dio/dio.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/network/api_exception_mapper.dart';
import '../../../core/network/dio_client.dart';
import '../../models/analytics_event.dart';
import '../analytics_repository.dart';
import 'api_repository_helpers.dart';

/// Public API surface for `ApiAnalyticsRepository`.
class ApiAnalyticsRepository implements AnalyticsRepository {
  ApiAnalyticsRepository({Dio? dio})
      : _dio = dio ?? DioClient.instance.dio,
        _client = ApiResourceClient<AnalyticsEvent>(
          path: '/analytics/events',
          fromJson: AnalyticsEvent.fromJson,
          toJson: (event) => event.toJson(),
          idOf: (event) => event.id,
          dio: dio,
        );

  final Dio _dio;
  final ApiResourceClient<AnalyticsEvent> _client;

  @override
  Future<void> trackEvent(AnalyticsEvent event) async {
    await _client.create(event);
  }

  @override
  Future<List<AnalyticsEvent>> getEvents({String? userId}) {
    return _client.getAll(query: {'user_id': userId});
  }

  @override
  Future<UserAnalyticsStats> getUserStats(String userId) async {
    try {
      final response =
          await _dio.get<dynamic>('/analytics/users/$userId/stats');
      final data = response.data is Map && response.data['data'] is Map
          ? response.data['data'] as Map
          : response.data as Map;
      return UserAnalyticsStats(
        userId: data['user_id']?.toString() ?? userId,
        totalEvents: (data['total_events'] as num? ?? 0).toInt(),
        projectCreatedCount:
            (data['project_created_count'] as num? ?? 0).toInt(),
        generationStartedCount:
            (data['generation_started_count'] as num? ?? 0).toInt(),
        lastEventAt: data['last_event_at'] == null
            ? null
            : DateTime.tryParse(data['last_event_at'].toString()),
      );
    } on DioException catch (error) {
      throw error.error is AppException
          ? error.error! as AppException
          : mapDioError(error);
    }
  }

  @override
  Stream<List<AnalyticsEvent>> watchEvents({String? userId}) async* {
    yield await getEvents(userId: userId);
  }
}
