import 'dart:async';

import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:network_info_plus/network_info_plus.dart' as network_info_plus;
import 'package:wifi_iot/wifi_iot.dart';

import '../model/network_info.dart';

part 'network_controller.g.dart';



@riverpod
class NetworkController extends _$NetworkController {

  @override
  Future<NetworkInfo> build() async {
    ref.onDispose(() {
      print("<<<<<<< NetworkController dispose <<<<<<<");
    });
    print(">>>>>>> NetworkController build >>>>>>");
    return getNetworkInfo();
  }

  Future<NetworkInfo> getNetworkInfo() async {
    try {
      if(await Permission.locationWhenInUse.request().isGranted) {
        final info = network_info_plus.NetworkInfo();
        final ssid = await info.getWifiName();
        final bssid = await info.getWifiBSSID();
        final ip = await info.getWifiIP();
        final ipv6 = await info.getWifiIPv6();

        return NetworkInfo(ssid: ssid, bssid: bssid, ip: ip, ipv6: ipv6);
      }
    } catch (error) {
      print("error during get network info >>> $error");
    }
    return const NetworkInfo();
  }

  Future<bool> connectNetwork({required String ssid, String? password, NetworkSecurity security = NetworkSecurity.WPA}) async {
    try {
      if(await Permission.location.request().isGranted) {
        final value = await WiFiForIoTPlugin.connect(ssid, 
          password: password, security: security, joinOnce: true, withInternet: true);

        if(value) {
          state = await AsyncValue.guard(() async => await getNetworkInfo());
        }
        return value;
      }
    } catch (error) {
      print("error during connect network >>> $error");
    }
    return false;
  }

}