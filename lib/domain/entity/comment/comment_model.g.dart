// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'postId', 'email', 'name', 'body'],
  );
  return Comment(
    id: json['id'] as int,
    postId: json['postId'] as int,
    email: json['email'] as String,
    name: json['name'] as String,
    body: json['body'] as String,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'email': instance.email,
      'name': instance.name,
      'body': instance.body,
    };
