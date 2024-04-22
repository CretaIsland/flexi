import 'package:json_annotation/json_annotation.dart';

part 'bluetooth_device_model.g.dart';

@JsonSerializable()
class BluetoothDeviceModel {

  String deviceName;
  String macAddress;

  BluetoothDeviceModel({
    required this.deviceName,
    required this.macAddress
  });

  factory BluetoothDeviceModel.fromJson(Map<String, dynamic> json) => _$BluetoothDeviceModelFromJson(json);
  Map<String, dynamic> toJson() => _$BluetoothDeviceModelToJson(this);

}