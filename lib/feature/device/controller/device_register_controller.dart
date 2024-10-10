import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:bluetooth_low_energy/bluetooth_low_energy.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../auth/controller/user_controller.dart';

part 'device_register_controller.g.dart';



final registerDataProvider = StateProvider<Map<String, String>>((ref) => {'timeZone': '', 'ssid': '', 'security': '', 'password': ''});
final selectDeviceBluetoothsProvider = StateProvider<List<DiscoveredEventArgs>>((ref) => List.empty());

@riverpod
class AccessibleDeviceBluetooths extends _$AccessibleDeviceBluetooths {

  late CentralManager _manager;

  @override
  List<DiscoveredEventArgs> build() {
    ref.onDispose(() async {
      await _manager.stopDiscovery();
    });
    _manager = CentralManager();
    initialize();
    return List.empty();
  }

  void initialize() async {
    var permissionState = Platform.isIOS ? 
      await Permission.locationWhenInUse.request().isGranted : 
      (await Permission.locationWhenInUse.request().isGranted && 
        await Permission.bluetoothScan.request().isGranted && 
          await Permission.bluetoothConnect.request().isGranted);

    if(permissionState) {
      await _manager.startDiscovery();
      _manager.discovered.listen((result) {
        if(result.advertisement.name != null && checkDeviceID(result.advertisement.name!)) {
          final peripheral = result.peripheral;
          final index = state.indexWhere((element) => element.peripheral == peripheral);
          if(index != -1) {
            state.remove(result);
            state = [...state];
          } else {
            state = [...state, result];
          }
        }
      });
    }
  }

  bool checkDeviceID(String deviceId) {
    RegExp regExp = RegExp(RegExp.escape(ref.watch(userControllerProvider)!.enterprise) + r'-\d{6}');
    if(regExp.hasMatch(deviceId)) return true;
    return false;
  }

}