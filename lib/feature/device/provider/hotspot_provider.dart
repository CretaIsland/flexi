import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../../../common/model/network_info.dart';

part 'hotspot_provider.g.dart';



// 접속 가능한 주변 네트워크 목록 조회
@riverpod
Future<Stream<List<NetworkInfo>>> accessibilityNetworks(AccessibilityNetworksRef ref) async {
  ref.onDispose(() {
    print("<<<<<<< accessibilityNetworksProvider dispose <<<<<<<");
  });
  print(">>>>>>> accessibilityNetworksProvider build >>>>>>");
  try {
    await WiFiScan.instance.startScan();
    return WiFiScan.instance.onScannedResultsAvailable.map((results) {
      return results.where((element) => element.ssid.isNotEmpty).map((result) {
        return NetworkInfo(
          ssid: result.ssid,
          bssid: result.bssid
        );
      }).toList();
    });
  } catch (error) {
    print('error at accessibilityNetworksProvider >>> $error');
  }
  return const Stream.empty();
}