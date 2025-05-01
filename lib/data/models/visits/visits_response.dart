import 'package:json_annotation/json_annotation.dart';

part 'visits_response.g.dart';

@JsonSerializable()
class VisitsResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "customer_id")
  int? customerId;
  @JsonKey(name: "visit_date")
  DateTime? visitDate;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "location")
  String? location;
  @JsonKey(name: "notes")
  String? notes;
  @JsonKey(name: "activities_done")
  List<String>? activitiesDone;
  @JsonKey(name: "created_at")
  DateTime? createdAt;

  VisitsResponse({
    this.id,
    this.customerId,
    this.visitDate,
    this.status,
    this.location,
    this.notes,
    this.activitiesDone,
    this.createdAt,
  });

  factory VisitsResponse.fromJson(Map<String, dynamic> json) => _$VisitsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VisitsResponseToJson(this);
}
