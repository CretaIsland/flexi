import 'dart:async';

import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:network_info_plus/network_info_plus.dart' as network_info_plus;
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../model/network_info.dart';

part 'network_controller.g.dart';



@riverpod
Future<Stream<List<NetworkInfo>>> networkStream(NetworkStreamRef ref) async {
  ref.onDispose(() {
    print("<<<<< networkStreamProvider dispose <<<<<");
  });
  try {
    print("<<<<< networkStreamProvider init <<<<<");
    await WiFiScan.instance.startScan();
    return WiFiScan.instance.onScannedResultsAvailable.map((event) {
      return event.map((e) {
        return NetworkInfo(
          ssid: e.ssid,
          bssid: e.bssid
        );
      }).toList();
    });
  } catch (error) {
    print("error during scan network >>> $error");
  }
  return const Stream.empty();
}


@riverpod
NetworkInfo? currentNetworkInfo(CurrentNetworkInfoRef ref) {
  final networkController = ref.read(networkControllerProvider.notifier);
  return networkController.currentNetworkInfo();
}

@riverpod
class NetworkController extends _$NetworkController {

  NetworkInfo? _currentNetworkInfo;
  NetworkInfo? currentNetworkInfo() => _currentNetworkInfo;

  @override
  void build() {
    ref.onDispose(() {
      print("<<<<<<< NetworkController dispose <<<<<<<");
    });
    print(">>>>>>> NetworkController build >>>>>>");
  }

  Future<void> getNetworkInfo() async {
    try {
      if(await Permission.locationWhenInUse.request().isGranted) {
        final info = network_info_plus.NetworkInfo();
        final ssid = await info.getWifiName();
        final bssid = await info.getWifiBSSID();
        final ip = await info.getWifiIP();
        final ipv6 = await info.getWifiIPv6();

        NetworkInfo(ssid: ssid, bssid: bssid, ip: ip, ipv6: ipv6);
      }
    } catch (error) {
      print("error during get network info >>> $error");
    }
  }

  Future<bool> connectNetwork({required String ssid, String? password, NetworkSecurity security = NetworkSecurity.WPA}) async {
    try {
      print("connect network");
      if(await Permission.location.request().isGranted) {
        final value = await WiFiForIoTPlugin.connect(ssid, 
          password: password, security: security, joinOnce: true, withInternet: true);

        if(value) await getNetworkInfo();
        return value;
      }
    } catch (error) {
      print("error during connect network >>> $error");
    }
    return false;
  }

}