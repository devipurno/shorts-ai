import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/errors/app_exception.dart';
import 'package:shorts_ai/core/network/api_exception_mapper.dart';

void main() {
  group('mapDioError', () {
    DioException makeDioError(
      DioExceptionType type, {
      int? statusCode,
      Object? data,
      Object? error,
    }) {
      return DioException(
        type: type,
        requestOptions: RequestOptions(path: '/test'),
        response: statusCode != null
            ? Response(
                statusCode: statusCode,
                data: data,
                requestOptions: RequestOptions(path: '/test'),
              )
            : null,
        error: error,
      );
    }

    test('returns existing AppException from error.error', () {
      const existing = AuthException('Already mapped');
      final error = makeDioError(
        DioExceptionType.unknown,
        error: existing,
      );
      expect(mapDioError(error), same(existing));
    });

    test('maps connectionTimeout to NetworkException', () {
      final result = mapDioError(makeDioError(DioExceptionType.connectionTimeout));
      expect(result, isA<NetworkException>());
      expect(result.code, 'network_timeout');
    });

    test('maps sendTimeout to NetworkException', () {
      final result = mapDioError(makeDioError(DioExceptionType.sendTimeout));
      expect(result, isA<NetworkException>());
      expect(result.code, 'network_timeout');
    });

    test('maps receiveTimeout to NetworkException', () {
      final result = mapDioError(makeDioError(DioExceptionType.receiveTimeout));
      expect(result, isA<NetworkException>());
      expect(result.code, 'network_timeout');
    });

    test('maps cancel to NetworkException with request_cancelled code', () {
      final result = mapDioError(makeDioError(DioExceptionType.cancel));
      expect(result, isA<NetworkException>());
      expect(result.code, 'request_cancelled');
    });

    test('maps connectionError to NetworkException', () {
      final result = mapDioError(makeDioError(DioExceptionType.connectionError));
      expect(result, isA<NetworkException>());
      expect(result.code, 'connection_error');
    });

    test('maps badCertificate to NetworkException', () {
      final result = mapDioError(makeDioError(DioExceptionType.badCertificate));
      expect(result, isA<NetworkException>());
      expect(result.code, 'bad_certificate');
    });

    test('maps unknown to NetworkException', () {
      final result = mapDioError(makeDioError(DioExceptionType.unknown));
      expect(result, isA<NetworkException>());
      expect(result.code, 'network_unknown');
    });

    group('badResponse', () {
      test('maps 401 to AuthException', () {
        final result = mapDioError(
          makeDioError(DioExceptionType.badResponse, statusCode: 401),
        );
        expect(result, isA<AuthException>());
        expect(result.code, 'unauthorized');
      });

      test('maps 403 to AuthException', () {
        final result = mapDioError(
          makeDioError(DioExceptionType.badResponse, statusCode: 403),
        );
        expect(result, isA<AuthException>());
        expect(result.code, 'unauthorized');
      });

      test('maps 404 to NotFoundException', () {
        final result = mapDioError(
          makeDioError(DioExceptionType.badResponse, statusCode: 404),
        );
        expect(result, isA<NotFoundException>());
        expect(result.code, 'not_found');
      });

      test('maps 422 to ValidationException', () {
        final result = mapDioError(
          makeDioError(DioExceptionType.badResponse, statusCode: 422),
        );
        expect(result, isA<ValidationException>());
        expect(result.code, 'bad_request');
      });

      test('maps 500 to ServerException', () {
        final result = mapDioError(
          makeDioError(DioExceptionType.badResponse, statusCode: 500),
        );
        expect(result, isA<ServerException>());
        expect(result.code, 'server_error');
      });

      test('extracts message from nested error.message', () {
        final result = mapDioError(
          makeDioError(
            DioExceptionType.badResponse,
            statusCode: 500,
            data: {
              'error': {'message': 'DB down'}
            },
          ),
        );
        expect(result.message, 'DB down');
      });

      test('extracts message from top-level message field', () {
        final result = mapDioError(
          makeDioError(
            DioExceptionType.badResponse,
            statusCode: 404,
            data: {'message': 'Resource not found'},
          ),
        );
        expect(result.message, 'Resource not found');
      });

      test('extracts message from plain string response', () {
        final result = mapDioError(
          makeDioError(
            DioExceptionType.badResponse,
            statusCode: 500,
            data: 'Internal Server Error',
          ),
        );
        expect(result.message, 'Internal Server Error');
      });

      test('uses fallback message when data is null', () {
        final result = mapDioError(
          makeDioError(DioExceptionType.badResponse, statusCode: 502),
        );
        expect(result.message, contains('502'));
      });

      test('uses fallback for empty string data', () {
        final result = mapDioError(
          makeDioError(
            DioExceptionType.badResponse,
            statusCode: 503,
            data: '   ',
          ),
        );
        expect(result.message, contains('503'));
      });
    });
  });
}
