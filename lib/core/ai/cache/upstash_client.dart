import 'package:dio/dio.dart';

import '../../env/env.dart';
import '../../network/dio_client.dart';

/// Public API surface for `UpstashClient`.
class UpstashClient {
  UpstashClient({Dio? dio, String? restUrl, String? token})
      : _dio = dio ?? DioClient.instance.dio,
        _restUrl = restUrl ?? Env.upstashRedisRestUrl,
        _token = token ?? Env.upstashRedisRestToken;

  final Dio _dio;
  final String? _restUrl;
  final String? _token;

  bool get isConfigured =>
      _restUrl != null &&
      _restUrl.isNotEmpty &&
      _token != null &&
      _token.isNotEmpty;

  Future<String?> get(String key) async {
    final result = await pipeline([
      ['GET', key],
    ]);
    return result.firstOrNull?.toString();
  }

  Future<void> set(String key, String value, {Duration? ttl}) async {
    final command = <Object?>['SET', key, value];
    if (ttl != null) {
      command.addAll(['EX', ttl.inSeconds]);
    }
    await pipeline([command]);
  }

  Future<void> delete(String key) async {
    await pipeline([
      ['DEL', key],
    ]);
  }

  Future<List<Object?>> pipeline(List<List<Object?>> commands) async {
    final restUrl = _restUrl;
    final token = _token;
    if (restUrl == null || token == null) {
      throw StateError('Upstash Redis is not configured.');
    }
    final response = await _dio.post<dynamic>(
      '${restUrl.replaceAll(RegExp(r'/$'), '')}/pipeline',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: commands,
    );
    final items = response.data as List<dynamic>;
    return items.map((item) {
      if (item is Map && item.containsKey('error')) {
        throw StateError(item['error'].toString());
      }
      if (item is Map) {
        return item['result'];
      }
      return item;
    }).toList();
  }
}
