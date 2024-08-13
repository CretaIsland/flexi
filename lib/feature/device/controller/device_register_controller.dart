import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bluetooth_low_energy/bluetooth_low_energy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../../../common/constants/config.dart';
import '../../setting/controller/auth_controller.dart';
import '../model/device_model.dart';

part 'device_register_controller.g.dart';



final selectTimezoneProvider = StateProvider<String>((ref) => '');
final registerNetworkProvider = StateProvider<Map<String, String>>((ref) => {'ssid': '', 'security': '', 'password': ''});
final selectDeviceHotspotsProvider = StateProvider<List<String>>((ref) => List.empty());
final selectDeviceBluetoothsProvider = StateProvider<List<DiscoveredEventArgs>>((ref) => List.empty());

@riverpod
List<Map<String, String>> timezones(TimezonesRef ref) {
  try {
    initializeTimeZones();
    RegExp alphabetsRegex = RegExp(r'[a-zA-Z]');
    
    return timeZoneDatabase.locations.values.toList().map((item) {
      TimeZone itemTimezone = item.timeZone(DateTime.now().millisecondsSinceEpoch);
      Duration duration = Duration(milliseconds: itemTimezone.offset);
      String itemAbbreviation = alphabetsRegex.hasMatch(itemTimezone.abbreviation) ? itemTimezone.abbreviation : 'UTC';
      String timezone = '${duration.inHours >= 0 ? '+' : ''}${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes.remainder(60)).toString().padLeft(2, '0')}';
      return {
        'name': '${item.name} ($itemAbbreviation $timezone)',
        'locationName': item.name
      };
    }).toList();
  } catch (error) {
    print('error at timezones >>> $error');
  }
  return List.empty();
}

@riverpod
Future<Stream<List<String>>> accessibleDeviceHotspots(AccessibleDeviceHotspotsRef ref) async {
  try {
    if(await WiFiScan.instance.canStartScan(askPermissions: true) == CanStartScan.yes) {
      await WiFiScan.instance.startScan();
      return WiFiScan.instance.onScannedResultsAvailable.map((event) {
        return event.where((element) => element.ssid.isNotEmpty && element.ssid.contains(ref.watch(authControllerProvider)!.enterprise)).map((e) {
          return e.ssid;
        }).toList();
      });
    }
  } catch (error) {
    print('error at AccessibleHotspotsProvider >>> $error');
  }
  return const Stream.empty();
}

@riverpod
class AccessibleDeviceBluetoothController extends _$AccessibleDeviceBluetoothController {

  late CentralManager _centeralManager;

  @override
  List<DiscoveredEventArgs> build() {
    ref.onDispose(() {
      print('AccessibleDeviceBluetoothController Dispose!!!');
      _centeralManager.stopDiscovery();
    });
    print('AccessibleDeviceBluetoothController Build!!!');
    _centeralManager = CentralManager();
    _centeralManager.startDiscovery().then((value) {
      _centeralManager.discovered.listen((event) {
        if(event.advertisement.name != null && event.advertisement.name!.contains(ref.watch(authControllerProvider)!.enterprise)) {
          final peripheral = event.peripheral;
          final index = state.indexWhere((i) => i.peripheral == peripheral);
          if (index < 0) {
            state = [...state, event];
          } else {
            state.remove(event);
            state = [...state];
          }
        }
      });
    });
    return List.empty();
  }

}

@riverpod
class NetworkController extends _$NetworkController {
  
  @override
  String build() {
    ref.onDispose(() {
      print('NetworkController Dispose!!!');
    });
    print('NetworkController Build!!!');
    return '';
  }

  Future<void> getNetworkInfo() async {
    try {
      if(await Permission.locationWhenInUse.request().isGranted) {
        final info = NetworkInfo();
        state = (await info.getWifiName()) ?? '';
      }
    } catch (error) {
      print('error at NetworkController.getNetworkInfo >>> $error');
    }
  }

