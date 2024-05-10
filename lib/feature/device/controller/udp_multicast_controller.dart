import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:async';
import 'dart:io';

import '../../../common/constants/config.dart';

part 'udp_multicast_controller.g.dart';



@riverpod
class UDPMulticastController extends _$UDPMulticastController {

  late RawDatagramSocket _socket;
  late StreamController<List<String>> _controller;

  @override
  Stream<List<String>> build() {
    ref.onDispose(() {
      _socket.leaveMulticast(Config.udpMulticastAddress);
      _socket.close();

      _controller.close();
    });
    _controller = StreamController<List<String>>();

    _init();

    return _controller.stream;
  }

  Future<void> _init() async {
    _socket = await RawDatagramSocket.bind(
        InternetAddress.anyIPv4, Config.udpMulticastPort);

    _socket.joinMulticast(Config.udpMulticastAddress);

    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if (d == null) return;
      String message = String.fromCharCodes(d.data).trim();
      _controller.add([message]);
    });
  }


}