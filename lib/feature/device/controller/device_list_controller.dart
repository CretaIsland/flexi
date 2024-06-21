import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/constants/config.dart';
import '../model/device_info.dart';

part 'device_list_controller.g.dart';



final selectModeProvider = StateProvider<bool>((ref) => false);
final selectAllProvider = StateProvider<bool>((ref) => false);
final selectDeviceProvider = StateProvider<DeviceInfo?>((ref) => null);
final searchTextProvider = StateProvider<String>((ref) => '');


@riverpod
class DeviceListController extends _$DeviceListController {

  late RawDatagramSocket _socket;


  @override
  List<DeviceInfo> build() {
    ref.onDispose(() {
      print("<<<<<<< DeviceListController dispose <<<<<<<");
      _socket.close();
    });
    print("<<<<<<< DeviceListController build <<<<<<<");
    initialize();
    return [];
  }

  Future<void> initialize() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, Config.udpBroadcastPort);
    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if(d == null) return;

      Map<String, dynamic> data = jsonDecode(utf8.decode(d.data));
      if(data['command'] == 'playerStatus') {
        if(data['deviceName'] == 'null') data['deviceName'] = data['deviceId'];
        DeviceInfo newDevice = DeviceInfo.fromJson(data);
        print(newDevice);
        var isExist = state.indexWhere((element) => element.deviceId == newDevice.deviceId);
        if(isExist != -1) {
          if(state[isExist] != newDevice) {
            state[isExist] = newDevice;
            state = [...state];
          }
        } else {
          state = [...state, newDevice];
        }
      }
    });
    
  }

}