// GENERATED CODE - DO NOT MODIFY BY HAND

part of "post_model.dart";

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ["id", "userId", "title", "body"],
  );
  return Post(
    id: json["id"] as int,
    userId: json["userId"] as int,
    title: json["title"] as String,
    body: json["body"] as String,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      "id": instance.id,
      "userId": instance.userId,
      "title": instance.title,
      "body": instance.body,
    };
