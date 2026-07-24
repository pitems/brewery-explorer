import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tech_challenge/core/errors/app_error_mapper.dart';
import 'package:tech_challenge/core/errors/network_exception.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/domain/brewery_detail_entity.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/domain/brewery_repository.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/brewery_detail/brewery_detail_bloc.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/brewery_detail/brewery_detail_event.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/brewery_detail/brewery_detail_state.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late BreweryRepository repository;
  late AppErrorMapper errorMapper;

  const breweryId = 'brewery-1';

  BreweryDetail breweryDetail = BreweryDetail(
    id: breweryId,
    name: 'Test Brewery',
    addresses: [
      'Beer Street 123',
      'Second Floor',
    ],
    phone: '123456789',
    website: 'https://example.com',
  );

  setUp(() {
    repository = MockBreweryRepository();
    errorMapper = MockAppErrorMapper();
  });

  BreweryDetailBloc buildBloc() {
    return BreweryDetailBloc(
      repository: repository,
      errorMapper: errorMapper,
    );
  }

  //Successful detail loaded
  blocTest<BreweryDetailBloc, BreweryDetailState>(
    'Emits a Loading and Success when detail request succeeds',
    build: () {
      when(
        () => repository.getBrewery(breweryId),
      ).thenAnswer((_) async => breweryDetail);

      return buildBloc();
    },

    act: ((bloc) => bloc.add(BreweryDetailRequested(id: breweryId))),

    expect: () => [
      isA<BreweryDetailLoading>(),
      isA<BreweryDetailSuccess>().having(
        (state) => state.brewery,
        'brewery',
        breweryDetail,
      ),
    ],

    verify: (_) {
      verify(() => repository.getBrewery(breweryId)).called(1);
    },
  );
  //Detail Failure
  blocTest<BreweryDetailBloc, BreweryDetailState>(
    'Emits a Loading and Failure state when detail request fails',
    build: () {
      when(() => repository.getBrewery(breweryId)).thenThrow(
        const NetworkException(),
      );

      when(
        () => errorMapper.map(any()),
      ).thenReturn('Network unavailable.');

      return buildBloc();
    },

    act: ((bloc) => bloc.add(BreweryDetailRequested(id: breweryId))),

    expect: () => [
      isA<BreweryDetailLoading>(),
      isA<BreweryDetailFailure>().having(
        (state) => state.message,
        'message',
        'Network unavailable.',
      ),
    ],
  );
}
