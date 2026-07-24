import 'package:json_annotation/json_annotation.dart';
import 'package:tech_challenge/core/errors/parse_exception.dart';

part 'brewery_dto.g.dart';

//Represent the raw API response.
@JsonSerializable()
class BreweryDto {
  const BreweryDto({
    required this.id,

    required this.name,

    required this.breweryType,

    required this.city,

    this.address1,

    this.address2,

    this.address3,

    this.stateProvince,

    this.postalCode,

    this.country,

    this.longitude,

    this.latitude,

    this.phone,

    this.websiteUrl,
  });
  final String id;

  final String name;

  @JsonKey(name: 'brewery_type')
  final String breweryType;

  final String city;

  @JsonKey(name: 'address_1')
  final String? address1;

  @JsonKey(name: 'address_2')
  final String? address2;

  @JsonKey(name: 'address_3')
  final String? address3;

  @JsonKey(name: 'state_province')
  final String? stateProvince;

  @JsonKey(name: 'postal_code')
  final String? postalCode;

  @JsonKey(name: 'website_url')
  final String? websiteUrl;

  final String? country;
  final double? longitude;
  final double? latitude;
  final String? phone;

  factory BreweryDto.fromJson(Object? json) {
    try {
      if (json is! Map) {
        throw const ParseException();
      }

      final map = Map<String, dynamic>.from(json);

      return _$BreweryDtoFromJson(map);
    } on ParseException {
      rethrow;
    } on FormatException {
      throw const ParseException();
    } on TypeError {
      throw const ParseException();
    }
  }

  Map<String, dynamic> toJson() {
    return _$BreweryDtoToJson(this);
  }
}
