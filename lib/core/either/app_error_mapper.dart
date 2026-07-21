import 'package:injectable/injectable.dart';
import 'package:tech_challenge/core/either/app_exception.dart';

abstract interface class AppErrorMapper {
  String map(Object error);
}

@LazySingleton(as: AppErrorMapper)
class AppErrorMapperImpl implements AppErrorMapper {
  const AppErrorMapperImpl();

  @override
  String map(Object error) {
    return switch (error) {
      AppException(:final message) => message,
      _ => 'An unexpected error ocurred.',
    };
  }
}
