import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:socket_io_client/socket_io_client.dart'
    as IO; //socket io client
import 'package:socket_io/socket_io.dart' as socketIOServer; //socket io server

import '../constants/config.dart';

part 'providers.freezed.dart';
part 'providers.g.dart';

// ** 인터넷 연결 상태 가져오기
// 안드로이드 <uses-permission android:name="android.permission.INTERNET" />
// iOS <key>com.apple.security.network.client</key><true/>
// wifi도 꺼지고 통신사 셀룰러도 안되면 false
@riverpod
Stream<InternetStatus> internetConnection(InternetConnectionRef ref) {
  developer.log('internetConnectionProvider');
  return InternetConnection().onStatusChange;
}

// ** 네트워크 변화 감지 (Wifi <=> Hotspot)
@riverpod
Stream<List<ConnectivityResult>> networkChange(NetworkChangeRef ref) {
  developer.log('networkChangeProvider');
  return Connectivity().onConnectivityChanged;
}

// ** 아이피 정보 가져오기
@riverpod
Future<InternetAddress?> ip(IpRef ref) async {
  developer.log('ipProvider');
  InternetAddress? internetAddress;
  try {
    // 네트워크 인터페이스 정보 가져오기
    List<NetworkInterface> interfaces = await NetworkInterface.list(
        includeLoopback: false, type: InternetAddressType.IPv4);

    //안드로이드 [wlan0], iOS [pdp_ip0, ipsec0, en0, ipsec2, ipsec3]
    //안드로이드 wlan0, iOS en0
    for (var interface in interfaces) {
      //print(interface.name);
      //print(interface.addresses);

      if (Platform.isAndroid) {
        if (interface.name.contains('wlan')) {
          for (var address in interface.addresses) {
            internetAddress = address;
          }
        }
      }
      if (Platform.isIOS) {
        if (interface.name.contains('en')) {
          for (var address in interface.addresses) {
            internetAddress = address;
          }
        }
      }
    }
  } catch (e) {
    print('Error getting IP address: $e');
  }
  return internetAddress;
}

// ** 네트워크 정보 가져오기
/*
권한 필요  위치 정보 액세스 권한 팝업
--안드로이드
ACCESS_FINE_LOCATION 안드로이드 10 이상
ACCESS_COARSE_LOCATION, ACCESS_FINE_LOCATION 안드로이드 10 미만
ACCESS_NETWORK_STATE 안드로이드 12 이상
--iOS
Info.plist
NSLocationWhenInUseUsageDescription
Podfile
'PERMISSION_LOCATION=1',
Xcode Signing & Capabilities에서 Access Wi-Fi Information 추가
*/
@riverpod
Future<
    ({
      String? wifiName,
      String? wifiBSSID,
      String? wifiIP,
      String? wifiIPv6,
      String? wifiSubmask,
      String? wifiBroadcast,
      String? wifiGateway,
    })?> networkInfo(NetworkInfoRef ref) async {
  try {
    developer.log('networkInfoProvider');
    if (await Permission.locationWhenInUse.request().isGranted) {
      final info = NetworkInfo();
      final wifiName = await info.getWifiName();
      final wifiBSSID = await info.getWifiBSSID();
      final wifiIP = await info.getWifiIP();
      final wifiIPv6 = await info.getWifiIPv6();
      final wifiSubmask = await info.getWifiSubmask();
      final wifiBroadcast = await info.getWifiBroadcast();
      final wifiGateway = await info.getWifiGatewayIP();
      //print('network info wifiName:$wifiName');
      //print('network info wifiBSSID:$wifiBSSID');
      //print('network info wifiIP:$wifiIP');
      //print('network info wifiIPv6:$wifiIPv6');
      //print('network info wifiSubmask:$wifiSubmask');
      //print('network info wifiBroadcast:$wifiBroadcast');
      //print('network info wifiGateway:$wifiGateway');
      return (
        wifiName: wifiName,
        wifiBSSID: wifiBSSID,
        wifiIP: wifiIP,
        wifiIPv6: wifiIPv6,
        wifiSubmask: wifiSubmask,
        wifiBroadcast: wifiBroadcast,
        wifiGateway: wifiGateway
      );
    } else {
      print('Unauthorized to get NetworkInfo');
      return null;
    }
  } on PlatformException catch (e) {
    print('error :$e');
    return null;
  }
}

// ** 주변 access 가능한 wifi ssid 목록 가져오기
// 안드로이드만 가능 (iOS ??)
// duplicated error 뜨면 https://velog.io/@mraz3068/Duplicate-class-kotlin.collections.jdk8.CollectionsJDK8Kt-found-in-modules-kotlin-stdlib-1.8.0-org.jetbrains.kotlinkotlin-stdlib1.8.0-and-kotlin-stdlib-jdk8-1.7.20-org.jetbrains.kotlinkotlin-stdlib-jdk81.7.20
@riverpod
Future<List<WifiNetworkInfo>> wifis(WifisRef ref) async {
  developer.log('wifisProvider');
  try {
    final wifiNetworks = await WiFiForIoTPlugin.loadWifiList();
    return wifiNetworks
        .map((e) => WifiNetworkInfo(
            ssid: e.ssid,
            bssid: e.bssid,
            capabilities: e.capabilities,
            frequency: e.frequency,
            level: e.level,
            timestamp: e.timestamp,
            password: e.password))
        .toList();
  } catch (e) {
    print('error :$e');
    return [];
  }
}

