// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wifi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WifiModel _$WifiModelFromJson(Map<String, dynamic> json) => WifiModel(
      ssid: json['ssid'] as String,
      password: json['password'] as String? ?? "",
      isSecure: json['isSecure'] as bool? ?? false,
    );

Map<String, dynamic> _$WifiModelToJson(WifiModel instance) => <String, dynamic>{
      'ssid': instance.ssid,
      'password': instance.password,
      'isSecure': instance.isSecure,
    };
