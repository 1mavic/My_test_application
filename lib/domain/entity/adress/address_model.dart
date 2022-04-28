import "package:flutter_test_application/domain/entity/geo/geo_model.dart";
import "package:json_annotation/json_annotation.dart";

part "address_model.g.dart";

@JsonSerializable(explicitToJson: true)
class Address {
  @JsonKey(required: true)
  final String street;
  @JsonKey(required: true)
  final String suite;
  @JsonKey(required: true)
  final String city;
  @JsonKey(required: true)
  final String zipcode;
  @JsonKey(required: true)
  final Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
