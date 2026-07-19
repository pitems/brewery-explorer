import 'package:tech_challenge/ui/features/breweries_list/data/dtos/brewery_dto.dart';

abstract interface class BreweryRemoteDatasource {
  Future<List<BreweryDto>> getBreweries({required int page, required int perPage});
  Future<BreweryDto> getBrewery(String id);
  Future<List<BreweryDto>> searchBreweries(String query);
}
