import 'package:wifi_scan/wifi_scan.dart';

class WifiModel {

  String ssid = '';
  String bssid = '';
  String capabilities = '';
  bool secure = false;
  int level = 0;
  int frequency = 0;
 
  int? centerFrequency0;
  int? centerFrequency1;
  bool? isPasspoint;
  String? operatorFriendlyName;
  String? venueName;
  bool? is80211mcResponder;
  WiFiChannelWidth? channelWidth;


  WifiModel();
  WifiModel.withParam(this.ssid, this.bssid, this.capabilities, this.secure, this.level, this.frequency, 
    this.centerFrequency0, this.centerFrequency1, this.isPasspoint, this.operatorFriendlyName, this.venueName, this.is80211mcResponder, this.channelWidth);
  
  static WifiModel fromWiFiAccessPoint(WiFiAccessPoint wifiAccessPoint) {
    return WifiModel.withParam(
      wifiAccessPoint.ssid,
      wifiAccessPoint.bssid,
      wifiAccessPoint.capabilities,
      wifiAccessPoint.capabilities.contains("WPA"),
      wifiAccessPoint.level,
      wifiAccessPoint.frequency,
      wifiAccessPoint.centerFrequency0,
      wifiAccessPoint.centerFrequency1,
      wifiAccessPoint.isPasspoint,
      wifiAccessPoint.operatorFriendlyName,
      wifiAccessPoint.venueName,
      wifiAccessPoint.is80211mcResponder,
      wifiAccessPoint.channelWidth
    );
  }




}