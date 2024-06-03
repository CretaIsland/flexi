import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info.freezed.dart';
part 'device_info.g.dart';



@freezed
class DeviceInfo with _$DeviceInfo {
  factory DeviceInfo({
    String? connectionMode,
    String? deviceId,
    String? ip,
    bool? isRegistered,
    bool? hasContent,
    bool? bluetoothBonded,
    String? bluetooth,
    String? bluetoothId,
    int? volume,
    String? timezone
  }) = _DeviceInfo;

  DeviceInfo._();

  factory DeviceInfo.fromJson(Map<String, dynamic> map) => _$DeviceInfoFromJson(map);

}