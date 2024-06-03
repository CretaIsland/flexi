import 'dart:io';

import 'package:network_info_plus/network_info_plus.dart' as network_info_plus;
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../../../common/model/network_info.dart';

part 'wifi_setup_controller.g.dart';



/* 플레이어에 등록 할 WiFi Credentials 상태 관리 */
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
    print('<<<<< WifiCredentialsController Dispose <<<<<');
    _barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.qrCode]);
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