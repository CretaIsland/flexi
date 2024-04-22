// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bluetooth_device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BluetoothDeviceModel _$BluetoothDeviceModelFromJson(
        Map<String, dynamic> json) =>
    BluetoothDeviceModel(
      deviceName: json['deviceName'] as String,
      macAddress: json['macAddress'] as String,
    );

Map<String, dynamic> _$BluetoothDeviceModelToJson(
        BluetoothDeviceModel instance) =>
    <String, dynamic>{
      'deviceName': instance.deviceName,
      'macAddress': instance.macAddress,
    };
