import 'package:tech_challenge/ui/features/brewery_explorer/data/dtos/brewery_dto.dart';

abstract interface class BreweryRemoteDatasource {
  Future<List<BreweryDto>> getBreweries({required int page, required int perPage});
  Future<BreweryDto> getBrewery(String id);
  Future<List<BreweryDto>> searchBreweries({required String query, required int page, required int perPage});
}
