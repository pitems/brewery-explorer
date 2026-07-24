# Documentation: breweries_list_bloc

## Overview

- Language: `dart`
- Source: `/Users/pitems/Dev/Dart/Forest/tech_challenge/lib/ui/features/breweries_list/presentation/breweries_list/breweries_list_bloc.dart`
- Documentation: `/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/ui/features/breweries_list/presentation/breweries_list/breweries_list_bloc.md`
- Generated: `2026-07-24T02:11:28.237423Z`

## Classes

### BreweriesListBloc

#### Variables

##### BreweryListMode \_mode

##### const int \_perPage

##### int \_currentPage

##### int \_currentSearchPage

##### String \_activeQuery

##### bool \_hasReachedEnd

##### bool \_isLoadingMore

##### bool \_isSearchActive

##### final BreweryRepository repository

##### final AppErrorMapper errorMapper

#### Constructors

##### BreweriesListBloc({required this.repository, required this.errorMapper})

#### Functions

##### Future<void> \_onBreweryListRequested(BreweryListRequested event, Emitter<BreweriesListState> emit)

##### Future<void> \_onBrewerySearchChanged(BrewerySearchChanged event, Emitter<BreweriesListState> emit)

##### Future<void> \_onBreweryNextPageRequested(BreweryNextPageRequested event, Emitter<BreweriesListState> emit)

##### void \_resetData()

##### Future<void> \_onBreweryListRetry(BreweryListRetry event, Emitter<BreweriesListState> emit)

## Deprecated

_No deprecated entries yet._

## Dependencies

- [bloc_transformers](/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/core/bloc/bloc_transformers.md)
- [app_error_mapper](/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/core/errors/app_error_mapper.md)
- [brewery_repository](/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/ui/features/breweries_list/domain/brewery_repository.md)
- [brewery_list_event](/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/ui/features/breweries_list/presentation/breweries_list/brewery_list_event.md)
- [bloc_modes](/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/ui/features/breweries_list/presentation/breweries_list/constants/bloc_modes.md)
- [next_page_helper](/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/ui/features/breweries_list/presentation/breweries_list/helpers/next_page_helper.md)
- [breweries_list_state](/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/ui/features/breweries_list/presentation/breweries_list/breweries_list_state.md)
