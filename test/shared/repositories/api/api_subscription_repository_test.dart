import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shorts_ai/core/errors/app_exception.dart';
import 'package:shorts_ai/core/network/dio_client.dart';
import 'package:shorts_ai/shared/models/subscription.dart';
import 'package:shorts_ai/shared/models/user.dart';
import 'package:shorts_ai/shared/repositories/api/api_subscription_repository.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late ApiSubscriptionRepository repository;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://api.autoshort.test'));
    adapter = DioAdapter(dio: dio);
    dio.interceptors.add(ErrorMappingInterceptor());
    repository = ApiSubscriptionRepository(dio: dio);
  });

  test('getLifetimeSlots parses wrapped data response', () async {
    adapter.onGet(
      '/subscriptions/lifetime-slots',
      (server) => server.reply(200, {
        'data': {'remaining': 47},
      }),
    );
    expect(await repository.getLifetimeSlots(), 47);
  });

  test('getLifetimeSlots parses flat response', () async {
    adapter.onGet(
      '/subscriptions/lifetime-slots',
      (server) => server.reply(200, {'remaining': 99}),
    );
    expect(await repository.getLifetimeSlots(), 99);
  });

  test('getLifetimeSlots throws ServerException on unexpected shape', () async {
    adapter.onGet(
      '/subscriptions/lifetime-slots',
      (server) => server.reply(200, {'status': 'ok'}),
    );
    await expectLater(
      repository.getLifetimeSlots(),
      throwsA(isA<ServerException>()),
    );
  });

  test('getLifetimeSlots maps DioException to AppException', () async {
    adapter.onGet(
      '/subscriptions/lifetime-slots',
      (server) => server.reply(500, {'message': 'broken'}),
    );
    await expectLater(
      repository.getLifetimeSlots(),
      throwsA(isA<ServerException>()),
    );
  });

  test('getByUserId returns first matching subscription', () async {
    adapter.onGet(
      '/subscriptions',
      queryParameters: {'user_id': 'user_1'},
      (server) => server.reply(200, {
        'data': [_subscriptionJson('sub_1')],
      }),
    );
    final sub = await repository.getByUserId('user_1');
    expect(sub, isNotNull);
    expect(sub!.id, 'sub_1');
  });

  test('getByUserId returns null when list is empty', () async {
    adapter.onGet(
      '/subscriptions',
      queryParameters: {'user_id': 'missing'},
      (server) => server.reply(200, {'data': <Object>[]}),
    );
    expect(await repository.getByUserId('missing'), isNull);
  });

  test('getById returns subscription or null', () async {
    adapter.onGet(
      '/subscriptions/sub_1',
      (server) => server.reply(200, {'data': _subscriptionJson('sub_1')}),
    );
    adapter.onGet(
      '/subscriptions/missing',
      (server) => server.reply(404, {'message': 'not found'}),
    );

    expect((await repository.getById('sub_1'))?.id, 'sub_1');
    expect(await repository.getById('missing'), isNull);
  });

  test('create posts subscription', () async {
    final sub = _subscription('sub_new');
    adapter.onPost(
      '/subscriptions',
      data: sub.toJson(),
      (server) => server.reply(200, {'data': sub.toJson()}),
    );
    final created = await repository.create(sub);
    expect(created.id, 'sub_new');
  });

  test('update patches subscription', () async {
    final sub = _subscription('sub_1');
    adapter.onPatch(
      '/subscriptions/sub_1',
      data: sub.toJson(),
      (server) => server.reply(200, {'data': sub.toJson()}),
    );
    final updated = await repository.update(sub);
    expect(updated.id, 'sub_1');
  });

  test('cancel patches subscription cancel endpoint', () async {
    adapter.onPatch(
      '/subscriptions/sub_1/cancel',
      (server) => server.reply(200, null),
    );
    await repository.cancel('sub_1');
  });

  test('cancel maps DioException to AppException', () async {
    adapter.onPatch(
      '/subscriptions/sub_err/cancel',
      (server) => server.reply(403, {'message': 'forbidden'}),
    );
    await expectLater(
      repository.cancel('sub_err'),
      throwsA(isA<AuthException>()),
    );
  });

  test('watchByUserId yields a single snapshot', () async {
    adapter.onGet(
      '/subscriptions',
      queryParameters: {'user_id': 'user_1'},
      (server) => server.reply(200, {
        'data': [_subscriptionJson('sub_1')],
      }),
    );
    final sub = await repository.watchByUserId('user_1').first;
    expect(sub?.id, 'sub_1');
  });
}

Subscription _subscription(String id) {
  return Subscription(
    id: id,
    userId: 'user_1',
    tier: SubscriptionTier.premium,
    status: SubscriptionStatus.active,
    startedAt: DateTime.utc(2026, 1),
    expiresAt: DateTime.utc(2027, 1),
  );
}

Map<String, Object?> _subscriptionJson(String id) =>
    _subscription(id).toJson();
