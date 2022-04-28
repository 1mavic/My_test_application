// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'albumId', 'title', 'thumbnailUrl', 'url'],
  );
  return Photo(
    id: json['id'] as int,
    albumId: json['albumId'] as int,
    title: json['title'] as String,
    thumbnailUrl: json['thumbnailUrl'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'albumId': instance.albumId,
      'title': instance.title,
      'thumbnailUrl': instance.thumbnailUrl,
      'url': instance.url,
    };
