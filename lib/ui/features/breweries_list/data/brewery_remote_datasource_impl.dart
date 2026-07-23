import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_challenge/core/errors/fetch_exception.dart';
import 'package:tech_challenge/core/errors/network_exception.dart';
import 'package:tech_challenge/core/network/api_constants.dart';
import 'package:tech_challenge/core/network/dio_client.dart';
import 'package:tech_challenge/ui/features/breweries_list/data/brewery_remote_datasource.dart';
import 'package:tech_challenge/ui/features/breweries_list/data/dtos/brewery_dto.dart';


/// Repository responsible for retrieving
/// brewery information from the remote datasource
@LazySingleton(as: BreweryRemoteDatasource)
class BreweryRemoteDatasourceImpl implements BreweryRemoteDatasource {
  BreweryRemoteDatasourceImpl({required this.dioClient});

  final DioClient dioClient;
  @override
  Future<List<BreweryDto>> getBreweries({required int page, required int perPage}) async {
    try {
      final response = await dioClient.client.get<List<dynamic>>(
        ApiConstants.breweries,
        queryParameters: {'page': page, 'per_page': perPage},
      );

      final List<dynamic>? data = response.data;

      if (data == null) {
        throw const FetchException();
      }
      return data.map((item) => BreweryDto.fromJson(item as Map<String, dynamic>)).toList();
    } on DioException catch (_) {
      throw NetworkException();
    }
  }

  @override
  Future<BreweryDto> getBrewery(String id) async {
    try {
      final response = await dioClient.client.get<Map<String, dynamic>>('${ApiConstants.breweries}/$id');
      final Map<String, dynamic>? data = response.data;
      if (data == null) {
        throw const FetchException();
      }
      return BreweryDto.fromJson(data);

    } on DioException catch (_) {
      throw NetworkException();
    }
  }

  @override
  Future<List<BreweryDto>> searchBreweries({required String query, required int page, required int perPage}) async {
    try {
      final response = await dioClient.client.get<List<dynamic>>(
        ApiConstants.queryBrewery,
        queryParameters: {'query': query, 'page': page, 'per_page': perPage},
      );
      final List<dynamic>? data = response.data;
      if (data == null) {
        throw const FetchException();
      }

      return data.map((item) => BreweryDto.fromJson(item as Map<String, dynamic>)).toList();
    } on DioException catch (_) {
      throw NetworkException();
    }
  }
}
