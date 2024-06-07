import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/bluetooth_info.dart';
import '../model/device_info.dart';

part 'device_info_controller.g.dart';



@riverpod
class DeviceInfoController extends _$DeviceInfoController {

  @override
  DeviceInfo build() {
    ref.onDispose(() {
      print("<<<<<<< DeviceInfoController dispose <<<<<<<");
    });
    print("<<<<<<< DeviceInfoController build <<<<<<<");
    return DeviceInfo();
  }

  void setDevice(DeviceInfo targetDevice) {
    state = targetDevice;
  }

  void setName(String name) {
    state = state.copyWith(deviceName: name);
  }

  void setVolume(int volume) {
    state = state.copyWith();
  }

  void registerBluetooth(BluetoothInfo bluetooth) {
    state = state.copyWith(
      bluetooth: bluetooth.name ?? '',
      bluetoothId: bluetooth.remoteId ?? '',
      bluetoothBonded: true
    );
  }

  void unregisterBluetooth() {
    state = state.copyWith(
      bluetooth: '',
      bluetoothId: '',
      bluetoothBonded: false
    );
  }

}


// 현재 휴대폰의 블루투스 상태
@riverpod
class BluetoothStateController extends _$BluetoothStateController {

  @override
  bool build() {
    ref.onDispose(() {
      print("<<<<<<< BluetoothStateController dispose <<<<<<<");
    });
    print("<<<<<<< BluetoothStateController build <<<<<<<");
    if(Platform.isIOS) {
      FlutterBluePlus.adapterState.listen((value) {
        if(value == BluetoothAdapterState.on) {
          state = true;
        } else {
          state = false;
        }
      });
    } else {
      FlutterBluePlus.adapterState.first.then((value) {
        if(value == BluetoothAdapterState.on) state = true;
      });
    }
    return false;
  }

  Future<void> turnOn() async {
    if(Platform.isAndroid) await FlutterBluePlus.turnOn();
    state = true;
  }

  Future<void> turnOff() async {
    state = false;
  }

}

// 휴대폰과 이미 페어링된 기기 조회
@riverpod
Future<List<BluetoothInfo>> bondedBluetooths(BondedBluetoothsRef ref) async {
  ref.onDispose(() {
    print("<<<<<<< bondedBluetoothsProvider dispose <<<<<<<");
  });
  print("<<<<<<< bondedBluetoothsProvider build <<<<<<<");
  try {
    List<BluetoothDevice> results = await FlutterBluePlus.bondedDevices;
    return results.where((element) => element.advName.isNotEmpty || element.platformName.isNotEmpty).map((e) {
      return BluetoothInfo(
        name: e.advName.isNotEmpty ? e.advName : e.platformName,
        remoteId: e.remoteId.str
      );
    }).toList();
  } catch (error) {
    print('error at bondedBluetoothsProvider >>> $error');
  }
  return List.empty();
}


// 주변 연결 가능한 기기 조회
@riverpod
Future<Stream<List<BluetoothInfo>>> accessibleBluetooths(AccessibleBluetoothsRef ref) async {
  ref.onDispose(() {
    print("<<<<<<< accessibleBluetoothsProvider dispose <<<<<<<");
  });
  print("<<<<<<< accessibleBluetoothsProvider build <<<<<<<");
  try {
    await FlutterBluePlus.startScan();
    return FlutterBluePlus.onScanResults.map((results) {
      return results.where((element) => element.device.advName.isNotEmpty || element.device.platformName.isNotEmpty).map((e) {
        return BluetoothInfo(
          name: e.device.advName.isNotEmpty ? e.device.advName : e.device.platformName,
          remoteId: e.device.remoteId.str
        );
      }).toList();
    });
  } catch (error) {
    print('error at accessibleBluetoothsProvider >>> $error');
  }
  return const Stream.empty();
}