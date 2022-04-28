import "package:flutter_test_application/domain/entity/adress/address_model.dart";
import "package:flutter_test_application/domain/entity/company/company_model.dart";
import "package:json_annotation/json_annotation.dart";

part "user_model.g.dart";

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(required: true)
  final int id;
  @JsonKey(required: true)
  final String name;
  @JsonKey(required: true, name: "username")
  final String userName;
  @JsonKey(required: true)
  final String email;
  @JsonKey(required: true)
  final Address address;
  @JsonKey(required: true)
  final String phone;
  @JsonKey(required: true)
  final String website;
  @JsonKey(required: true)
  final Company company;

  User({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
