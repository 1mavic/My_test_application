import "package:json_annotation/json_annotation.dart";

part "album_model.g.dart";

@JsonSerializable()
class Album {
  @JsonKey(required: true)
  final int id;
  @JsonKey(required: true)
  final int userId;
  @JsonKey(required: true)
  final String title;

  Album({
    required this.id,
    required this.userId,
    required this.title,
  });

  Album copyWith({
    int? id,
    int? userId,
    String? title,
  }) {
    return Album(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
    );
  }

  @override
  String toString() => "Album(id: $id, userId: $userId, title: $title)";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Album &&
        other.id == id &&
        other.userId == userId &&
        other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ title.hashCode;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
