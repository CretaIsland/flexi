import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../model/network_info.dart';

part 'network_provider.g.dart';



// 접속 가능한 주변 네트워크 목록 조회
@riverpod
Future<Stream<List<NetworkInfo>>> networkStream(NetworkStreamRef ref) async {
  ref.onDispose(() {
    print("<<<<<<< networkStreamProvider dispose <<<<<<<");
  });
  print(">>>>>>> networkStreamProvider build >>>>>>");
  try {
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

// 네트워크 변화 감지
// ** 네트워크 변화 감지 (Wifi <=> Hotspot)
@riverpod
Stream<List<ConnectivityResult>> networkChange(NetworkChangeRef ref) {
  ref.onDispose(() {
    print("<<<<<<< networkChangeProvider dispose <<<<<<<");
  });
  print(">>>>>>> networkChangeProvider build >>>>>>");
  return Connectivity().onConnectivityChanged;
}
