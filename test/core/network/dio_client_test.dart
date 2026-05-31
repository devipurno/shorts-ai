import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shorts_ai/core/errors/app_exception.dart';
import 'package:shorts_ai/core/network/api_exception_mapper.dart';
import 'package:shorts_ai/core/network/dio_client.dart';
import 'package:shorts_ai/shared/services/supabase_service.dart';

void main() {
  test('AuthInterceptor injects Supabase bearer token', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://api.autoshort.test'));
    final adapter = DioAdapter(dio: dio);
    dio.interceptors.add(AuthInterceptor(dio, _FakeSupabaseService('token-1')));

    String? authorization;
    adapter.onGet(
      '/me',
      (server) => server.replyCallback(200, (options) {
        authorization = options.headers['authorization']?.toString();
        return {'ok': true};
      }),
    );

    await dio.get<dynamic>('/me');

    expect(authorization, 'Bearer token-1');
  });

  test('AuthInterceptor refreshes token on 401 response', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://api.autoshort.test'));
    final adapter = DioAdapter(dio: dio);
    final service = _FakeSupabaseService('expired-token');
    dio.interceptors.add(AuthInterceptor(dio, service));

    adapter.onGet(
      '/secure',
      (server) => server.reply(401, {
        'error': {'message': 'expired'},
      }),
    );

    await expectLater(
      dio.get<dynamic>('/secure'),
      throwsA(isA<DioException>()),
    );
    expect(service.refreshCount, 1);
  });

  test('RetryInterceptor retries 5xx responses three times', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://api.autoshort.test'));
    final adapter = DioAdapter(dio: dio);
    dio.interceptors.add(RetryInterceptor(
      dio,
      baseDelay: Duration.zero,
      maxAttempts: 3,
    ));

    var attempts = 0;
    adapter.onGet(
      '/flaky',
      (server) => server.replyCallback(500, (options) {
        attempts++;
        return {'message': 'server down'};
      }),
    );

    await expectLater(
      dio.get<dynamic>('/flaky'),
      throwsA(isA<DioException>()),
    );

    expect(attempts, 4);
  });

  test('mapDioError maps timeout and bad responses to AppException types', () {
    final requestOptions = RequestOptions(path: '/projects');

    expect(
      mapDioError(DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.connectionTimeout,
      )),
      isA<NetworkException>(),
    );

    expect(
      mapDioError(DioException(
        requestOptions: requestOptions,
        response: Response(
          requestOptions: requestOptions,
          statusCode: 404,
          data: {'message': 'Not found'},
        ),
        type: DioExceptionType.badResponse,
      )),
      isA<NotFoundException>(),
    );
  });
}

class _FakeSupabaseService extends SupabaseService {
  _FakeSupabaseService(this._token);

  String? _token;
  int refreshCount = 0;

  @override
  String? get accessToken => _token;

  @override
  Future<String?> refreshAccessToken() async {
    refreshCount++;
    _token = 'token-$refreshCount';
    return _token;
  }
}
