import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:network_info_plus/network_info_plus.dart' as network_info_plus;
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../feature/content/model/content_info.dart';
import '../../feature/device/model/network_info.dart';

part 'network_providers.g.dart';



@riverpod
class UDPBroadcast extends _$UDPBroadcast {
  late RawDatagramSocket socket;
  late StreamController<String> controller;
  String? _other;
  String? _wifiBroadcast;
  InternetAddress? myIp;

  get other => _other;

  @override
  Stream<String> build() {
    ref.onDispose(() {
      print('uDPBroadcastProvider dispose');
      socket.close();
      controller.close();
    });
    print('uDPBroadcastProvider');
    controller = StreamController<String>();
    _init();
    return controller.stream;
  }

  Future<void> _init() async {
    myIp = await ref.watch(ipProvider.future);
    _wifiBroadcast = ref.watch(networkInfoProvider).value?.broadcast;

    socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 4546);
    socket.broadcastEnabled = true;

    socket.listen((event) {
      Datagram? d = socket.receive();
      if (d == null) return;

      _other = d.address.host;

      print('_other:$_other');
      print('myIp:${myIp?.address}');

      //자기 자신은 자기 가 보낸 메시지 수신 하지 않기(이니면 디버깅 곤란)
      if (_other != myIp?.address) {
      //보낸 아이피 여기서 socketIO 서버 아이피를 안다.
      print('보낸 아이피 $_other');
      print('소켓 아이오 서버 : $_other');

      String message = utf8.decode(d.data);
      controller.add(message);
    }
  });
 }

  void sendData(String data) async {
    //한글 되게 uint8
    List<int> sendData = utf8.encode(data);

    //iOS는 나가는게 안되는데 wifiBroadcast주소에 보내면 된다.
    // iOS wifiBroadcast
    if (Platform.isIOS) {
      //ios
      _other = _wifiBroadcast;
      print("send _wifiBroadcast $_other");
      socket.send(
      sendData, InternetAddress('$_other'), 4546);
    } else {
      print("send 255.255.255.255");
      socket.send(sendData, InternetAddress('255.255.255.255'), 4546);
    }
  }
}

@riverpod
Future<InternetAddress?> ip(IpRef ref) async {
  print('ipProvider');
  InternetAddress? internetAddress;
  try {
    List<NetworkInterface> interfaces = await NetworkInterface.list(includeLoopback: false, type: InternetAddressType.IPv4);
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

@riverpod
Future<NetworkInfo?> networkInfo(NetworkInfoRef ref) async {
  try {
    print('networkInfoProvider');
    if (await Permission.locationWhenInUse.request().isGranted) {
      final info = network_info_plus.NetworkInfo();
      final wifiName = await info.getWifiName();
      final wifiBSSID = await info.getWifiBSSID();
      final wifiIP = await info.getWifiIP();
      final wifiIPv6 = await info.getWifiIPv6();
      final wifiBroadcast = await info.getWifiBroadcast();
      return NetworkInfo(
        ssid: wifiName,
        bssid: wifiBSSID,
        ip: wifiIP,
        ipv6: wifiIPv6,
        broadcast: wifiBroadcast,
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

@riverpod
class SocketIOClient extends _$SocketIOClient {
  late StreamController<String> _controller;
  late IO.Socket _socketIO;

  @override
  Stream<String> build({
    required String ip,
    required int port,
  }) {
    print('socketIOClientProvider build ip:$ip');
    ref.onDispose(() {
      print('socketIOClientProvider dispose');

      _socketIO.close();
      _socketIO.disconnect();
      _socketIO.dispose();

      _controller.close();
    });

    connectServer(ip: ip, port: port);

    return _controller.stream;
  }

  void connectServer({
    required String ip,
    required int port,
  }) {
    _socketIO = IO.io(
      'http://$ip:$port',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    _controller = StreamController<String>();
    _socketIO.onConnect((data) {
      print('onConnect $data');
    });
    _socketIO.onDisconnect((data) {
      print('onDisconnect $data');
    });
    _socketIO.on('message', (data) {
      List<dynamic> d = List.from(data);
      List<int> byteArray = d.map((e) => e as int).toList();
      final receivedData = utf8.decode(byteArray);
      print('message from server:$receivedData');
      _controller.add(receivedData);
    });
    _socketIO.connect();
  }

  void sendData(String data) {
    print('SocketIOClientNotifier sendData:$data');
    _socketIO.emit('message', utf8.encode(data));
  }

  void sendFile({required String deviceId, required File file, required String fileName, required ContentInfo contentInfo}) async {
    _socketIO.emit('fileStart', utf8.encode(fileName));
    int total = await file.length();
    int count = 0;
    var openRead = file.openRead();
    openRead.listen(
      (bytes) {
        count += bytes.length;
        _socketIO.emitWithBinary('file', bytes);
        print('$count/$total');
      },
      onDone: () {
        _socketIO.emit('fileDone');
        //파일 보내고 컨텐츠 정보 보내기
        Map<String, dynamic> contentInfoJson = contentInfo.toJson();
        contentInfoJson.addAll({"command": "playerContent", "deviceId": deviceId});
        contentInfoJson.remove('textSizeType');
        contentInfoJson.remove('filePath');
        contentInfoJson.remove('fileThumbnail');
        String sendData = jsonEncode(contentInfoJson);
        _socketIO.emit('message', utf8.encode(sendData));
      },
    );
  }
}