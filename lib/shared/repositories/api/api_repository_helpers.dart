import 'package:dio/dio.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/network/api_exception_mapper.dart';
import '../../../core/network/dio_client.dart';

typedef JsonFactory<T> = T Function(Map<String, Object?> json);
typedef JsonEncoder<T> = Map<String, Object?> Function(T value);
typedef JsonId<T> = String Function(T value);

class ApiResourceClient<T> {
  ApiResourceClient({
    required this.path,
    required this.fromJson,
    required this.toJson,
    required this.idOf,
    Dio? dio,
  }) : _dio = dio ?? DioClient.instance.dio;

  final String path;
  final JsonFactory<T> fromJson;
  final JsonEncoder<T> toJson;
  final JsonId<T> idOf;
  final Dio _dio;

  Future<List<T>> getAll({Map<String, Object?> query = const {}}) async {
    final response = await _guard(() => _dio.get<dynamic>(
          path,
          queryParameters: _cleanQuery(query),
        ));
    return _asList(response.data).map(_jsonToModel).toList();
  }

  Future<T?> getById(String id) async {
    try {
      final response = await _guard(() => _dio.get<dynamic>('$path/$id'));
      final data = _extractData(response.data);
      if (data == null) {
        return null;
      }
      return _jsonToModel(data);
    } on NotFoundException {
      return null;
    }
  }

  Future<T> create(T value) async {
    final response = await _guard(() => _dio.post<dynamic>(
          path,
          data: toJson(value),
        ));
    return _jsonToModel(_extractData(response.data)!);
  }

  Future<T> update(T value) async {
    final response = await _guard(() => _dio.patch<dynamic>(
          '$path/${idOf(value)}',
          data: toJson(value),
        ));
    return _jsonToModel(_extractData(response.data)!);
  }

  Future<void> delete(String id) async {
    await _guard(() => _dio.delete<dynamic>('$path/$id'));
  }

  Future<Response<TResponse>> _guard<TResponse>(
    Future<Response<TResponse>> Function() action,
  ) async {
    try {
      return await action();
    } on DioException catch (error) {
      final mapped = error.error is AppException
          ? error.error! as AppException
          : mapDioError(error);
      throw mapped;
    }
  }

  T _jsonToModel(Object? data) {
    if (data is! Map) {
      throw ServerException(
        'Unexpected API response for $path.',
        code: 'invalid_response_shape',
      );
    }
    return fromJson(Map<String, Object?>.from(data));
  }
}

Object? _extractData(Object? data) {
  if (data is Map && data.containsKey('data')) {
    return data['data'];
  }
  return data;
}

List<Object?> _asList(Object? data) {
  final extracted = _extractData(data);
  if (extracted == null) {
    return const [];
  }
  if (extracted is List) {
    return extracted;
  }
  throw const ServerException(
    'Expected API response data to be a list.',
    code: 'invalid_response_shape',
  );
}

Map<String, Object?> _cleanQuery(Map<String, Object?> query) {
  return Map<String, Object?>.fromEntries(
    query.entries.where((entry) => entry.value != null),
  );
}
