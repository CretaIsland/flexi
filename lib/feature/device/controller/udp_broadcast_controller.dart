import 'dart:async';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'udp_broadcast_controller.g.dart';



@riverpod
class UDPBroadcastController extends _$UDPBroadcastController {

  late RawDatagramSocket _socket;
  late StreamController<String> _streamController;
  late List<String> _dataList;


  @override
  List<String> build() {
    ref.onDispose(() {
      print(">>>>> uDPBroadcastController dispose >>>>>");
      _streamController.close();
      _dataList.clear();
    });
    print("<<<<< uDPBroadcastController init <<<<<");
    _streamController = StreamController<String>();
    _dataList = [];
    _initialize();
    return _dataList;
  }

  Future<void> _initialize() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 8888);

    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if(d == null) return;
      String message = String.fromCharCodes(d.data).trim();
      _dataList.add(message);
      _streamController.add(message);
    });
  }

  void sendData(String targetIP, String data) {
    _socket.broadcastEnabled = true;
    _socket.send(data.codeUnits, InternetAddress("255.255.255.255"), 8888);
  }

}