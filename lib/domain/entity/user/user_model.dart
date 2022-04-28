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

  User copyWith({
    int? id,
    String? name,
    String? userName,
    String? email,
    Address? address,
    String? phone,
    String? website,
    Company? company,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      company: company ?? this.company,
    );
  }

  @override
  String toString() {
    return "User(id: $id, name: $name, userName: $userName, email: $email, address: $address, phone: $phone, website: $website, company: $company)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.userName == userName &&
        other.email == email &&
        other.address == address &&
        other.phone == phone &&
        other.website == website &&
        other.company == company;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        website.hashCode ^
        company.hashCode;
  }
}
