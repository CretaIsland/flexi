import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

part 'bluetooth_provider.g.dart';



@riverpod
Stream<bool> bluetoothState(BluetoothStateRef ref) {
  try {
    return FlutterBluePlus.adapterState.map((event) => event == BluetoothAdapterState.on);
  } catch (error) {
    print('Error at bluetoothStateProvider >>> $error');
  }
  return const Stream.empty();
}

@riverpod
Future<List<Map<String, String>>> bondedBluetooths(BondedBluetoothsRef ref) async {
  try {
    List<BluetoothDevice> result = await FlutterBluePlus.bondedDevices;
    return result.where((element) => element.advName.isNotEmpty || element.platformName.isNotEmpty).map((e) {
      return {
        'name': e.advName.isNotEmpty ? e.advName : e.platformName,
        'remoteId': e.remoteId.str
      };
    }).toList();
  } catch (error) {
    print('Error at bondedBluetoothsProvider >>> $error');
  }
  return List.empty();
}

@riverpod
Future<Stream<List<Map<String, String>>>> accessibleBluetooths(AccessibleBluetoothsRef ref) async {
  try {
    await FlutterBluePlus.startScan();
    return FlutterBluePlus.onScanResults.map((result) {
      return result.where((element) => element.device.advName.isNotEmpty || element.device.platformName.isNotEmpty).map((e) {
        return {
          'name': e.device.advName.isNotEmpty ? e.device.advName : e.device.platformName,
          'remoteId': e.device.remoteId.str
        };
      }).toList();
    });
  } catch (error) {
    print('Error at accessibleBluetoothsProvider >>> $error');
  }
  return const Stream.empty();
}