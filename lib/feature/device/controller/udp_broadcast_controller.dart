import 'dart:async';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'udp_broadcast_controller.g.dart';



@riverpod
class UDPBroadcastController extends _$UDPBroadcastController {

  late RawDatagramSocket _socket;
  late StreamController<String> _streamController;


  @override
  List<String> build() {
    ref.onDispose(() {
      print("<<<<<<< UDPBroadcastController dispose <<<<<<<");
      _streamController.close();
    });
    print(">>>>>>> UDPBroadcastController build >>>>>>");
    _streamController = StreamController<String>();
    _initialize();
    return ["test 01"];
  }

  Future<void> _initialize() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 8888);

    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if(d == null) return;
      String message = String.fromCharCodes(d.data).trim();
      state = [...state, message];
      _streamController.add(message);
    });
  }

  void sendData(String targetIP, String data) {
    _socket.broadcastEnabled = true;
    _socket.send(data.codeUnits, InternetAddress("255.255.255.255"), 8888);
  }

}