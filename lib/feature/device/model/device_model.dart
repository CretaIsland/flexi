import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_model.g.dart';
part 'device_model.freezed.dart';



@freezed
class DeviceModel with _$DeviceModel {

  factory DeviceModel({
    @Default('') String deviceId,
    @Default('') String deviceName,
    @Default('') String ip,
    @Default('') String connectionMode,
    @Default(false)bool isRegistered,
    @Default('')String registeredSSID,
    @Default(false)bool hasContent,
    @Default(false)bool bluetoothBonded,
    @Default('')String bluetooth,
    @Default('')String bluetoothId,
    @Default(0) int volume,
    @Default('')String timeZone,
  }) = _DeviceModel;

  DeviceModel._();

  factory DeviceModel.fromJson(Map<String, dynamic> map) => _$DeviceModelFromJson(map);

}