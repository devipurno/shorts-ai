import 'package:dio/dio.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/network/api_exception_mapper.dart';
import '../../../core/network/dio_client.dart';
import '../../models/subscription.dart';
import '../subscription_repository.dart';
import 'api_repository_helpers.dart';

class ApiSubscriptionRepository implements SubscriptionRepository {
  ApiSubscriptionRepository({Dio? dio})
      : _dio = dio ?? DioClient.instance.dio,
        _client = ApiResourceClient<Subscription>(
          path: '/subscriptions',
          fromJson: Subscription.fromJson,
          toJson: (subscription) => subscription.toJson(),
          idOf: (subscription) => subscription.id,
          dio: dio,
        );

  final Dio _dio;
  final ApiResourceClient<Subscription> _client;

  @override
  Future<int> getLifetimeSlots() async {
    try {
      final response = await _dio.get<dynamic>('/subscriptions/lifetime-slots');
      final data = response.data;
      if (data is Map && data['data'] is Map) {
        return (data['data']['remaining'] as num).toInt();
      }
      if (data is Map && data['remaining'] is num) {
        return (data['remaining'] as num).toInt();
      }
      throw const ServerException(
        'Unexpected lifetime slots response.',
        code: 'invalid_response_shape',
      );
    } on DioException catch (error) {
      throw error.error is AppException
          ? error.error! as AppException
          : mapDioError(error);
    }
  }

  @override
  Future<Subscription?> getByUserId(String userId) async {
    final items = await _client.getAll(query: {'user_id': userId});
    return items.firstOrNull;
  }

  @override
  Future<Subscription?> getById(String id) => _client.getById(id);

  @override
  Future<Subscription> create(Subscription subscription) {
    return _client.create(subscription);
  }

  @override
  Future<Subscription> update(Subscription subscription) {
    return _client.update(subscription);
  }

  @override
  Future<void> cancel(String id) async {
    try {
      await _dio.patch<dynamic>('/subscriptions/$id/cancel');
    } on DioException catch (error) {
      throw error.error is AppException
          ? error.error! as AppException
          : mapDioError(error);
    }
  }

  @override
  Stream<Subscription?> watchByUserId(String userId) async* {
    yield await getByUserId(userId);
  }
}
