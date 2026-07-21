import 'package:dio/dio.dart';
import 'package:tech_challenge/core/either/app_exception.dart';
import 'package:tech_challenge/core/either/fetch_exception.dart';
import 'package:tech_challenge/core/either/network_exception.dart';

abstract interface class DioExceptionMapper {
  AppException map(DioException error);
}

class DioExceptionMapperImpl implements DioExceptionMapper {
  const DioExceptionMapperImpl();
  @override
  AppException map(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => const NetworkException(),
      DioExceptionType.connectionError => const FetchException(),
      _ => const FetchException(),
    };
  }
}
