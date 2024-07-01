import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info.g.dart';
part 'device_info.freezed.dart';


@freezed
class DeviceInfo with _$DeviceInfo {

  factory DeviceInfo({
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
  }) = _DeviceInfo;

  DeviceInfo._();

  factory DeviceInfo.fromJson(Map<String, dynamic> map) => _$DeviceInfoFromJson(map);

}