import "package:json_annotation/json_annotation.dart";

part "geo_model.g.dart";

@JsonSerializable()
class Geo {
  @JsonKey(required: true)
  final String lat;
  @JsonKey(required: true)
  final String lng;

  Geo({
    required this.lat,
    required this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoToJson(this);

  Geo copyWith({
    String? lat,
    String? lng,
  }) {
    return Geo(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "lat": lat,
      "lng": lng,
    };
  }

  @override
  String toString() => "Geo(lat: $lat, lng: $lng)";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Geo && other.lat == lat && other.lng == lng;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}
