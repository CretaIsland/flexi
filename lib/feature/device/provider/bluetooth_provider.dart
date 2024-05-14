import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/bluetooth_info.dart';

part 'bluetooth_provider.g.dart';



// 접속 가능한 주변 블루투스 목록 조회
@riverpod
Future<Stream<List<BluetoothInfo>>> bluetoothStream(BluetoothStreamRef ref) async {
  ref.onDispose(() {
    print("<<<<<<< bluetoothStreamProvider dispose <<<<<<<");
    FlutterBluePlus.stopScan();
  });
  print(">>>>>>> bluetoothStreamProvider build >>>>>>");
  try {
    await FlutterBluePlus.startScan();
    return FlutterBluePlus.onScanResults.map((event) {
      return event.where((element) => element.device.advName.isNotEmpty).map((e) {
        return BluetoothInfo(
          name: e.device.advName,
          remoteId: e.device.remoteId.str
        );
      }).toList();
    });
  } catch (error) {
    print("error during scan bluetooth >>> $error");
  }
  return const Stream.empty();
}


// 이 전에 페어링한 이력이 있는 블루투스 목록 조회
@riverpod
Future<List<BluetoothInfo>> bondedBluetooths(BondedBluetoothsRef ref) async {
  ref.onDispose(() {
    print("<<<<<<< bondedBluetoothsProvider dispose <<<<<<<");
  });
  print(">>>>>>> bondedBluetoothsProvider build >>>>>>");
  try {
    List<BluetoothDevice> results = await FlutterBluePlus.bondedDevices;
    return results.where((element) => 
      element.platformName.isNotEmpty).map((e) => 
        BluetoothInfo(name: e.platformName, remoteId: e.remoteId.str)
      ).toList();
  } catch (error) {
    print("error during scan bonded bluetooth >>> $error");
  }
  return List.empty();
}