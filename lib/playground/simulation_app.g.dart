// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerStatusImpl _$$PlayerStatusImplFromJson(Map<String, dynamic> json) =>
    _$PlayerStatusImpl(
      command: json['command'] as String,
      deviceId: json['deviceId'] as String,
      connectionMode: json['connectionMode'] as String?,
      ip: json['ip'] as String?,
      isRegistered: json['isRegistered'] as bool?,
      hasContent: json['hasContent'] as bool?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$PlayerStatusImplToJson(_$PlayerStatusImpl instance) =>
    <String, dynamic>{
      'command': instance.command,
      'deviceId': instance.deviceId,
      'connectionMode': instance.connectionMode,
      'ip': instance.ip,
      'isRegistered': instance.isRegistered,
      'hasContent': instance.hasContent,
      'runtimeType': instance.$type,
    };

_$RegisterImpl _$$RegisterImplFromJson(Map<String, dynamic> json) =>
    _$RegisterImpl(
      command: json['command'] as String,
      deviceId: json['deviceId'] as String,
      ssid: json['ssid'] as String?,
      password: json['password'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RegisterImplToJson(_$RegisterImpl instance) =>
    <String, dynamic>{
      'command': instance.command,
      'deviceId': instance.deviceId,
      'ssid': instance.ssid,
      'password': instance.password,
      'runtimeType': instance.$type,
    };

_$UnRegisterImpl _$$UnRegisterImplFromJson(Map<String, dynamic> json) =>
    _$UnRegisterImpl(
      command: json['command'] as String,
      deviceId: json['deviceId'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UnRegisterImplToJson(_$UnRegisterImpl instance) =>
    <String, dynamic>{
      'command': instance.command,
      'deviceId': instance.deviceId,
      'runtimeType': instance.$type,
    };
