class AppException implements Exception {
  const AppException(
    this.message, {
    this.code,
    this.originalError,
  });

  final String message;
  final String? code;
  final Object? originalError;

  @override
  String toString() {
    final codeText = code == null ? '' : ' [$code]';
    return '$runtimeType$codeText: $message';
  }
}

class NetworkException extends AppException {
  const NetworkException(
    super.message, {
    super.code,
    super.originalError,
  });
}

class AuthException extends AppException {
  const AuthException(
    super.message, {
    super.code,
    super.originalError,
  });
}

class ValidationException extends AppException {
  const ValidationException(
    super.message, {
    super.code,
    super.originalError,
  });
}

class NotFoundException extends AppException {
  const NotFoundException(
    super.message, {
    super.code,
    super.originalError,
  });
}

class ServerException extends AppException {
  const ServerException(
    super.message, {
    super.code,
    super.originalError,
  });
}
