import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info.freezed.dart';
part 'device_info.g.dart';



@freezed
class DeviceInfo with _$DeviceInfo {
  factory DeviceInfo({
    @Default('')String connectionMode,
    @Default('')String deviceId,
    @Default('')String ip,
    @Default(false)bool isRegistered,
    @Default(false)bool hasContent,
    @Default(false)bool bluetoothBonded,
    @Default('')String bluetooth,
    @Default('')String bluetoothId,
    @Default(50)int volume,
    @Default('')String timeZone,
    @Default('')String registeredSSID,
    @Default('')String deviceName
  }) = _DeviceInfo;

  DeviceInfo._();

  factory DeviceInfo.fromJson(Map<String, dynamic> map) => _$DeviceInfoFromJson(map);

}