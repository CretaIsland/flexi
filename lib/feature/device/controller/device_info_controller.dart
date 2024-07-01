import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/device_info.dart';

part 'device_info_controller.g.dart';



@riverpod 
class DeviceInfoController extends _$DeviceInfoController {

  DeviceInfo? build() {
    ref.onDispose(() {
      print('DeviceInfoController Dispose!!!');
    });
    print('DeviceInfoController Build!!!');
    return null;
  }

  void setDevice(DeviceInfo device) {
    state = device;
  }

  void setName(String name) {
    state = state!.copyWith(deviceName: name);
  }

  void setVolume(int volume) {
    state = state!.copyWith(volume: volume);
  }

  void registerBluetooth(String deviceName, String remoteId) {
    state = state!.copyWith(
      bluetoothBonded: true,
      bluetooth: deviceName,
      bluetoothId: remoteId
    );
  }

  void unregisterBluetooth(String deviceName, String remoteId) {
    state = state!.copyWith(
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
    print('error at bluetoothState >>> $error');
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
    print('error at bondedBluetooths >>> $error');
  }
  return List.empty();
}

@riverpod
Future<Stream<List<Map<String, String>>>> accessibleBluetooths(AccessibleBluetoothsRef ref) async {
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
    print('error at accessibilityBluetooths >>> $error');
  }
  return const Stream.empty();
}