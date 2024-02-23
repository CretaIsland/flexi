import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:flexi/model/wifi_model.dart';


class WifiDiscovery {

  List<WifiModel> availableWifiList = [];
  WifiModel? connectedWifi;


  // wifi scan
  Future<void> scanWifi() async {
    final isScanable = await WiFiScan.instance.canStartScan();
    if(isScanable != CanStartScan.yes) {
      return;
    } 
    // availableWifiList 초기화
    availableWifiList.clear();
    await WiFiScan.instance.startScan();
    final scannedResults = await WiFiScan.instance.getScannedResults();
    for(var scannedWifi in scannedResults) {
      availableWifiList.add(WifiModel.fromWiFiAccessPoint(scannedWifi));
    }
  }
  
  // wifi filtering
  void filterFromSsid(String ssid) {
    availableWifiList.removeWhere((element) => !element.ssid.contains(ssid));
  }

  // wifi connect
  Future<bool> connect(String ssid, {String password = ''}) async {
    if(await WiFiForIoTPlugin.isConnected()) await disconnect();
    final isConnected = await WiFiForIoTPlugin.connect(ssid, password: password, security: NetworkSecurity.WPA);
    if(isConnected) {
      int targetIndex = availableWifiList.indexWhere((element) => element.ssid == ssid);
      if(targetIndex != -1) connectedWifi = availableWifiList[targetIndex];
    }
    return isConnected;
  }

  // wifi disconnect
  Future<bool> disconnect() async {
    final isDisconnected = await WiFiForIoTPlugin.disconnect();
    return isDisconnected;
  }


}