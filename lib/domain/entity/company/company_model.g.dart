// GENERATED CODE - DO NOT MODIFY BY HAND

part of "company_model.dart";

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ["name", "catchPhrase", "bs"],
  );
  return Company(
    name: json["name"] as String,
    catchPhrase: json["catchPhrase"] as String,
    bs: json["bs"] as String,
  );
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      "name": instance.name,
      "catchPhrase": instance.catchPhrase,
      "bs": instance.bs,
    };
