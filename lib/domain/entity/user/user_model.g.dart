// GENERATED CODE - DO NOT MODIFY BY HAND

part of "user_model.dart";

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      "id",
      "name",
      "username",
      "email",
      "address",
      "phone",
      "website",
      "company"
    ],
  );
  return User(
    id: json["id"] as int,
    name: json["name"] as String,
    userName: json["username"] as String,
    email: json["email"] as String,
    address: Address.fromJson(json["address"] as Map<String, dynamic>),
    phone: json["phone"] as String,
    website: json["website"] as String,
    company: Company.fromJson(json["company"] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      "id": instance.id,
      "name": instance.name,
      "username": instance.userName,
      "email": instance.email,
      "address": instance.address.toJson(),
      "phone": instance.phone,
      "website": instance.website,
      "company": instance.company.toJson(),
    };