// ** 주변 access 가능한 wifi ssid 목록 가져오기 스트림 (와이파이 상태가 계속 변한다.)
// 안드로이드만 가능 (iOS ??)
@riverpod
Stream<List<WifiNetworkInfo>> wifisStream(WifisStreamRef ref) {
  return WiFiForIoTPlugin.onWifiScanResultReady.map((event) => event
      .map((e) => WifiNetworkInfo(
          ssid: e.ssid,
          bssid: e.bssid,
          capabilities: e.capabilities,
          frequency: e.frequency,
          level: e.level,
          timestamp: e.timestamp,
          password: e.password))
      .toList());
}

@freezed
class WifiNetworkInfo with _$WifiNetworkInfo {
  const factory WifiNetworkInfo({
    String? ssid,
    String? bssid,
    String? capabilities,
    int? frequency,
    int? level,
    int? timestamp,
    String? password,
  }) = _WifiNetworkInfo;
}

@riverpod
class NetworkNotifier extends _$NetworkNotifier {
  @override
  void build() {
    developer.log('networkNotifierProvider');
  }

  Future<void> change({required String ssid, String? password}) async {
    developer.log('networkNotifierProvider change($ssid, $password)');
    try {
      if (await Permission.location.request().isGranted) {
        final value = await WiFiForIoTPlugin.connect(ssid,
            password: password, joinOnce: true, security: NetworkSecurity.WPA);
        developer.log('connected initiated $value');
      } else {
        developer.log('Unauthorized to get change wifi');
      }
    } on PlatformException catch (e) {
      developer.log('error :$e');
    }
  }
}

@riverpod
class UDPMulticast extends _$UDPMulticast {
  @override
  Stream<String> build() {
    ref.onDispose(() {
      developer.log('uDPMulticastProvider dispose');
      ref.invalidate(uDPMulticastNotifierProvider);
    });
    final notifier = ref.watch(uDPMulticastNotifierProvider.notifier);
    return notifier.controller.stream;
  }
}

@riverpod
class UDPMulticastNotifier extends _$UDPMulticastNotifier {
  late RawDatagramSocket socket;
  late StreamController<String> controller;
  @override
  FutureOr<void> build() async {
    ref.onDispose(() {
      developer.log('uDPMulticastNotifierProvider dispose');
      socket.leaveMulticast(Config.udpMulticastAddress);
      socket.close();

      controller.close();
    });

    controller = StreamController<String>();

    socket = await RawDatagramSocket.bind(
        InternetAddress.anyIPv4, Config.udpMulticastPort);

    socket.joinMulticast(Config.udpMulticastAddress);

    socket.listen((event) {
      Datagram? d = socket.receive();
      if (d == null) return;
      String message = String.fromCharCodes(d.data).trim();
      controller.add(message);
    });
  }

  void sendData(String data) {
    socket.send(
        data.codeUnits, Config.udpMulticastAddress, Config.udpMulticastPort);
  }
}

// ** SocketIO Client Stream
@riverpod
class SocketIOClient extends _$SocketIOClient {
  @override
  Stream<String> build() {
    developer.log('socketIOClientProvider build');
    ref.onDispose(() {
      developer.log('socketIOClientProvider dispose');
      ref.invalidate(socketIOClientNotifierProvider);
    });

    final notifier = ref.watch(socketIOClientNotifierProvider.notifier);

    return notifier.controller.stream;
  }
}

// ** SocketIO Client Notifier
@riverpod
class SocketIOClientNotifier extends _$SocketIOClientNotifier {
  late StreamController<String> controller;
  late IO.Socket socketIO;

  @override
  FutureOr<void> build() async {
    developer.log('socketIOClientNotifierProvider build');
    ref.onDispose(() {
      developer.log('socketIOClientNotifierProvider dispose');

      socketIO.close();

      controller.close();
    });

    socketIO = IO.io(
      'http://192.169.1.11:9999',
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );

    controller = StreamController<String>();
    socketIO.onConnect((data) {
      developer.log('onConnect $data');
      socketIO.emit('message', 'gogogogo');
    });
    socketIO.onDisconnect((data) {
      developer.log('onDisconnect $data');
    });
    socketIO.on('message', (data) {
      developer.log('message from server:$data');
      controller.add(data);
    });
  }

  void sendData(String data) {
    developer.log('SocketIOClientNotifier sendData:$data');
    socketIO.emit('message', data);
  }
}

// ** SocketIO Server Stream
@riverpod
class SocketIOServer extends _$SocketIOServer {
  @override
  Stream<String> build() {
    developer.log('socketIOServerProvider build');
    ref.onDispose(() {
      developer.log('socketIOServerProvider dispose');
      ref.invalidate(socketIOServerNotifierProvider);
    });

    final notifier = ref.watch(socketIOServerNotifierProvider.notifier);
    return notifier.controller.stream;
  }
}

// ** SocketIO Server Notifier
@riverpod
class SocketIOServerNotifier extends _$SocketIOServerNotifier {
  late StreamController<String> controller;
  late socketIOServer.Server server;

  @override
  FutureOr<void> build() async {
    developer.log('socketIOServerNotifierProvider build');
    ref.onDispose(() {
      developer.log('socketIOServerNotifierProvider dispose');

      server.close();

      controller.close();
    });

    controller = StreamController<String>();
    server = socketIOServer.Server();
    server.on('connection', (client) {
      developer.log('connection ${client.hashCode}');

      client.on('message', (data) {
        developer.log('message from client:$data');
        controller.add(data);
      });
      client.on('disconnect', (_) {
        developer.log('disconnect');
      });
    });
    developer.log('socketIOServer open port:${Config.socketIOPort}');
    server.listen(Config.socketIOPort);
  }

  void sendData(String data) {
    developer.log('SocketIOServerNotifier sendData:$data');
    server.emit('message', data);
  }
}