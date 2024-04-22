import 'package:json_annotation/json_annotation.dart';
part 'wifi_model.g.dart';


@JsonSerializable()
class WifiModel {
  String ssid;
  String password;
  bool isSecure;

  WifiModel({
    required this.ssid,
    this.password = "",
    this.isSecure = false
  });

  factory WifiModel.fromJson(Map<String, dynamic> json) => _$WifiModelFromJson(json);
  Map<String, dynamic> toJson() => _$WifiModelToJson(this);

}