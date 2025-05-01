import 'package:json_annotation/json_annotation.dart';

part 'activity_response.g.dart';

@JsonSerializable()
class ActivityResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "created_at")
  DateTime? createdAt;

  ActivityResponse({
    this.id,
    this.description,
    this.createdAt,
  });

  factory ActivityResponse.fromJson(Map<String, dynamic> json) => _$ActivityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityResponseToJson(this);
}
