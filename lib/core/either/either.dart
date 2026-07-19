// ignore_for_file: non_constant_identifier_names

import 'package:tech_challenge/core/either/app_exception.dart';

class Either<T> {
  const Either.right(T value) : _isRight = true, _left = null, _right = value;

  const Either.left(AppException error) : _isRight = false, _left = error, _right = null;

  final bool _isRight;
  final AppException? _left;
  final Object? _right;

  AppException? get left => _left;
  T? get right => _isRight ? _right as T : null;

  bool isLeft() => !_isRight;

  bool isRight() => _isRight;

  R fold<R>(R Function(AppException l) ifLeft, R Function(T r) ifRight) {
    if (_isRight) {
      return ifRight(_right as T);
    }
    return ifLeft(_left!);
  }
}

Either<T> Right<T>(T value) => Either.right(value);

Either<T> Left<T>(AppException error) => Either.left(error);
