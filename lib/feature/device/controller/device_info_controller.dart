import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/device_model.dart';

part 'device_info_controller.g.dart';



@riverpod 
class DeviceInfoController extends _$DeviceInfoController {

  @override
  DeviceModel build() {
    ref.onDispose(() {
      print('DeviceInfoController Dispose!!!');
    });
    print('DeviceInfoController Build!!!');
    return DeviceModel();
  }

  void setDevice(DeviceModel device) {
    state = device;
  }

  void setName(String name) {
    state = state.copyWith(deviceName: name);
  }

  void setVolume(int volume) {
    state = state.copyWith(volume: volume);
  }

  void registerBluetooth(String deviceName, String remoteId) {
    state = state.copyWith(
      bluetoothBonded: true,
      bluetooth: deviceName,
      bluetoothId: remoteId
    );
  }

  void unregisterBluetooth() {
    state = state.copyWith(
      bluetoothBonded: false,
      bluetooth: '',
      bluetoothId: ''
    );
  }

}

@riverpod 
Stream<bool> bluetoothState(BluetoothStateRef ref) {
  try {
    return FlutterBluePlus.adapterState.map((event) => event == BluetoothAdapterState.on);
  } catch (error) {
    print('Error at BluetoothStateProvider >>> $error');
  }
  return const Stream.empty();
}

@riverpod
Future<List<Map<String, String>>> bondedBluetooths(BondedBluetoothsRef ref) async {
  try {
    List<BluetoothDevice> results = await FlutterBluePlus.bondedDevices;
    return results.where((element) => element.advName.isNotEmpty || element.platformName.isNotEmpty).map((e) {
      return {
        'name': e.advName.isNotEmpty ? e.advName : e.platformName,
        'remoteId': e.remoteId.str
      };
    }).toList();
  } catch (error) {
    print('Error at BondedBluetoothsProvider >>> $error');
  }
  return List.empty();
}

@riverpod
Future<Stream<List<Map<String, String>>>> accessibleBluetooths(AccessibleBluetoothsRef ref) async {
  ref.onDispose(() {
    FlutterBluePlus.stopScan();
  });
  try {
    await FlutterBluePlus.startScan();
    return FlutterBluePlus.onScanResults.map((results) {
      return results.where((element) => element.device.advName.isNotEmpty || element.device.platformName.isNotEmpty).map((e) {
        return {
          'name': e.device.advName.isNotEmpty ? e.device.advName : e.device.platformName,
          'remoteId': e.device.remoteId.str
        };
      }).toList();
    });
  } catch (error) {
    print('Error at AccessibilityBluetoothsProvider >>> $error');
  }
  return const Stream.empty();
}