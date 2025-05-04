import 'package:json_annotation/json_annotation.dart';
part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  const NotificationModel({
    required this.created_at,
    required this.description,
    required this.title,
    required this.id,
    this.is_seen = true,
  });
  final String description;
  final String title;
  final int id;
  final String? created_at;
  final bool? is_seen;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
