import "dart:convert";

import "package:json_annotation/json_annotation.dart";

import "package:flutter_test_application/domain/entity/geo/geo_model.dart";

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

  Address copyWith({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    Geo? geo,
  }) {
    return Address(
      street: street ?? this.street,
      suite: suite ?? this.suite,
      city: city ?? this.city,
      zipcode: zipcode ?? this.zipcode,
      geo: geo ?? this.geo,
    );
  }

  @override
  String toString() {
    return "Address(street: $street, suite: $suite, city: $city, zipcode: $zipcode, geo: $geo)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.street == street &&
        other.suite == suite &&
        other.city == city &&
        other.zipcode == zipcode &&
        other.geo == geo;
  }

  @override
  int get hashCode {
    return street.hashCode ^
        suite.hashCode ^
        city.hashCode ^
        zipcode.hashCode ^
        geo.hashCode;
  }
}
