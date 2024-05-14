import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:async';
import 'dart:io';

import '../../../common/constants/config.dart';

part 'udp_multicast_controller.g.dart';



@riverpod
class UDPMulticastController extends _$UDPMulticastController {

  late RawDatagramSocket _socket;
  late StreamController<String> _streamController;

  @override
  List<String> build() {
    ref.onDispose(() {
      print("<<<<<<< UDPMulticastController dispose <<<<<<<");
      _socket.leaveMulticast(Config.udpMulticastAddress);
      _socket.close();
      _streamController.close();
    });
    print(">>>>>>> UDPMulticastController build >>>>>>");
    _streamController = StreamController<String>();
    _initialize();
    return List.empty();
  }

  Future<void> _initialize() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, Config.udpMulticastPort);
    _socket.joinMulticast(Config.udpMulticastAddress);

    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if(d == null) return;
      String message = String.fromCharCodes(d.data).trim();
      state = [...state, message];
      _streamController.add(message);
    });
  }


}