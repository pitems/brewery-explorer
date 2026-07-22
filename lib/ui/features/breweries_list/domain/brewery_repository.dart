import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_detail_entity.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_entity.dart';

abstract class BreweryRepository {
  const BreweryRepository();

  Future<List<Brewery>> getBreweries({required int page, required int perPage});

  Future<BreweryDetail> getBrewery(String id);

  Future<List<Brewery>> searchBreweries({required String query, required int page, required int perPage});
}
