import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_challenge/core/bloc/bloc_transformers.dart';
import 'package:tech_challenge/core/either/app_error_mapper.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_repository.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list/brewery_list_event.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list/constants/bloc_modes.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list/helpers/next_page_helper.dart';

import 'breweries_list_state.dart';

@injectable
class BreweriesListBloc extends Bloc<BreweryListEvent, BreweriesListState> {
  //Variables
  BreweryListMode _mode = BreweryListMode.regular;
  static const int _perPage = 20;
  //page counters
  int _currentPage = 1;
  int _currentSearchPage = 1;
  String _activeQuery = '';
  //status booleans
  bool _hasReachedEnd = false;
  bool _isLoadingMore = false;
  bool _isSearchActive = false;

  BreweriesListBloc({required this.repository, required this.errorMapper}) : super(const BreweryListInitial()) {
    on<BreweryListRequested>(_onBreweryListRequested);
    on<BrewerySearchChanged>(
      _onBrewerySearchChanged,
      transformer: debounceRestartable(const Duration(milliseconds: 350)),
    );
    on<BreweryNextPageRequested>(_onBreweryNextPageRequested);
    on<BreweryListRetry>(_onBreweryListRetry);
  }
  final BreweryRepository repository;
  final AppErrorMapper errorMapper;
  Future<void> _onBreweryListRequested(BreweryListRequested event, Emitter<BreweriesListState> emit) async {
    //On first request
    _mode = BreweryListMode.regular;
    _resetData();
    emit(const BreweryListLoading());
    try {
      final breweries = await repository.getBreweries(page: _currentPage, perPage: _perPage);
      //If nothing is found
      if (breweries.isEmpty) {
        _hasReachedEnd = true;
        emit(const BreweryListEmpty());
        return;
      }
      //Check end brewery search if amount of  values is less than 20
      _hasReachedEnd = breweries.length < _perPage;
      emit(
        BreweryListSuccess(
          breweries: breweries,
          hasReachedEnd: _hasReachedEnd,
          isLoadingMore: false,
          isSearchResult: false,
          paginationError: false,
        ),
      );
    } catch (error) {
      emit(BreweryListFailure(message: errorMapper.map(error)));
    }
  }

  Future<void> _onBrewerySearchChanged(BrewerySearchChanged event, Emitter<BreweriesListState> emit) async {
    _resetData();
    final query = event.query.trim();
    if (query.length < 3) {
      if (_isSearchActive == true) {
        _isSearchActive = false;
        add(const BreweryListRequested());
      }

      return;
    }
    //set active query and mode
    _activeQuery = query;
    _mode = BreweryListMode.search;

    _isSearchActive = true;
    emit(const BreweryListLoading());
    try {
      final breweries = await repository.searchBreweries(query: query, page: _currentSearchPage, perPage: _perPage);
      if (breweries.isEmpty) {
        emit(const BreweryListEmpty());
        return;
      }
      _hasReachedEnd = breweries.length < _perPage;
      emit(
        BreweryListSuccess(
          breweries: breweries,
          hasReachedEnd: _hasReachedEnd,
          isLoadingMore: false,
          isSearchResult: true,
          paginationError: false,
        ),
      );
    } catch (error) {
      emit(BreweryListFailure(message: errorMapper.map(error)));
    }
  }

  Future<void> _onBreweryNextPageRequested(BreweryNextPageRequested event, Emitter<BreweriesListState> emit) async {
    // Check if we are currently working on a search or has reached the end
    if (_hasReachedEnd || _isLoadingMore) {
      return;
    }
    final currentState = state;
    //IF current state is NOT BrewerySuccess
    if (currentState is! BreweryListSuccess) {
      return;
    }

    final requestedMode = _mode;

    final requestedQuery = _activeQuery;

    final isSearchResult = requestedMode == BreweryListMode.search;
    _isLoadingMore = true;
    // Emit current State with loading to show we are working
    emit(
      BreweryListSuccess(
        breweries: currentState.breweries,
        hasReachedEnd: _hasReachedEnd,
        isLoadingMore: true,
        isSearchResult: isSearchResult,
        paginationError: false,
      ),
    );

    try {
      //Check Mode
      final nextPage = switch (_mode) {
        BreweryListMode.regular => _currentPage + 1,
        BreweryListMode.search => _currentSearchPage + 1,
      };

      //This bring the required data depending on the mode
      final newBreweries = await getNextPage(
        repository: repository,
        mode: requestedMode,
        page: nextPage,
        perPage: _perPage,
        activeQuery: requestedQuery,
      );

      // The user changed mode or query while this page was loading.

      if (_mode != requestedMode || _activeQuery != requestedQuery) {
        _isLoadingMore = false;

        return;
      }

      //Check if breweries is empty
      if (newBreweries.isEmpty) {
        _hasReachedEnd = true;
        _isLoadingMore = false;

        emit(
          BreweryListSuccess(
            breweries: currentState.breweries,
            hasReachedEnd: _hasReachedEnd,
            isLoadingMore: _isLoadingMore,
            isSearchResult: isSearchResult,
            paginationError: false,
          ),
        );
        return;
      }

      /// If everything is OK then we update the list
      switch (requestedMode) {
        case BreweryListMode.regular:
          _currentPage = nextPage;
        case BreweryListMode.search:
          _currentSearchPage = nextPage;
      }
      _hasReachedEnd = newBreweries.length < _perPage;
      _isLoadingMore = false;

      //Combine both lists
      emit(
        BreweryListSuccess(
          breweries: [...currentState.breweries, ...newBreweries],
          hasReachedEnd: _hasReachedEnd,
          isLoadingMore: _isLoadingMore,
          isSearchResult: isSearchResult,
          paginationError: false,
        ),
      );
    } catch (_) {
      //If something fails then we keep the list maybe add some snackbar showing we had an error
      _isLoadingMore = false;

      emit(
        BreweryListSuccess(
          breweries: currentState.breweries,
          hasReachedEnd: _hasReachedEnd,
          isLoadingMore: false,
          isSearchResult: isSearchResult,
          paginationError: true,
        ),
      );
    }
  }

  void _resetData() {
    _activeQuery = '';
    _currentSearchPage = 1;
    _currentPage = 1;
    _hasReachedEnd = false;
    _isLoadingMore = false;
  }

  Future<void> _onBreweryListRetry(BreweryListRetry event, Emitter<BreweriesListState> emit) async {
    switch (_mode) {
      case BreweryListMode.regular:
        add(const BreweryListRequested());
      case BreweryListMode.search:
        add(BrewerySearchChanged(_activeQuery));
    }
  }
}
