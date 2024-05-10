import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_info.freezed.dart';



@freezed
class NetworkInfo with _$NetworkInfo {
  const factory NetworkInfo({
    String? ssid,
    String? bssid,
    String? ip,
    String? ipv6
  }) = _NetworkInfo;
}