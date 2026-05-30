import 'dart:async';

import 'package:faker/faker.dart';

import '../../models/analytics_event.dart';
import '../analytics_repository.dart';
import 'mock_repository_utils.dart';

class MockAnalyticsRepository implements AnalyticsRepository {
  MockAnalyticsRepository({
    MockRepositoryConfig config = const MockRepositoryConfig(),
  })  : _runtime = MockRepositoryRuntime(config),
        _faker = Faker() {
    _events.addAll(_seedEvents());
  }

  final MockRepositoryRuntime _runtime;
  final Faker _faker;
  final _controller = StreamController<void>.broadcast();
  final _events = <AnalyticsEvent>[];

  @override
  Future<void> trackEvent(AnalyticsEvent event) async {
    await _runtime.simulateNetwork();
    _events.add(event);
    _emit();
  }

  @override
  Future<List<AnalyticsEvent>> getEvents({String? userId}) async {
    await _runtime.simulateNetwork();
    return List<AnalyticsEvent>.unmodifiable(_filter(userId));
  }

  @override
  Future<UserAnalyticsStats> getUserStats(String userId) async {
    await _runtime.simulateNetwork();
    final events = _filter(userId);
    return UserAnalyticsStats(
      userId: userId,
      totalEvents: events.length,
      projectCreatedCount:
          events.where((event) => event.eventName == 'project_created').length,
      generationStartedCount: events
          .where((event) => event.eventName == 'generation_started')
          .length,
      lastEventAt: events.isEmpty ? null : events.last.timestamp,
    );
  }

  @override
  Stream<List<AnalyticsEvent>> watchEvents({String? userId}) async* {
    await _runtime.simulateNetwork();
    yield List<AnalyticsEvent>.unmodifiable(_filter(userId));
    yield* _controller.stream
        .map((_) => List<AnalyticsEvent>.unmodifiable(_filter(userId)));
  }

  List<AnalyticsEvent> _seedEvents() {
    const eventNames = [
      'app_opened',
      'project_created',
      'generation_started',
      'short_reviewed',
    ];
    return List<AnalyticsEvent>.generate(8, (index) {
      return AnalyticsEvent(
        id: 'event_${index + 1}',
        userId: 'user_${index % 3 + 1}',
        eventName: eventNames[index % eventNames.length],
        properties: {
          'source': index.isEven ? 'mock_home' : 'mock_library',
          'label': _faker.lorem.word(),
        },
        timestamp: DateTime.now().toUtc().subtract(Duration(hours: index)),
      );
    });
  }

  List<AnalyticsEvent> _filter(String? userId) {
    if (userId == null) {
      return [..._events];
    }
    return _events.where((event) => event.userId == userId).toList();
  }

  void _emit() => _controller.add(null);
}
