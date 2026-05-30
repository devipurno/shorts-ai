import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/errors/app_exception.dart';

void main() {
  test('AppException exposes message, code, and original error', () {
    final cause = ArgumentError('bad input');
    final exception = AppException(
      'Something went wrong',
      code: 'app_error',
      originalError: cause,
    );

    expect(exception.message, 'Something went wrong');
    expect(exception.code, 'app_error');
    expect(exception.originalError, same(cause));
    expect(exception.toString(), contains('app_error'));
  });

  test('specialized exceptions extend AppException', () {
    expect(const NetworkException('offline'), isA<AppException>());
    expect(const AuthException('unauthorized'), isA<AppException>());
    expect(const ValidationException('invalid'), isA<AppException>());
    expect(const NotFoundException('missing'), isA<AppException>());
    expect(const ServerException('server error'), isA<AppException>());
  });
}
