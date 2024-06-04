import 'package:freezed_annotation/freezed_annotation.dart';

part 'bluetooth_info.freezed.dart';



@freezed
class BluetoothInfo with _$BluetoothInfo {
  const factory BluetoothInfo({
    String? name,
    String? remoteId,
  }) = _BluetoothInfo;
}