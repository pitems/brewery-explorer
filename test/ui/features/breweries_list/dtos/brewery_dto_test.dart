import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tech_challenge/core/errors/parse_exception.dart';
import 'package:tech_challenge/ui/features/breweries_list/data/dtos/brewery_dto.dart';

import '../../../../helpers/fixture_reader.dart';

void main() {
  group('breweryDto', () {
    test('parses a real brewery list response', () {
      final jsonString = fixture('breweries_call.json');
      final decodedJson = jsonDecode(jsonString) as List<dynamic>;

      //Act
      final dtos = decodedJson.map(BreweryDto.fromJson).toList();

      //Assert
      expect(dtos, hasLength(20));

      final brewery = dtos.first;

      expect(brewery.id, 'ae7b3174-8be8-4d53-a3a5-9b8240970eea');
      expect(brewery.name, "'s");
      expect(brewery.breweryType, 'brewpub');
      expect(brewery.city, 'Kronach');
      expect(brewery.address1, '1 Friesener Stra\u00dfe');
      expect(brewery.address2, isNull);
      expect(brewery.address3, isNull);
      expect(brewery.phone, '+49 9261 628000');
      expect(brewery.websiteUrl, 'http://www.antla.de');
    });

    test('parses a real brewery detail from the fixture', () {
      final decodedJson = jsonDecode(fixture('breweries_call.json')) as List<dynamic>;
      final dto = BreweryDto.fromJson(decodedJson.first);

      expect(dto.id, 'ae7b3174-8be8-4d53-a3a5-9b8240970eea');
      expect(dto.name, "'s");
      expect(dto.breweryType, 'brewpub');
      expect(dto.city, 'Kronach');
      expect(dto.address1, '1 Friesener Straße');
      expect(dto.phone, '+49 9261 628000');
      expect(dto.websiteUrl, 'http://www.antla.de');
    });

    test('throws ParseException when the JSON value is not a map', () {
      expect(() => BreweryDto.fromJson(const []), throwsA(isA<ParseException>()));
    });

    test('throws ParseException when the JSON map has non-string keys', () {
      expect(
        () => BreweryDto.fromJson({1: 'invalid'}),
        throwsA(isA<ParseException>()),
      );
    });

    test('throws ParseException when a required field is missing', () {
      expect(
        () => BreweryDto.fromJson({
          'id': 'brewery-1',
          'name': 'Test Brewery',
          'brewery_type': 'micro',
        }),
        throwsA(isA<ParseException>()),
      );
    });

    test('throws ParseException when a field has an invalid type', () {
      expect(
        () => BreweryDto.fromJson({
          'id': 123,
          'name': 'Test Brewery',
          'brewery_type': 'micro',
          'city': 'Santiago',
        }),
        throwsA(isA<ParseException>()),
      );
    });
  });
}
