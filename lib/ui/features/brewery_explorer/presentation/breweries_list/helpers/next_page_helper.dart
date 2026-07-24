import 'package:tech_challenge/ui/features/brewery_explorer/domain/brewery_entity.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/domain/brewery_repository.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/breweries_list/constants/bloc_modes.dart';

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
