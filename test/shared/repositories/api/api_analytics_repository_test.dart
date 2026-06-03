import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shorts_ai/core/errors/app_exception.dart';
import 'package:shorts_ai/core/network/dio_client.dart';
import 'package:shorts_ai/shared/models/analytics_event.dart';
import 'package:shorts_ai/shared/repositories/api/api_analytics_repository.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late ApiAnalyticsRepository repository;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://api.autoshort.test'));
    adapter = DioAdapter(dio: dio);
    dio.interceptors.add(ErrorMappingInterceptor());
    repository = ApiAnalyticsRepository(dio: dio);
  });

  test('trackEvent posts event to API', () async {
    final event = _event('evt_1');
    adapter.onPost(
      '/analytics/events',
      data: event.toJson(),
      (server) => server.reply(200, {'data': event.toJson()}),
    );
    await repository.trackEvent(event);
  });

  test('getEvents returns event list with optional user filter', () async {
    adapter.onGet(
      '/analytics/events',
      queryParameters: {'user_id': 'user_1'},
      (server) => server.reply(200, {
        'data': [_eventJson('evt_1')],
      }),
    );
    final events = await repository.getEvents(userId: 'user_1');
    expect(events, hasLength(1));
    expect(events.first.id, 'evt_1');
  });

  test('getUserStats parses wrapped stats response', () async {
    adapter.onGet(
      '/analytics/users/user_1/stats',
      (server) => server.reply(200, {
        'data': {
          'user_id': 'user_1',
          'total_events': 42,
          'project_created_count': 5,
          'generation_started_count': 3,
          'last_event_at': '2026-06-01T00:00:00Z',
        },
      }),
    );
    final stats = await repository.getUserStats('user_1');
    expect(stats.userId, 'user_1');
    expect(stats.totalEvents, 42);
    expect(stats.projectCreatedCount, 5);
    expect(stats.generationStartedCount, 3);
    expect(stats.lastEventAt, DateTime.utc(2026, 6));
  });

  test('getUserStats parses unwrapped stats response', () async {
    adapter.onGet(
      '/analytics/users/user_2/stats',
      (server) => server.reply(200, {
        'user_id': 'user_2',
        'total_events': 10,
        'project_created_count': 1,
        'generation_started_count': 0,
      }),
    );
    final stats = await repository.getUserStats('user_2');
    expect(stats.userId, 'user_2');
    expect(stats.totalEvents, 10);
    expect(stats.lastEventAt, isNull);
  });

  test('getUserStats maps 500 to ServerException', () async {
    adapter.onGet(
      '/analytics/users/bad/stats',
      (server) => server.reply(500, {'message': 'Internal error'}),
    );
    await expectLater(
      repository.getUserStats('bad'),
      throwsA(isA<ServerException>()),
    );
  });

  test('watchEvents yields a single snapshot', () async {
    adapter.onGet(
      '/analytics/events',
      (server) => server.reply(200, {
        'data': [_eventJson('evt_1')],
      }),
    );
    final events = await repository.watchEvents().first;
    expect(events, hasLength(1));
  });
}

AnalyticsEvent _event(String id) {
  return AnalyticsEvent(
    id: id,
    userId: 'user_1',
    eventName: 'project_created',
    timestamp: DateTime.utc(2026, 6),
  );
}

Map<String, Object?> _eventJson(String id) => _event(id).toJson();
