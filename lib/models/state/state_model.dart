// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hh_express/models/delivery_info/deliery_info_model.dart';
import 'package:hh_express/settings/consts.dart';

class StateModel {
  String appVersion;
  DeliveryInfoModel deliveryInfo;
  StateModel({
    required this.appVersion,
    required this.deliveryInfo,
  });

  StateModel copyWith({
    String? appVersion,
    DeliveryInfoModel? deliveryInfo,
  }) {
    return StateModel(
      appVersion: appVersion ?? this.appVersion,
      deliveryInfo: deliveryInfo ?? this.deliveryInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appVersion': appVersion,
      'deliveryInfo': deliveryInfo.toMap(),
    };
  }

  factory StateModel.fromMap(Map<String, dynamic> map) {
    return StateModel(
      appVersion: map[APIKeys.appVersion] as String,
      deliveryInfo: DeliveryInfoModel.fromMap(
          map[APIKeys.deliveryInfo] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory StateModel.fromJson(String source) =>
      StateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'StateModel(appVersion: $appVersion, deliveryInfo: $deliveryInfo)';

  @override
  bool operator ==(covariant StateModel other) {
    if (identical(this, other)) return true;

    return other.appVersion == appVersion && other.deliveryInfo == deliveryInfo;
  }

  @override
  int get hashCode => appVersion.hashCode ^ deliveryInfo.hashCode;
}
