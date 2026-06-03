import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../shared/services/supabase_service.dart';
import '../constants/app_constants.dart';
import '../env/env.dart';
import '../utils/logger.dart';
import 'api_exception_mapper.dart';

class DioClient {
  DioClient({
    Dio? dio,
    SupabaseService? supabaseService,
    bool addInterceptors = true,
  })  : dio = dio ?? Dio(_baseOptions()),
        _supabaseService = supabaseService ?? SupabaseService() {
    if (addInterceptors) {
      this.dio.interceptors.addAll([
        AuthInterceptor(this.dio, _supabaseService),
        LoggingInterceptor(),
        RetryInterceptor(this.dio),
        ErrorMappingInterceptor(),
      ]);
    }
  }

  static final DioClient instance = DioClient();

  final Dio dio;
  final SupabaseService _supabaseService;

  static BaseOptions _baseOptions() {
    return BaseOptions(
      baseUrl: Env.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        HttpHeaders.contentTypeHeader: Headers.jsonContentType,
        HttpHeaders.userAgentHeader:
            '${AppConstants.APP_NAME}/${AppConstants.APP_VERSION}',
      },
    );
  }
}

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor(this._dio, this._supabaseService);

  final Dio _dio;
  final SupabaseService _supabaseService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final accessToken = _supabaseService.accessToken;
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final alreadyRetried = err.requestOptions.extra['authRetried'] == true;
    if (statusCode != 401 || alreadyRetried) {
      handler.next(err);
      return;
    }

    try {
      final token = await _supabaseService.refreshAccessToken();
      if (token == null || token.isEmpty) {
        handler.next(err);
        return;
      }

      final retryOptions = _copyOptions(err.requestOptions);
      retryOptions.extra['authRetried'] = true;
      retryOptions.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      final response = await _retryDio().fetch<dynamic>(retryOptions);
      handler.resolve(response);
    } catch (retryError, stackTrace) {
      AppLogger.w(
        'Auth token refresh retry failed',
        tag: 'HTTP',
        error: retryError,
        stackTrace: stackTrace,
      );
      handler.next(err);
    }
  }

  Dio _retryDio() {
    final retryDio = Dio(_dio.options);
    retryDio.httpClientAdapter = _dio.httpClientAdapter;
    return retryDio;
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      AppLogger.d(
        '${options.method} ${options.uri}',
        tag: 'HTTP',
      );
    }
    if (!kDebugMode && Env.sentryDsn != null) {
      Sentry.addBreadcrumb(
        Breadcrumb(
          message: 'HTTP request: ${options.method} ${options.uri.path}',
          category: 'api_call',
          data: {'method': options.method, 'path': options.uri.path},
        ),
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      AppLogger.d(
        '${response.statusCode} ${response.requestOptions.uri}',
        tag: 'HTTP',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      AppLogger.w(
        '${err.response?.statusCode ?? err.type.name} ${err.requestOptions.uri}',
        tag: 'HTTP',
        error: err.message,
      );
    }
    if (!kDebugMode && Env.sentryDsn != null) {
      Sentry.captureException(
        err,
        stackTrace: err.stackTrace,
        hint: Hint.withMap({
          'method': err.requestOptions.method,
          'path': err.requestOptions.uri.path,
          'status_code': err.response?.statusCode,
        }),
      );
    }
    handler.next(err);
  }
}

class RetryInterceptor extends Interceptor {
  RetryInterceptor(
    this._dio, {
    this.maxAttempts = 3,
    this.baseDelay = const Duration(seconds: 1),
  });

  final Dio _dio;
  final int maxAttempts;
  final Duration baseDelay;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldRetry(err)) {
      handler.next(err);
      return;
    }

    final attempt = (err.requestOptions.extra['retryAttempt'] as int?) ?? 0;
    if (attempt >= maxAttempts) {
      handler.next(err);
      return;
    }

    final delay = baseDelay * (1 << attempt);
    await Future<void>.delayed(delay);

    try {
      final retryOptions = _copyOptions(err.requestOptions);
      retryOptions.extra['retryAttempt'] = attempt + 1;
      final response = await _dio.fetch<dynamic>(retryOptions);
      handler.resolve(response);
    } catch (error) {
      if (error is DioException) {
        handler.next(error);
      } else {
        handler.next(err);
      }
    }
  }

  bool _shouldRetry(DioException error) {
    final statusCode = error.response?.statusCode ?? 0;
    return statusCode >= 500 ||
        error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.unknown;
  }
}

class ErrorMappingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.reject(
      err.copyWith(error: mapDioError(err)),
    );
  }
}

RequestOptions _copyOptions(RequestOptions options) {
  return options.copyWith(
    path: options.path,
    method: options.method,
    data: options.data,
    queryParameters: Map<String, dynamic>.from(options.queryParameters),
    headers: Map<String, dynamic>.from(options.headers),
    extra: Map<String, dynamic>.from(options.extra),
  );
}
