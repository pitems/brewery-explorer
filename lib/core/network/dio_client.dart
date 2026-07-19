import 'package:dio/dio.dart';
import 'package:tech_challenge/core/network/api_constants.dart';

class DioClient {
  DioClient({Dio? dio}) : _dio = dio ?? Dio() {
    _configure();
  }

  final Dio _dio;
  Dio get client => _dio;

  void _configure() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    //TimeOuts
    _dio.options.connectTimeout = const Duration(seconds: 10);

    _dio.options.receiveTimeout = const Duration(seconds: 10);

    _dio.options.sendTimeout = const Duration(seconds: 10);

    _dio.options.headers = {'Accept': 'application/json'};
  }
}
