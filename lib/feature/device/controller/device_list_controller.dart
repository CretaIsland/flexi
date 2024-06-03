import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/device_info.dart';
part 'device_list_controller.g.dart';



final selectModeProvider = StateProvider<bool>((ref) => false);
final selectAllProvider = StateProvider<bool>((ref) => false);
final selectDevicesProvider = StateProvider<List<String>>((ref) => List.empty());


@riverpod
class UDPBroadcast extends _$UDPBroadcast {

  late RawDatagramSocket _socket;


  @override
  List<DeviceInfo> build() {
    ref.onDispose(() {
      print("<<<<<<< UDPBroadcastProvider dispose <<<<<<<");
    });
    print(">>>>>>> UDPBroadcastProvider build >>>>>>");
    _initialize();
    return List.empty();
  }

  Future<void> _initialize() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 8888);

    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if(d == null) return;
      String message = String.fromCharCodes(d.data).trim();
      DeviceInfo newDevice = DeviceInfo.fromJson(jsonDecode(message));
      var sameDevice = state.indexWhere((device) => device.deviceId == newDevice.deviceId);
      if(sameDevice != -1 && state[sameDevice] == newDevice) {
        state.removeAt(sameDevice);
        state = [...state, newDevice];
      }
      if(sameDevice == -1) {
        state = [...state, newDevice];
      }
    });
  }

  void sendData(String targetIP, String data) {
    _socket.broadcastEnabled = true;
    _socket.send(data.codeUnits, InternetAddress(targetIP), 8888);
  }

}