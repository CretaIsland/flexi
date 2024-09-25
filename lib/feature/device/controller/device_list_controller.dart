import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constant/config.dart';
import '../model/device_model.dart';

part 'device_list_controller.g.dart';



final selectDevicesProvider = StateProvider<List<DeviceModel>>((ref) => List.empty());

@riverpod
class ConnectedDeviceController extends _$ConnectedDeviceController {

  late RawDatagramSocket _socket;

  @override
  List<DeviceModel> build() {
    ref.onDispose(() {
      print('ConnectedDeviceController Dispose');
      _socket.close();
    });
    print('ConnectedDeviceController Build');
    initialize();
    return List.empty();
  }

  void initialize() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, NetworkConfig.udpBroadcastPort);
    _socket.listen((event) {
      Datagram? d = _socket.receive();
      if(d == null) return;

      Map<String, dynamic> data = jsonDecode(utf8.decode(d.data));
      if(data['command'] != 'playerStatus') return;

      if(data['deviceName'] == 'null') data['deviceName'] = data['deviceId'];
      DeviceModel newDevice = DeviceModel.fromJson(data);
      if(state.contains(newDevice)) return;

      var index = state.indexWhere((device) => device.deviceId == newDevice.deviceId);
      if(index != -1) {
        state[index] = newDevice;
        state = [...state];
      } else {
        state = [...state, newDevice];
      }
    });
  }

  void refresh() {
    state = List.empty();
  }

}