  Future<bool> connect({required String ssid, String? passphrase, NetworkSecurity security = NetworkSecurity.WPA}) async {
    try {
      if(await Permission.location.request().isGranted) {
        await WiFiForIoTPlugin.connect(ssid, password: passphrase, security: security, joinOnce: true, withInternet: true, timeoutInSeconds: 20);
        await getNetworkInfo();
        print(state);
        if(state.replaceAll('"', '') == ssid) {
          return true;
        }
      }
    } catch (error) {
      print("error at NetworkController.connect >>> $error");
    }
    return false;
  }

}

@riverpod
class RegisterDeviceIPController extends _$RegisterDeviceIPController {

  late RawDatagramSocket _socket;

  @override
  Future<DeviceModel?> build() async {
    ref.onDispose(() {
      print('RegisterDeviceIPController Dispose!!!');
      _socket.close();
    });
    print('==================RegisterDeviceIPController Build!!!=========================');

    return await initialize();
  }

  Future<DeviceModel?> initialize() async {
    final completer = Completer<DeviceModel?>();
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, NetworkConfig.udpBroadcastPort);
    _socket.broadcastEnabled = true;

    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if(d == null) return;

      Map<String, dynamic> data = jsonDecode(utf8.decode(d.data));
      if(data['command'] != 'playerStatus') return;
      print(data);
      completer.complete(DeviceModel.fromJson(data));
    });

    sendData(jsonEncode({'command': 'test'}));

    Future.delayed(const Duration(seconds: 20), () {
      if(!completer.isCompleted) {
        completer.complete(null);
      }
    });
    return completer.future;
  }

  void sendData(String data) async {
    List<int> sendData = utf8.encode(data);
    final info = NetworkInfo();
    final wifiBroadcast = await info.getWifiBroadcast();
    print(wifiBroadcast);
    if(wifiBroadcast != null) {
      print(wifiBroadcast);
      _socket.send(sendData, InternetAddress(wifiBroadcast), 4546);
    }
  }

}

@riverpod 
class BleCentralControll extends _$BleCentralControll {

  late CentralManager _centeralManager;
  GATTCharacteristic? _canWirteCharacteristic;
  
  @override
  void build() {
    ref.onDispose(() {
      print('BleCentralControll Dispose!!!');
    });
    _centeralManager = CentralManager();
    print('BleCentralControll Build!!!');
  }

   Future<void> sendData(Peripheral peripheral, Map<String, String> data) async {
    await _centeralManager.connect(peripheral);
    await discoverGATT(peripheral);
    if(_canWirteCharacteristic != null) {
      await write(peripheral, utf8.encode(jsonEncode(data)), _canWirteCharacteristic!);
    }
    await disconnect(peripheral);
  }

  Future<void> discoverGATT(Peripheral peripheral) async {
    final services = await _centeralManager.discoverGATT(peripheral);
    final lastService = services[services.length - 1];
    for (int i = 0; i < lastService.characteristics.length; i++) {
      final characteristic = lastService.characteristics[i];
      if (characteristic.properties.contains(GATTCharacteristicProperty.write)) {
        _canWirteCharacteristic = characteristic;
      }
    }
  }

  Future<void> write(Peripheral peripheral, Uint8List value, GATTCharacteristic characteristic) async {
    const writeType = GATTCharacteristicWriteType.withResponse;
    final fragmentSize = await _centeralManager.getMaximumWriteLength(peripheral, type: writeType);

    var start = 0;
    while (start < value.length) {
      final end = start + fragmentSize;
      final fragmentedValue =
          end < value.length ? value.sublist(start, end) : value.sublist(start);
      const type = writeType;
      await _centeralManager.writeCharacteristic(
        peripheral,
        characteristic,
        value: fragmentedValue,
        type: type,
      );
      start = end;
    }
  }

  Future<void> disconnect(Peripheral peripheral) async {
    await _centeralManager.disconnect(peripheral);
  }

}