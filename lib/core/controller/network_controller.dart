import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket;
import 'package:wifi_iot/wifi_iot.dart';
import '../constant/config.dart';

part 'network_controller.g.dart';



@riverpod
class NetworkController extends _$NetworkController {

  @override
  void build() {
    ref.onDispose(() {
      print('NetworkController Dispose');
    });
    print('NetworkController Build');
  }

  Future<String?> getSSID() async {
    try {
      if(await Permission.location.request().isGranted) {
        var ssid = await NetworkInfo().getWifiName();
        if(ssid != null) return ssid.replaceAll('"', '');
      }
    } catch (error) {
      print('Error at NetworkController.getSSID >>> $error');
    }
    return null;
  }

  Future<bool> connectWifi(String ssid, String security, String password) async {
    try {
      if(await Permission.location.request().isGranted) {
        var wifiSecurity = security.contains('WPA') ? NetworkSecurity.WPA :
          security.contains('WEP') ? NetworkSecurity.WEP :
          NetworkSecurity.NONE;
        
        var isConnected = await WiFiForIoTPlugin.connect(
          ssid,
          security: wifiSecurity,
          password: password,
          withInternet: true,
          timeoutInSeconds: 15
        );

        if(isConnected) return ssid == await getSSID();
      }
    } catch (error) {
      print('Error at NetworkController.connectWifi >>> $error');
    }
    return false;
  }

}

@riverpod
class SocketClientController extends _$SocketClientController {

  late socket.Socket _socket;

  @override
  void build() {
    ref.onDispose(() {
      print('SocketClientController Dispose');
      if(_socket.connected) _socket.disconnect();
      _socket.close();
      _socket.dispose();
    });
    print('SocketClientController Build');
    _socket = socket.io('', socket.OptionBuilder()
      .setTransports(['websocket'])
      .disableAutoConnect()
      .setTimeout(10000)
      .build()
    );
  }

  Future<bool> connect(String ip) async {
    try {
      String url = 'http://$ip:${NetworkConfig.socketIOPort}';
      if(_socket.io.uri == url && _socket.connected) return true;

      final completer = Completer<bool>();

      _socket.onConnect((event) {
        if(!completer.isCompleted) completer.complete(true);
      });
      _socket.onConnectError((event) {
        if(!completer.isCompleted) completer.complete(false);
      });

      _socket.io.uri = url;
      _socket.connect();
      return completer.future;
    } catch (error) {
      return false;
    }
  }

  Future<bool> disconnect() async {
    try {
      if(!_socket.connected) return true;

      final completer = Completer<bool>();

      _socket.onDisconnect((event) {
        if(!completer.isCompleted) completer.complete(true);
      });

      _socket.disconnect();
      return completer.future;
    } catch (error) {
      return false;
    }
  }

  Future<void> sendData(Map<String, dynamic> data) async {
    try {
      _socket.emit('message', utf8.encode(jsonEncode(data)));
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (error) {
      print('Error at SocketClientController.sendData >>> $error');
    }
  }

  Future<void> sendFile(String fileName, File file) async {
    try {
      final completer = Completer();
      _socket.emit('fileStart', utf8.encode(fileName));

      int total = await file.length();
      int count = 0;
      var openRead = file.openRead();

      openRead.listen((bytes) {
        count += bytes.length;
        _socket.emit('file', bytes);
        print('$count/$total');
      }, onDone: () {
        print('done');
        _socket.emit('fileDone');
        completer.complete();
      });

      await completer.future;
    } catch (error) {
      print('Error at SocketClientController.sendFile >>> $error');
    }
  }

}