import 'package:tech_challenge/ui/features/breweries_list/data/dtos/brewery_dto.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_entity.dart';

extension BreweryMapper on BreweryDto {
  Brewery toEntity() {
    return Brewery(id: id, name: name, city: city, address: address1);
  }
}
