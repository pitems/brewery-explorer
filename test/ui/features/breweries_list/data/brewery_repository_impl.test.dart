import 'package:flutter_test/flutter_test.dart';
import 'package:tech_challenge/core/errors/network_exception.dart';
import 'package:tech_challenge/ui/features/breweries_list/data/brewery_remote_datasource.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tech_challenge/ui/features/breweries_list/data/dtos/brewery_dto.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_repository_impl.dart';

class MockBreweryRemoteDataSource extends Mock implements BreweryRemoteDatasource {}

void main() {
  late MockBreweryRemoteDataSource remoteDataSource;
  late BreweryRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockBreweryRemoteDataSource();
    repository = BreweryRepositoryImpl(remoteDatasource: remoteDataSource);
  });

  group('BreweryRepositoryImpl.getBreweries', () {
    //Arrange
    test('returns mapped breweries from the remote datasource', () async {
      final breweryDtos = [
        const BreweryDto(
          id: 'brewery-1',
          name: 'Test Brewery',
          breweryType: 'micro',
          city: 'Santiago',
          address1: 'Test Street 123',
        ),
      ];
      when(() => remoteDataSource.getBreweries(page: 1, perPage: 20)).thenAnswer((_) async => breweryDtos);
      //Act
      final result = await repository.getBreweries(page: 1, perPage: 20);
      //Assert
      expect(result, hasLength(1));
      expect(result.first.id, 'brewery-1');
      expect(result.first.name, 'Test Brewery');
      expect(result.first.type, 'micro');
      expect(result.first.city, 'Santiago');

      verify(() => remoteDataSource.getBreweries(page: 1, perPage: 20)).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    test('throws NetworkException when datasource fails', () async {
      //Arrange
      when(() => remoteDataSource.getBreweries(page: 1, perPage: 20)).thenThrow(const NetworkException());

      //Act
      final call = repository.getBreweries(page: 1, perPage: 20);

      //Assert
      await expectLater(call, throwsA(isA<NetworkException>()));

      verify(() => remoteDataSource.getBreweries(page: 1, perPage: 20)).called(1);
    });
  });

  group('getBrewery', () {
    test('returns a mapped brewery detail from the datasource', () async {
      //Arrange
      const breweryId = 'brewery-1';

      const breweryDto = BreweryDto(
        id: breweryId,
        name: 'Test Brewery',
        breweryType: 'micro',
        city: 'Santiago',
        address1: 'Beer Street 123',
        address2: 'Second Floor',
        address3: null,
        phone: '123456789',
        websiteUrl: 'https://example.com',
      );
      //Act
      when(() => remoteDataSource.getBrewery(breweryId)).thenAnswer((_) async => breweryDto);

      final result = await repository.getBrewery(breweryId);

      //Assert
      expect(result.name, 'Test Brewery');
      expect(result.phone, '123456789');
      expect(result.website, 'https://example.com');
      expect(result.addresses, ['Beer Street 123', 'Second Floor']);

      verify(() => remoteDataSource.getBrewery(breweryId)).called(1);
    });

    test('throws a NetworkException when detail datasource fails', () async {
      //Arrange
      const breweryId = 'brewery-1';

      when(() => remoteDataSource.getBrewery(breweryId)).thenThrow(const NetworkException());

      //Act
      final call = repository.getBrewery(breweryId);
      await expectLater(call, throwsA(isA<NetworkException>()));

      verify(() => remoteDataSource.getBrewery(breweryId)).called(1);
    });
  });
}
