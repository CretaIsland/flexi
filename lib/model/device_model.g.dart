// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) => DeviceModel(
      deviceId: json['deviceId'] as String,
      deviceName: json['deviceName'] as String,
      timezone: json['timezone'] as String,
      networkInfo: json['networkInfo'] == null
          ? null
          : WifiModel.fromJson(json['networkInfo'] as Map<String, dynamic>),
      bluetoothInfo: json['bluetoothInfo'] == null
          ? null
          : BluetoothDeviceModel.fromJson(
              json['bluetoothInfo'] as Map<String, dynamic>),
      soundVolume: (json['soundVolume'] as num).toDouble(),
      currentContentId: json['currentContentId'] as String?,
    );

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'deviceName': instance.deviceName,
      'timezone': instance.timezone,
      'networkInfo': instance.networkInfo?.toJson(),
      'bluetoothInfo': instance.bluetoothInfo?.toJson(),
      'soundVolume': instance.soundVolume,
      'currentContentId': instance.currentContentId,
    };
