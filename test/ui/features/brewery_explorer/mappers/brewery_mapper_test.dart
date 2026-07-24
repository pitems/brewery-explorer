import 'package:flutter_test/flutter_test.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/data/dtos/brewery_dto.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/data/mapper/brewery_mapper.dart';

void main() {
  group('Brewery Mapper', () {
    late BreweryDto dto;
    setUp(() {
      dto = const BreweryDto(
        id: 'test-brewery-1',
        name: 'Test Brewery',
        breweryType: 'micro',
        city: 'Santiago',
        address1: '123 Beer Street',
        address2: 'Second Floor',
        address3: null,
        phone: '123456789',
        websiteUrl: 'https://example.com',
      );
    });

    test('maps the BreweryDto into a brewery list entity', () {
      final entity = dto.toEntity();

      expect(entity.id, 'test-brewery-1');
      expect(entity.name, 'Test Brewery');
      expect(entity.type, 'micro');
      expect(entity.city, 'Santiago');
    });

    test('maps the BreweryDto into a detail entity', () {
      final entity = dto.toDetailEntity();

      // Assert
      expect(entity.name, 'Test Brewery');
      expect(entity.phone, '123456789');
      expect(entity.website, 'https://example.com');
      expect(entity.addresses, ['123 Beer Street', 'Second Floor']);
    });

    test('removes null and empty address values', () {
      final dtoWithMissingAddresses = BreweryDto(
        id: 'test-brewery-2',
        name: 'Another Brewery',
        breweryType: 'brewpub',
        city: 'Valparaíso',
        address1: 'Main Street',
        address2: '',
        address3: null,
        phone: null,
        websiteUrl: null,
      );
      // Act
      final entity = dtoWithMissingAddresses.toDetailEntity();
      // Assert
      expect(entity.addresses, ['Main Street']);
    });
  });
}
