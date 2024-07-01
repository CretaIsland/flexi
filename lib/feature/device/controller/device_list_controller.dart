import 'dart:convert';
import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/constants/config.dart';
import '../model/device_info.dart';

part 'device_list_controller.g.dart';



@riverpod 
class DeviceListController extends _$DeviceListController {

  late RawDatagramSocket _socket;


  List<DeviceInfo> build() {
    ref.onDispose(() {
      print('DeviceListController Dispose!!!');
      _socket.close();
    });
    print('DeviceListController Build!!!');
    return List.empty();
  }

  Future<void> connect() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, NetworkConfig.udpBroadcastPort);
    
    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if(d == null) return;

      Map<String, dynamic> data = jsonDecode(utf8.decode(d.data));
      if(data['command'] != 'playerStatus') return;

      DeviceInfo newDevice = DeviceInfo.fromJson(data);
      if(state.contains(newDevice)) return;

      var isExist = state.indexWhere((device) => device.deviceId == newDevice.deviceId);
      if(isExist != -1) {
        state[isExist] = newDevice;
        state = [...state];
        return;
      }
      state = [...state, newDevice];
    });
  }

}