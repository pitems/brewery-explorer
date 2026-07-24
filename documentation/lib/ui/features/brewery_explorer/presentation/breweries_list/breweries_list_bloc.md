# Documentation: breweries_list_bloc

## Overview

- Language: `dart`
- Source: `/Users/pitems/Dev/Dart/Forest/tech_challenge/lib/ui/features/brewery_explorer/presentation/breweries_list/breweries_list_bloc.dart`
- Documentation: `/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/lib/ui/features/brewery_explorer/presentation/breweries_list/breweries_list_bloc.md`
- Generated: `2026-07-24T02:11:28.237423Z`

## Classes

### BreweriesListBloc

#### Variables

##### BreweryListMode \_mode

Tracks whether the Bloc is operating in regular-list mode or search mode.

##### const int \_perPage

Defines the maximum number of breweries requested per page.

##### int \_currentPage

Tracks the current page for the regular brewery list.

##### int \_currentSearchPage

Tracks the current page for search results.

##### String \_activeQuery

Stores the current trimmed search query.

##### bool \_hasReachedEnd

Indicates that no more pages should be requested. It becomes true when a response contains fewer than 20 items or when a subsequent page returns an empty list.

##### bool \_isLoadingMore

Indicates whether a pagination request is in progress and prevents duplicate
next-page requests.

##### bool \_isSearchActive

Tracks whether a valid search is currently active, so the Bloc can return to the regular list when the query is cleared or becomes shorter than three characters.

##### final BreweryRepository repository

Repository used to retrieve brewery data for the regular list and search flows.

##### final AppErrorMapper errorMapper

Maps application exceptions into user-facing error messages.

#### Constructors

##### BreweriesListBloc({required this.repository, required this.errorMapper})

Receives the repository and error mapper through constructor injection. The
`@injectable` annotation allows Injectable/GetIt to create the Bloc.

#### Functions

##### Future<void> \_onBreweryListRequested(BreweryListRequested event, Emitter<BreweriesListState> emit)

Loads the first page of the regular brewery list, resets pagination state, and
emits loading, empty, success, or failure states.

##### Future<void> \_onBrewerySearchChanged(BrewerySearchChanged event, Emitter<BreweriesListState> emit)

Handles search input after the debounce transformer runs. Queries with fewer
than three characters do not trigger a search; valid queries reset pagination,
load search results, and emit loading, empty, success, or failure states.

##### Future<void> \_onBreweryNextPageRequested(BreweryNextPageRequested event, Emitter<BreweriesListState> emit)

Loads the next page for either the regular list or the active search. It avoids
duplicate requests, stops when the end is reached, ignores stale results after
a mode or query change, and exposes pagination failures through the success
state.

##### void \_resetData()

Resets pagination and query state before starting a fresh list or search request.

##### Future<void> \_onBreweryListRetry(BreweryListRetry event, Emitter<BreweriesListState> emit)

Retries the current full list or search request based on the active mode.
Pagination failures are retried separately through
`BreweryNextPageRequested`.

## Deprecated

_No deprecated entries yet._

## Dependencies

- [bloc_transformers](/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/lib/core/bloc/bloc_transformers.md)
- [app_error_mapper](/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/lib/core/errors/app_error_mapper.md)
- [brewery_repository](/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/lib/ui/features/brewery_explorer/domain/brewery_repository.md)
- [brewery_list_event](/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/lib/ui/features/brewery_explorer/presentation/breweries_list/brewery_list_event.md)
- [bloc_modes](/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/lib/ui/features/brewery_explorer/presentation/breweries_list/constants/bloc_modes.md)
- [next_page_helper](/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/lib/ui/features/brewery_explorer/presentation/breweries_list/helpers/next_page_helper.md)
- [breweries_list_state](/Users/pitems/Dev/Dart/Forest/tech_challenge/documentation/lib/ui/features/brewery_explorer/presentation/breweries_list/breweries_list_state.md)
