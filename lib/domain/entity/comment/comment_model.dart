import "package:json_annotation/json_annotation.dart";

part "comment_model.g.dart";

@JsonSerializable()
class Comment {
  @JsonKey(required: true)
  final int id;
  @JsonKey(required: true)
  final int postId;
  @JsonKey(required: true)
  final String email;
  @JsonKey(required: true)
  final String name;
  @JsonKey(required: true)
  final String body;

  Comment({
    required this.id,
    required this.postId,
    required this.email,
    required this.name,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  Comment copyWith({
    int? id,
    int? postId,
    String? email,
    String? name,
    String? body,
  }) {
    return Comment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      email: email ?? this.email,
      name: name ?? this.name,
      body: body ?? this.body,
    );
  }

  @override
  String toString() {
    return "Comment(id: $id, postId: $postId, email: $email, name: $name, body: $body)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.id == id &&
        other.postId == postId &&
        other.email == email &&
        other.name == name &&
        other.body == body;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        postId.hashCode ^
        email.hashCode ^
        name.hashCode ^
        body.hashCode;
  }
}
