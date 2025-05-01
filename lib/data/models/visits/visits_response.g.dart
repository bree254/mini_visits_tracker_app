// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visits_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitsResponse _$VisitsResponseFromJson(Map<String, dynamic> json) =>
    VisitsResponse(
      id: (json['id'] as num?)?.toInt(),
      customerId: (json['customer_id'] as num?)?.toInt(),
      visitDate: json['visit_date'] == null
          ? null
          : DateTime.parse(json['visit_date'] as String),
      status: json['status'] as String?,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      activitiesDone: (json['activities_done'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$VisitsResponseToJson(VisitsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerId,
      'visit_date': instance.visitDate?.toIso8601String(),
      'status': instance.status,
      'location': instance.location,
      'notes': instance.notes,
      'activities_done': instance.activitiesDone,
      'created_at': instance.createdAt?.toIso8601String(),
    };
