import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:async';
import 'dart:io';

import '../../../common/constants/config.dart';

part 'udp_multicast_controller.g.dart';



@riverpod
Stream<String> uDPMulticastStream(UDPMulticastStreamRef ref) {
  final uDPMulticastController = ref.read(uDPMulticastControllerProvider.notifier);
  return uDPMulticastController.udpMulticastStream();
}

@riverpod
List<String> uDPMulticastDatas(UDPMulticastDatasRef ref) {
  final uDPMulticastController = ref.read(uDPMulticastControllerProvider.notifier);
  return uDPMulticastController.dataList();
}


@riverpod
class UDPMulticastController extends _$UDPMulticastController {

  late RawDatagramSocket _socket;
  late StreamController<String> _streamController;
  late List<String> _dataList;

  Stream<String> udpMulticastStream() => _streamController.stream;
  List<String> dataList() => _dataList;

  @override
  void build() {
    ref.onDispose(() {
      print("<<<<<<< UDPMulticastController dispose <<<<<<<");
      _socket.leaveMulticast(Config.udpMulticastAddress);
      _socket.close();
    });
    print(">>>>>>> UDPMulticastController build >>>>>>");

    _streamController = StreamController<String>();
    _dataList = [];
    initialize();
  }

  Future<void> initialize() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, Config.udpMulticastPort);
    _socket.joinMulticast(Config.udpMulticastAddress);

    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if(d == null) return;
      String message = String.fromCharCodes(d.data).trim();
      _streamController.add(message);
      _dataList.add(message);
    });
  }

  void sendData(String data) {
    _socket.send(
        data.codeUnits, Config.udpMulticastAddress, Config.udpMulticastPort);
  }

}