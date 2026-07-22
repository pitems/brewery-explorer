import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_entity.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_repository.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list/constants/bloc_modes.dart';

Future<List<Brewery>> getNextPage({
  required BreweryRepository repository,
  required BreweryListMode mode,
  required int page,
  required int perPage,
  required String activeQuery,
}) {
  return switch (mode) {
    BreweryListMode.regular => repository.getBreweries(page: page, perPage: perPage),
    BreweryListMode.search => repository.searchBreweries(query: activeQuery, page: page, perPage: perPage),
  };
}
