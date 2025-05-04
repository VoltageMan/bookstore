// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      created_at: json['created_at'] as String?,
      description: json['description'] as String,
      title: json['title'] as String,
      id: json['id'] as int,
      is_seen: json['is_seen'] as bool? ?? true,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'title': instance.title,
      'id': instance.id,
      'created_at': instance.created_at,
      'is_seen': instance.is_seen,
    };
