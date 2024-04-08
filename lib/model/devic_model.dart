
import 'package:flexi/model/wifi_model.dart';




class DeviceModel {

  String? id;
  String? name;
  double? audioVolume;
  String? timezone;
  String? currentContentId;
  bool connectedWifi;
  WifiModel? currentWifi;
  bool connectedBluetooth = false;
  String? connectedBluethoothId;

  DeviceModel({
    this.id,
    this.name,
    this.timezone,
    this.currentContentId,
    this.connectedWifi = false,
    this.currentWifi,
    this.connectedBluetooth = false,
    this.connectedBluethoothId
  });



}