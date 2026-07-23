import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tech_challenge/core/errors/app_error_mapper.dart';
import 'package:tech_challenge/core/errors/network_exception.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_entity.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_repository.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list/breweries_list_bloc.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list/breweries_list_state.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list/brewery_list_event.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late BreweryRepository repository;
  late AppErrorMapper errorMapper;

  const breweries = [
    Brewery(
      id: 'brewery-1',
      name: 'Test Brewery',
      type: 'micro',
      city: 'Santiago',
    ),
  ];

  const page = 1;
  const perPage = 20;

  setUp(() {
    repository = MockBreweryRepository();
    errorMapper = MockAppErrorMapper();
  });

  BreweriesListBloc buildBloc() {
    return BreweriesListBloc(
      repository: repository,
      errorMapper: errorMapper,
    );
  }

  //Initial State
  test('Initial state is BreweryListInitial', () {
    final bloc = buildBloc();

    expect(
      bloc.state,
      isA<BreweryListInitial>(),
    );

    bloc.close();
  });
  //Successful Request Bloc Test
  blocTest<BreweriesListBloc, BreweriesListState>(
    'Emits Loading and Success states when the list request succeds',
    build: () {
      when(
        () => repository.getBreweries(
          page: 1,
          perPage: 20,
        ),
      ).thenAnswer(
        (_) async => breweries,
      );

      return buildBloc();
    },
    act: (bloc) {
      bloc.add(const BreweryListRequested());
    },
    expect: () => [
      isA<BreweryListLoading>(),
      isA<BreweryListSuccess>()
          .having(
            (state) => state.breweries,
            'breweries',
            breweries,
          )
          .having(
            (state) => state.isLoadingMore,
            'isLoadingMore',
            false,
          ),
    ],

    verify: (_) {
      verify(
        () => repository.getBreweries(
          page: 1,
          perPage: 20,
        ),
      ).called(1);
    },
  );
  //Empty Data Test
  blocTest<BreweriesListBloc, BreweriesListState>(
    'Emits a Loading and then an Empty when the repository returns no breweries',
    build: () {
      when(
        () => repository.getBreweries(
          page: page,
          perPage: perPage,
        ),
      ).thenAnswer(
        (_) async => [],
      );
      return buildBloc();
    },
    act: (bloc) {
      bloc.add(const BreweryListRequested());
    },
    expect: () => [
      isA<BreweryListLoading>(),
      isA<BreweryListEmpty>(),
    ],
  );
  //Failure Request
  blocTest<BreweriesListBloc, BreweriesListState>(
    'Emits a Loading and Failure when the repository throws',
    build: () {
      when(() => repository.getBreweries(page: page, perPage: perPage)).thenThrow(
        const NetworkException(),
      );

      when(() => errorMapper.map(any())).thenReturn('Network unavailable.');

      return buildBloc();
    },

    act: (bloc) => bloc.add(const BreweryListRequested()),

    expect: () => [
      isA<BreweryListLoading>(),
      isA<BreweryListFailure>().having(
        (state) => state.message,
        'message',
        'Network unavailable.',
      ),
    ],
  );
  // Query Search
  blocTest<BreweriesListBloc, BreweriesListState>(
    'Searches breweries when query has at least three characters',
    build: () {
      when(
        () => repository.searchBreweries(
          query: 'beer',
          page: page,
          perPage: perPage,
        ),
      ).thenAnswer(
        (_) async => breweries,
      );

      return buildBloc();
    },

    act: ((bloc) => bloc.add(
      const BrewerySearchChanged('beer'),
    )),
    // Wait for debounce
    wait: const Duration(milliseconds: 400),
    expect: () => [
      isA<BreweryListLoading>(),
      isA<BreweryListSuccess>().having(
        (state) => state.isSearchResult,
        'isSearchResult',
        true,
      ),
    ],
  );
  //Small Query Search
  blocTest<BreweriesListBloc, BreweriesListState>(
    'Does not search when the query has fewer than three characters',
    build: () {
      return buildBloc();
    },

    act: ((bloc) => bloc.add(
      BrewerySearchChanged('be'),
    )),
    wait: Duration(milliseconds: 400),
    expect: () => <BreweriesListState>[],
    verify: (_) {
      verifyNever(
        () => repository.searchBreweries(
          query: any(named: 'query'),
          page: any(named: 'page'),
          perPage: any(named: 'perPage'),
        ),
      );
    },
  );

  //Debounce Test
  blocTest<BreweriesListBloc, BreweriesListState>(
    'Only searches the latest query inside the debounce window',
    build: () {
      when(
        () => repository.searchBreweries(
          query: 'beer',
          page: page,
          perPage: perPage,
        ),
      ).thenAnswer((_) async => breweries);

      return buildBloc();
    },
    act: ((bloc) async {
      bloc.add(BrewerySearchChanged('bee'));

      await Future<void>.delayed(
        const Duration(milliseconds: 100),
      );

      bloc.add(const BrewerySearchChanged('beer'));
    }),
    wait: const Duration(milliseconds: 450),
    expect: () => [
      isA<BreweryListLoading>(),
      isA<BreweryListSuccess>(),
    ],
    verify: (_) {
      verify(() => repository.searchBreweries(query: 'beer', page: page, perPage: perPage)).called(1);

      verifyNever(
        () => repository.searchBreweries(
          query: 'bee',
          page: any(named: 'page'),
          perPage: any(named: 'perPage'),
        ),
      );
    },
  );

  late Completer<List<Brewery>> firstCompleter;
  late Completer<List<Brewery>> secondCompleter;

  const firstSearchResults = [
    Brewery(
      id: '1',
      name: 'Old Result',
      type: 'micro',
      city: 'Santiago',
    ),
  ];
  const secondSearchResults = [
    Brewery(
      id: '2',
      name: 'Latest Result',
      type: 'brewpub',
      city: 'Valparaíso',
    ),
  ];
  blocTest<BreweriesListBloc, BreweriesListState>(
    'Keep only the latest search result when a previous search is pending',
    setUp: () {
      firstCompleter = Completer<List<Brewery>>();
      secondCompleter = Completer<List<Brewery>>();
    },
    build: () {
      when(
        () => repository.searchBreweries(query: 'beer', page: page, perPage: perPage),
      ).thenAnswer(
        (_) => firstCompleter.future,
      );

      when(() => repository.searchBreweries(query: 'brewery', page: page, perPage: perPage)).thenAnswer(
        (_) => secondCompleter.future,
      );
      return buildBloc();
    },
    act: ((bloc) async {
      bloc.add(const BrewerySearchChanged('beer'));

      //let the first call pass the debounce and start the request
      await Future<void>.delayed(
        const Duration(milliseconds: 400),
      );

      bloc.add(BrewerySearchChanged('brewery'));

      // The second Debounce also pass
      await Future<void>.delayed(
        Duration(milliseconds: 400),
      );
      secondCompleter.complete(secondSearchResults);

      firstCompleter.complete(firstSearchResults);
    }),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      isA<BreweryListLoading>(),
      isA<BreweryListSuccess>().having((state) => state.breweries, 'latest search results', secondSearchResults),
    ],

    verify: (_) {
      verify(
        () => repository.searchBreweries(
          query: 'beer',
          page: page,
          perPage: perPage,
        ),
      ).called(1);
      verify(
        () => repository.searchBreweries(
          query: 'brewery',
          page: page,
          perPage: perPage,
        ),
      ).called(1);
    },
  );
}
