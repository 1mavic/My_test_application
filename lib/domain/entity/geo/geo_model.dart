import "package:json_annotation/json_annotation.dart";

part "geo_model.g.dart";

@JsonSerializable()
class Geo {
  @JsonKey(required: true)
  final String lat;
  @JsonKey(required: true)
  final String lng;

  Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoToJson(this);
}
