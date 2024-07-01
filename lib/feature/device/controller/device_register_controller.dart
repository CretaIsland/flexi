import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/browser.dart';
import 'package:timezone/data/latest.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../../../common/constants/config.dart';
import '../model/device_info.dart';

part 'device_register_controller.g.dart';



@riverpod 
Future<Stream<List<String>>> accessibleHotspots(AccessibleHotspotsRef ref) async {
  try {
    if(await WiFiScan.instance.canStartScan(askPermissions: true) == CanStartScan.yes) {
      await WiFiScan.instance.startScan();
      return WiFiScan.instance.onScannedResultsAvailable.map((event) {
        return event.where((element) => element.ssid.isNotEmpty).map((result) {
          return result.ssid;
        }).toList();
      });
    }
  } catch (error) {
    print('error at AccessibleHotspots >>> $error');
  }
  return const Stream.empty();
}

@riverpod 
class NetworkController extends _$NetworkController {

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
        if(state == ssid) {
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
        'label': '${item.name} ($itemAbbreviation $timezone)',
        'locationName': item.name
      };
    }).toList();
  } catch (error) {
    print('error at timezones >>> $error');
  }
  return List.empty();
}


@riverpod 
class RegisterDataController extends _$RegisterDataController {

  Map<String, String> build() {
    ref.onDispose(() {
      print('RegisterDataController Dispose!!!');
    });
    print('RegisterDataController Build!!!');
    return {'timeZone': '', 'ssid': '', 'security': '', 'password': ''};
  }

  void setTimezone(String timezone) {
    state['timeZone'] = timezone;
    state = state;
  }

  Future<bool> scanQrcodeImage(File image) async {
    try {
      List<String> wifiEncryptionTypes = ['', 'OPEN', 'WPA', 'WEP'];
      var barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.qrCode]);

      var result = await barcodeScanner.processImage(InputImage.fromFile(image));
      for(var data in result) {
        if(data.type == BarcodeType.wifi) {
          var wifiInfo = data.value as BarcodeWifi;
          setWifiCredential(
            wifiInfo.ssid ?? '', 
            wifiInfo.encryptionType == null ? wifiEncryptionTypes[0] : wifiEncryptionTypes[wifiInfo.encryptionType!],
            wifiInfo.password ?? ''
          );
          return true;
        }
      }
    } catch (error) {
      print('error at RegisterDataController.scanQrcodeImage >>> $error');
    }
    return false;
  }

  Future<bool> scanQrcodeValue(String qrcodeValue) async {
    try {
      if(qrcodeValue.contains('WIFI')) {
        List<String> parts = qrcodeValue.split(';');
        for(var part in parts) {
          List<String> value = part.split(':');
          if(value.contains('S')) {
            state['ssid'] = value.last;
          } else if(value.contains('T')) {
            state['security'] = value.last;
          } else if(value.contains('P')) {
            state['password'] = value.last;
          }
        }
        state = state;
        return true;
      }
    } catch (error) {
      print('error at WiFiCredentialController.scanQrcodeValue >>> $error');
    }
    return false;
  }

  void setWifiCredential(String ssid, String security, String password) {
    state['ssid'] = ssid;
    state['security'] = security;
    state['password'] = password;
    state = state;
  }

}

@riverpod 
class RegisterDeviceController extends _$RegisterDeviceController {

  late RawDatagramSocket _socket;


  @override
  Future<DeviceInfo?> build() async {
    ref.onDispose(() {
      print('RegisterDeviceController Dispose!!!');
      _socket.close();
    });
    print('RegisterDeviceController Build!!!');
    return await initialize();
  }

  Future<DeviceInfo?> initialize() async {
    final completer = Completer<DeviceInfo?>();
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, NetworkConfig.udpBroadcastPort);
    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if(d == null) return;

      Map<String, dynamic> data = jsonDecode(utf8.decode(d.data));
      if(data['command'] != 'playerStatus') return;

      completer.complete(DeviceInfo.fromJson(data));
    });

    Future.delayed(const Duration(seconds: 10), () {
      completer.complete(null);
    });
    return completer.future;
  }

}