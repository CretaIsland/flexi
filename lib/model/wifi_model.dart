
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(checked: true, createFactory: true, fieldRename: FieldRename.snake)
class WifiModel {

  String? ssid;
  String? bssid;
  bool? secure;

  WifiModel({
    this.ssid,
    this.bssid,
    this.secure
  });

  



}