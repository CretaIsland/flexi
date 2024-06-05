import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../common/providers/network_providers.dart';
import '../model/bluetooth_info.dart';
import '../model/device_info.dart';

part 'device_info_controller.g.dart';



@riverpod
class DeviceInfoController extends _$DeviceInfoController {

  @override
  DeviceInfo build() {
    ref.onDispose(() {
      print('>>> DeviceInfoController dispose >>>');
    });
    print('<<< DeviceInfoController build <<<');
    return DeviceInfo();
  }


  void setDevice(DeviceInfo targetDevice) {
    state = targetDevice;
    print(targetDevice.ip);
  }

  void setDeviceName(String deviceName) {
    state = state.copyWith(deviceName: deviceName);
  }

  void setVolume(int volume) {
    state = state.copyWith(volume: volume);
  }

  Future<void> connectBluetooth(String bluetooth, String bluetoothId) async {
    state = state.copyWith(
      bluetooth: bluetooth,
      bluetoothId: bluetoothId,
      bluetoothBonded: true
    );
  }

  Future<void> disconnectBluetooth() async {
    state = state.copyWith(
      bluetooth: '',
      bluetoothId: '',
      bluetoothBonded: false
    );
  }

}


final connectedBluetoothInfoProvider = StateProvider<BluetoothInfo>((ref) => const BluetoothInfo());

@riverpod
class BluetoothStateController extends _$BluetoothStateController {

  late StreamController _streamController;

  @override
  bool build() {
    ref.onDispose(() {
      print('>>> DeviceInfoController dispose >>>');
      FlutterBluePlus.stopScan();
      _streamController.close();
    });
    print('<<< DeviceInfoController build <<<');
    _streamController = StreamController();
    if(Platform.isIOS) {
      FlutterBluePlus.adapterState.listen((event) {
        if(event == BluetoothAdapterState.on) {
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

  void turnOff() {
    state = false;
  }

}
