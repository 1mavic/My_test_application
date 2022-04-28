import "package:json_annotation/json_annotation.dart";

part "photo_model.g.dart";

@JsonSerializable()
class Photo {
  @JsonKey(required: true)
  final int id;
  @JsonKey(required: true)
  final int albumId;
  @JsonKey(required: true)
  final String title;
  @JsonKey(required: true)
  final String thumbnailUrl;
  @JsonKey(required: true)
  final String url;

  Photo({
    required this.id,
    required this.albumId,
    required this.title,
    required this.thumbnailUrl,
    required this.url,
  });

  Photo copyWith({
    int? id,
    int? albumId,
    String? title,
    String? thumbnailUrl,
    String? url,
  }) {
    return Photo(
      id: id ?? this.id,
      albumId: albumId ?? this.albumId,
      title: title ?? this.title,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      url: url ?? this.url,
    );
  }

  @override
  String toString() {
    return "Photo(id: $id, albumId: $albumId, title: $title, thumbnailUrl: $thumbnailUrl, url: $url)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Photo &&
        other.id == id &&
        other.albumId == albumId &&
        other.title == title &&
        other.thumbnailUrl == thumbnailUrl &&
        other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        albumId.hashCode ^
        title.hashCode ^
        thumbnailUrl.hashCode ^
        url.hashCode;
  }

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
