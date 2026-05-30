sealed class Result<T, E> {
  const Result();

  const factory Result.success(T value) = Success<T, E>;
  const factory Result.failure(E error) = Failure<T, E>;

  R fold<R>(
    R Function(T value) onSuccess,
    R Function(E error) onFailure,
  ) {
    final result = this;
    if (result is Success<T, E>) {
      return onSuccess(result.value);
    }
    if (result is Failure<T, E>) {
      return onFailure(result.error);
    }
    throw StateError('Unknown Result subtype: $runtimeType');
  }

  Result<R, E> map<R>(R Function(T value) transform) {
    return fold(
      (value) => Success<R, E>(transform(value)),
      Failure<R, E>.new,
    );
  }

  Result<T, F> mapError<F>(F Function(E error) transform) {
    return fold(
      Success<T, F>.new,
      (error) => Failure<T, F>(transform(error)),
    );
  }

  T getOrElse(T Function(E error) fallback) {
    return fold((value) => value, fallback);
  }

  T getOrThrow() {
    return fold(
      (value) => value,
      (error) {
        if (error is Error) {
          throw error;
        }
        if (error is Exception) {
          throw error;
        }
        throw StateError(error.toString());
      },
    );
  }
}

final class Success<T, E> extends Result<T, E> {
  const Success(this.value);

  final T value;
}

final class Failure<T, E> extends Result<T, E> {
  const Failure(this.error);

  final E error;
}
