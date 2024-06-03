// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceInfoImpl _$$DeviceInfoImplFromJson(Map<String, dynamic> json) =>
    _$DeviceInfoImpl(
      connectionMode: json['connectionMode'] as String?,
      deviceId: json['deviceId'] as String?,
      ip: json['ip'] as String?,
      isRegistered: json['isRegistered'] as bool?,
      hasContent: json['hasContent'] as bool?,
      bluetoothBonded: json['bluetoothBonded'] as bool?,
      bluetooth: json['bluetooth'] as String?,
      bluetoothId: json['bluetoothId'] as String?,
      volume: json['volume'] as int?,
      timezone: json['timezone'] as String?,
    );

Map<String, dynamic> _$$DeviceInfoImplToJson(_$DeviceInfoImpl instance) =>
    <String, dynamic>{
      'connectionMode': instance.connectionMode,
      'deviceId': instance.deviceId,
      'ip': instance.ip,
      'isRegistered': instance.isRegistered,
      'hasContent': instance.hasContent,
      'bluetoothBonded': instance.bluetoothBonded,
      'bluetooth': instance.bluetooth,
      'bluetoothId': instance.bluetoothId,
      'volume': instance.volume,
      'timezone': instance.timezone,
    };
