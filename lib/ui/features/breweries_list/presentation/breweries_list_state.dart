import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_entity.dart';

sealed class BreweriesListState {
  const BreweriesListState();
}

final class BreweryListInitial extends BreweriesListState {
  const BreweryListInitial();
}

final class BreweryListLoading extends BreweriesListState {
  const BreweryListLoading();
}

final class BreweryListSuccess extends BreweriesListState {
  const BreweryListSuccess({
    required this.breweries,
    required this.hasReachedEnd,
    required this.isLoadingMore,
    required this.isSearchResult,
  });

  final List<Brewery> breweries;
  final bool hasReachedEnd;
  final bool isLoadingMore;
  final bool isSearchResult;
}

final class BreweryListEmpty extends BreweriesListState {
  const BreweryListEmpty();
}

final class BreweryListFailure extends BreweriesListState {
  const BreweryListFailure({required this.message});

  final String message;
}
