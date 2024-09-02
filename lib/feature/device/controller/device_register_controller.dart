import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bluetooth_low_energy/bluetooth_low_energy.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../../../core/constants/config.dart';
import '../../../util/utils.dart';
import '../../setting/controller/user_controller.dart';
import '../model/device_model.dart';

part 'device_register_controller.g.dart';



final selectHotspotsProvider = StateProvider<List<String>>((ref) => List.empty());
final selectBluetoothsProvider = StateProvider<List<DiscoveredEventArgs>>((ref) => List.empty());

@riverpod
class RegisterDataController extends _$RegisterDataController {

  Map<String, String> build() {
    ref.onDispose(() {
      print('RegisterDataController Dispose');
    });
    print('RegisterDataController Build');
    return {
      'timeZone': '',
      'ssid': '',
      'security': '',
      'password': ''
    };
  }

  void setTimezone(String timeZone) {
    state = {
      'timeZone': timeZone,
      'ssid': state['ssid']!,
      'security': state['security']!,
      'password': state['password']!
    };
  }

  void setNetwork(String ssid, String security, String password) {
    state = {
      'timeZone': state['timeZone']!,
      'ssid': ssid,
      'security': security,
      'password': password
    };
  }

}

@riverpod
List<Map<String, String>> timezones(TimezonesRef ref) {
  initializeTimeZones();
  RegExp utcRegExp = RegExp(r'[a-zA-Z]');

  return timeZoneDatabase.locations.values.map((item) {
    TimeZone timezone = item.timeZone(DateTime.now().millisecondsSinceEpoch);
    Duration duration = Duration(milliseconds: timezone.offset);
    String abbreviation = utcRegExp.hasMatch(timezone.abbreviation) ? timezone.abbreviation : 'UTC';
    String timeDifference = '${duration.inHours >= 0 ? '+' : ''}${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}';

    return {
      'label': '${item.name} ($abbreviation $timeDifference)',
      'name': item.name
    };
  }).toList();
}

@riverpod
Future<Stream<List<String>>> accessibleDeviceHotspots(AccessibleDeviceHotspotsRef ref) async {
  try {
    if(await WiFiScan.instance.canStartScan(askPermissions: true) == CanStartScan.yes) {
      await WiFiScan.instance.startScan();
      return WiFiScan.instance.onScannedResultsAvailable.map((result) {
        return result.where((element) => element.ssid.isNotEmpty && FlexiUtils.deviceCheck(element.ssid, ref.watch(userControllerProvider)!.enterprise)).map((e) {
          return e.ssid;
        }).toList();
      });
    }
  } catch (error) {
    print('Error at AccessibleDeviceHotspotsProvider >>>$error');
  }
  return const Stream.empty();
}

@riverpod
class AccessibleDeviceBluetooths extends _$AccessibleDeviceBluetooths {

  late CentralManager _centralManager;

  @override
  List<DiscoveredEventArgs> build() {
    ref.onDispose(() {
      print('dispose');
      _centralManager.stopDiscovery();
    });
    _centralManager = CentralManager();
    initialize();
    return List.empty();
  }

  void initialize() async {
    if(await Permission.locationWhenInUse.request().isGranted && await Permission.bluetoothScan.request().isGranted && await Permission.bluetoothConnect.request().isGranted) {
      await _centralManager.startDiscovery();
      _centralManager.discovered.listen((result) {
        if(result.advertisement.name != null && FlexiUtils.deviceCheck(result.advertisement.name!, ref.watch(userControllerProvider)!.enterprise)) {
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

}

@riverpod
class NetworkController extends _$NetworkController {

  void build() {
    ref.onDispose(() {
      print('NetworkController Dispose');
    });
    print('NetworkController Build');
  }

  Future<bool> wifiConnected() async {
    try {
      var result = await Connectivity().checkConnectivity();
      return result.contains(ConnectivityResult.wifi);
    } catch (error) {
      print('Error at NetworkController.wifiConnected >>> $error');
    }
    return false;
  }

  Future<String?> getSsid() async {
    try {
      if(await Permission.location.request().isGranted) {
        var ssid = await NetworkInfo().getWifiName();
        if(ssid != null) return ssid.replaceAll('"', '');
      }
    } catch (error) {
      print('Error at NetworkController.getSsid >>> $error');
    }
    return null;
  }

  Future<bool> connect({required String ssid, String security = '', String? password}) async {
    try {
      if(await Permission.location.request().isGranted) {
        var networkSecurity = security.contains('WPA') ? NetworkSecurity.WPA : security.contains('WEP') ? NetworkSecurity.WEP : NetworkSecurity.NONE;
        await WiFiForIoTPlugin.connect(ssid, password: password, security: networkSecurity, joinOnce: true, withInternet: true, timeoutInSeconds: 15);
        var connectedSsid = await getSsid();
        if(connectedSsid != null && connectedSsid == ssid) return true;
      }
    } catch (error) {
      print('Error at NetworkController.connect >>> $error');
    }
    return false;
  }

}

@riverpod 
class DeviceIPController extends _$DeviceIPController {

  late RawDatagramSocket _socket;

  @override
  void build() async {
    ref.onDispose(() {
      print('DeviceIPController Dispose');
      _socket.close();
    });
    print('DeviceIPController Build');
  }

  Future<DeviceModel?> getDeviceStatus() async {
    final completer = Completer<DeviceModel?>();
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, NetworkConfig.udpBroadcastPort);
    _socket.broadcastEnabled = true;

    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if(d == null) return;

      Map<String, dynamic> data = jsonDecode(utf8.decode(d.data));
      if(data['command'] != 'playerStatus') return;

      _socket.close();
      completer.complete(DeviceModel.fromJson(data));
    });

    sendData();
    return completer.future.timeout(
      const Duration(seconds: 15), 
      onTimeout: () {
        _socket.close();
        return null;
      }
    );
  }

  void sendData() async {
    final info = NetworkInfo();
    final broadcast = await info.getWifiBroadcast();
    if(broadcast != null) {
      _socket.send(utf8.encode(jsonEncode({'command': 'test'})), InternetAddress(broadcast), NetworkConfig.udpBroadcastPort);
    }
  }

}