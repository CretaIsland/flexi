

import 'package:flexi/model/bluetooth_device_model.dart';
import 'package:flexi/model/wifi_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeviceModel {

  String deviceId;
  String deviceName;
  String timezone;
  WifiModel? networkInfo;
  BluetoothDeviceModel? bluetoothInfo;
  double soundVolume;
  String? currentContentId;

  DeviceModel({
    required this.deviceId,
    required this.deviceName,
    required this.timezone,
    this.networkInfo,
    this.bluetoothInfo,
    required this.soundVolume,
    this.currentContentId
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) => _$DeviceModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);

}