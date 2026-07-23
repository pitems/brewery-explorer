import 'package:tech_challenge/ui/features/breweries_list/data/dtos/brewery_dto.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_detail_entity.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_entity.dart';

// Converts the BreweryDto into domain entities
extension BreweryMapper on BreweryDto {
  Brewery toEntity() {
    return Brewery(id: id, name: name, city: city, type: breweryType);
  }

  BreweryDetail toDetailEntity() {
    return BreweryDetail(
      id: id,
      name: name,
      phone: phone,
      website: websiteUrl,
      addresses: [address1, address2, address3].whereType<String>().where((e) => e.trim().isNotEmpty).toList(),
    );
  }
}
