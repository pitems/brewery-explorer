import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tech_challenge/ui/features/breweries_list/data/dtos/brewery_dto.dart';

import '../../../../helpers/fixture_reader.dart';

void main() {
  group('breweryDto', () {
    test('parses a real brewery list response', () {
      final jsonString = fixture('breweries_call.json');
      final decodedJson = jsonDecode(jsonString) as List<dynamic>;

      //Act
      final dtos = decodedJson.map((item) => BreweryDto.fromJson(item as Map<String, dynamic>)).toList();

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
  });
}
