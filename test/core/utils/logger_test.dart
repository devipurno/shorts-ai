import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/utils/logger.dart';

void main() {
  test('AppLogger supports debug, info, warning, and error calls', () {
    expect(() => AppLogger.d('debug', tag: 'Test'), returnsNormally);
    expect(() => AppLogger.i('info', tag: 'Test'), returnsNormally);
    expect(() => AppLogger.w('warn', tag: 'Test'), returnsNormally);
    expect(
      () => AppLogger.e(
        'error',
        tag: 'Test',
        error: StateError('boom'),
      ),
      returnsNormally,
    );
  });
}
