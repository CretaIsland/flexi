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
    ref.onDispose(() {
      _socket.close();
    });
    initialize();
    return [];
  }

  Future<void> initialize() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 8888);
    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if(d == null) return;

      Map<String, dynamic> data = jsonDecode(utf8.decode(d.data));
      if(data['command'] == 'playerStatus') {
        data.remove('command');
        DeviceInfo newDevice = DeviceInfo.fromJson(data);
        var isExist = state.indexWhere((element) => element.deviceId == newDevice.deviceId);
        if(isExist != -1) {
          if(state[isExist] == newDevice) {
            state.removeAt(isExist);
            state = [...state, newDevice];
          }
        } else {
          state = [...state, newDevice];
        }
      }
    });
  }

}