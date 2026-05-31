import 'package:dio/dio.dart';

import '../errors/app_exception.dart';

AppException mapDioError(DioException error) {
  final existing = error.error;
  if (existing is AppException) {
    return existing;
  }

  return switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout =>
      NetworkException(
        'Koneksi ke server timeout. Coba lagi.',
        code: 'network_timeout',
        originalError: error,
      ),
    DioExceptionType.badResponse => _mapBadResponse(error),
    DioExceptionType.cancel => NetworkException(
        'Request dibatalkan.',
        code: 'request_cancelled',
        originalError: error,
      ),
    DioExceptionType.connectionError => NetworkException(
        'Tidak bisa terhubung ke server.',
        code: 'connection_error',
        originalError: error,
      ),
    DioExceptionType.badCertificate => NetworkException(
        'Sertifikat server tidak valid.',
        code: 'bad_certificate',
        originalError: error,
      ),
    DioExceptionType.unknown => NetworkException(
        'Terjadi gangguan jaringan.',
        code: 'network_unknown',
        originalError: error,
      ),
  };
}

AppException _mapBadResponse(DioException error) {
  final statusCode = error.response?.statusCode ?? 0;
  final message = _responseMessage(error.response?.data) ??
      'Server mengembalikan status $statusCode.';

  if (statusCode == 401 || statusCode == 403) {
    return AuthException(
      message,
      code: 'unauthorized',
      originalError: error,
    );
  }

  if (statusCode == 404) {
    return NotFoundException(
      message,
      code: 'not_found',
      originalError: error,
    );
  }

  if (statusCode >= 400 && statusCode < 500) {
    return ValidationException(
      message,
      code: 'bad_request',
      originalError: error,
    );
  }

  return ServerException(
    message,
    code: 'server_error',
    originalError: error,
  );
}

String? _responseMessage(Object? data) {
  if (data is Map) {
    final error = data['error'];
    if (error is Map && error['message'] != null) {
      return error['message'].toString();
    }
    if (data['message'] != null) {
      return data['message'].toString();
    }
  }
  if (data is String && data.trim().isNotEmpty) {
    return data;
  }
  return null;
}
