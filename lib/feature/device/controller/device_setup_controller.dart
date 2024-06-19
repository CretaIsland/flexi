import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:network_info_plus/network_info_plus.dart' as network_info_plus;
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../../../common/constants/config.dart';
import '../../../common/providers/network_providers.dart';
import '../model/device_info.dart';
import '../model/network_info.dart';

part 'device_setup_controller.g.dart';



// 접속 가능한 주변 장비(hotspot) 목록 조회
@riverpod
Future<Stream<List<NetworkInfo>>> accessibilityNetworks(AccessibilityNetworksRef ref) async {
  ref.onDispose(() {
    print('<<<<< accessibilityNetworksProvider Dispose <<<<<');
  });
  print('<<<<< accessibilityNetworksProvider Build <<<<<');
  try {
    final can = await WiFiScan.instance.canStartScan(askPermissions: true);
    if(can == CanStartScan.yes) {
      await WiFiScan.instance.startScan();
      return WiFiScan.instance.onScannedResultsAvailable.map((results) {
        return results.where((element) => element.ssid.isNotEmpty).map((result) {
          return NetworkInfo(
            ssid: result.ssid,
            bssid: result.bssid
          );
        }).toList();
      });
    }
  } catch (error) {
    print('error at accessibilityNetworksProvider >>> $error');
  }
  return const Stream.empty();
}
final selectHotspotProvider = StateProvider<NetworkInfo?>((ref) => null);


// 네트워크 설정
@riverpod
class NetworkController extends _$NetworkController {
  @override
  String? build() {
    ref.onDispose(() {
      print('<<<<< NetworkController Dispose <<<<<');
    });
    print('<<<<< NetworkController Build <<<<<');
    getNetworkInfo();
    return null;
  }

  Future<void> getNetworkInfo() async {
    try {
      if(await Permission.locationWhenInUse.request().isGranted) {
        final info = network_info_plus.NetworkInfo();
        state = await info.getWifiName();
      }
    } catch (error) {
      print("error during get network info >>> $error");
    }
    state = null;
  }

  Future<bool> connect({required String ssid, String? password, NetworkSecurity security = NetworkSecurity.WPA}) async {
    try {
      if(await Permission.location.request().isGranted) {
        final value = await WiFiForIoTPlugin.connect(ssid, 
          password: password, security: security, joinOnce: true, withInternet: true);
        if(value) await getNetworkInfo();
        return value;
      }
    } catch (error) {
      print("error during connect network >>> $error");
    }
    return false;
  }

}


// 플레이어에 등록 할 WiFi Credentials 상태 관리
@riverpod
class WifiCredentialsController extends _$WifiCredentialsController {

  final List<String> _wifiEncryptionTypes = ['', 'OPEN', 'WPA', 'WEP'];
  late BarcodeScanner _barcodeScanner;


  @override
  Map<String, String> build() {
    ref.onDispose(() {
      print('<<<<< WifiCredentialsController Dispose <<<<<');
      _barcodeScanner.close();
    });
    print('<<<<< WifiCredentialsController Build <<<<<');
    _barcodeScanner = BarcodeScanner();
    return {'ssid': '', 'type': '', 'passphrase': ''};
  }


  // 이미지 파일로부터 wifi credentials 가져오기
  Future<bool> scanQrcodeImage(File file) async {
    try {
      var scanResults = await _barcodeScanner.processImage(InputImage.fromFile(file));
      for(var data in scanResults) {
        if(data.type == BarcodeType.wifi) {
          var wifiData = data.value as BarcodeWifi;
          state = {
            'ssid': wifiData.ssid ?? '',
            'type': wifiData.encryptionType == null ? _wifiEncryptionTypes[0] : _wifiEncryptionTypes[wifiData.encryptionType!],
            'passphrase': wifiData.password ?? ''
          };
          return true;
        }
      }
    } catch (error) {
      print('error at QRCodeController.scanFile >>> $error');
    }
    return false;
  }

  // QRCode rawValue(String)로부터 wifi credentials 가져오기
  bool scanQrcodeValue(String qrcodeValue) {
    try {
      Map<String, String> wifiCredentials = {'ssid': '', 'type': '', 'passphrase': ''};
      if(qrcodeValue.contains('WIFI')) {
        List<String> parts = qrcodeValue.split(';');
        for(var part in parts) {
          List<String> value = part.split(':');
          if(value.contains('S')) {
            wifiCredentials['ssid'] = value.last;
          } else if(value.contains('T')) {
            wifiCredentials['type'] = value.last;
          } else if(value.contains('P')) {
            wifiCredentials['passphrase'] = value.last;
          }
        }
        state = wifiCredentials;
        return true;
      }
    } catch (error) {
      print('error at QRCodeController.getWifiCredentials >>> $error');
    }
    return false;
  }

  // 텍스트 필드로부터 wifi credentials 가져오기
  void setWifiCredentials(String ssid, String type, String passphrase) {
    state = {
      'ssid': ssid,
      'type': type,
      'passphrase': passphrase
    };
  }

}

@riverpod 
class LocalStorageController extends _$LocalStorageController {

  int _pageIndex = 0;
  final int _pageCount = 20;
  late PermissionState _storagePermission;


  @override
  List<AssetEntity> build() {
    ref.onDispose(() {
      print('<<<<< LocalStorageController Dispose <<<<<');
    });
    print('<<<<< LocalStorageController Build <<<<<');
    initialize();
    return List.empty();
  }

  Future<void> initialize() async {
    _storagePermission = await PhotoManager.requestPermissionExtend();
    if(_storagePermission.isAuth) {
      state = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount);
      // _pageIndex++;
    }
  }

  Future<void> nextLoad() async {
    if(_storagePermission.isAuth) {
      var nextFiles = await PhotoManager.getAssetListPaged(page: _pageIndex, pageCount: _pageCount);
      state = [...state, ...nextFiles];
      _pageIndex++;
    }
  }

}





@riverpod
class RegisterDeviceInfo extends _$RegisterDeviceInfo{

  late RawDatagramSocket _socket;


  @override
  DeviceInfo? build() {
    ref.onDispose(() {
      print('RegisterDeviceInfo Dispose===================');
      _socket.close();
    });
    print('RegisterDeviceInfo build=======================');
    initialize();
    return null;
  }

  Future<void> initialize() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, Config.udpBroadcastPort);
    _socket.broadcastEnabled = true;

    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if(d == null) return;

      Map<String, dynamic> data = jsonDecode(utf8.decode(d.data));
      print(data);
      if(data['command'] == 'playerStatus') {
        data.remove('command');
        DeviceInfo newDevice = DeviceInfo.fromJson(data);
        print(newDevice.toJson());
        state = newDevice;
      }
    });
    
    sendData(jsonEncode({'command': 'test'}));
  }

  void sendData(String data) async {
    print('sendData');
    List<int> sendData = utf8.encode(data);
    // iOS wifiBroadcast
    if (Platform.isIOS) {
      final info = network_info_plus.NetworkInfo();
      final wifiBroadcast = await info.getWifiBroadcast();
      if(wifiBroadcast != null) {
        print(wifiBroadcast);
        _socket.send(sendData, InternetAddress(wifiBroadcast), 4546);
      }
    } else {
      print("send 255.255.255.255");
      _socket.send(sendData, InternetAddress('255.255.255.255'), 4546);
    }
  }


}