import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/utils/result.dart';

void main() {
  test('fold handles success and failure', () {
    const success = Result<int, String>.success(10);
    const failure = Result<int, String>.failure('nope');

    expect(success.fold((value) => value * 2, (_) => 0), 20);
    expect(failure.fold((value) => value * 2, (error) => error.length), 4);
  });

  test('map transforms success value only', () {
    const result = Result<int, String>.success(2);

    expect(result.map((value) => '$value!').getOrThrow(), '2!');
  });

  test('mapError transforms failure only', () {
    const Result<int, String> result = Failure('denied');

    expect(
      result
          .mapError((error) => error.length)
          .fold((value) => value, (error) => error),
      6,
    );
  });

  test('getOrElse returns fallback for failure', () {
    const Result<int, String> result = Failure('missing');

    expect(result.getOrElse((_) => 42), 42);
  });

  test('getOrThrow throws exceptions', () {
    const exception = FormatException('bad format');
    const result = Result<int, Exception>.failure(exception);

    expect(result.getOrThrow, throwsA(same(exception)));
  });
}
