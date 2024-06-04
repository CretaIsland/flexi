import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/device_info.dart';

part 'device_list_controller.g.dart';



final selectModeProvider = StateProvider<bool>((ref) => false);
final selectAllProvider = StateProvider<bool>((ref) => false);
final selectDevicesProvider = StateProvider<List<int>>((ref) => List.empty());


@riverpod
class DeviceListController extends _$DeviceListController {

  late RawDatagramSocket _socket;


  @override
  List<DeviceInfo> build() {
    initialize();
    return List.empty();
  }

  Future<void> initialize() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 8888);
    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if(d == null) return;

      String dataStr = String.fromCharCodes(d.data).trim();
      Map<String, dynamic> dataJson = jsonDecode(dataStr);
      if(dataJson.keys.first == 'playerStatus') {
        DeviceInfo newDeviceInfo = DeviceInfo.fromJson(dataJson.values.first);
      }
    });
  }

  Future<void> unRegister() async {

  }

}