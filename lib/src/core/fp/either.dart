sealed class Either<E extends Exception, S> {
  T when<T>({
    required T Function(E exception) failure,
    required T Function(S value) success,
  }) =>
      switch (this) {
        Success(:final value) => success(value),
        Failure(:final exception) => failure(exception),
      };
}


class Failure<E extends Exception, S> extends Either<E, S> {
  final E exception;
  Failure(this.exception);
}

class Success<E extends Exception, S> extends Either<E, S> {
  final S value;
  Success(this.value);
}
