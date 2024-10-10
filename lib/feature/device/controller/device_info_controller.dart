import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/device_model.dart';

part 'device_info_controller.g.dart';



@riverpod
class DeviceInfoController extends _$DeviceInfoController {

  @override
  DeviceModel build() {
    ref.onDispose(() {
      print('DeviceInfoController Dispose');
    });
    print('DeviceInfoController Build');
    return DeviceModel();
  }

  void setDevice(DeviceModel device) {
    state = device;
  }

  void setName(String name) {
    state = state.copyWith(deviceName: name);
  }

  void setVolume(int volume) {
    state = state.copyWith(volume: volume);
  }

  void registerBluetooth(String deviceName, String remoteId) {
    state = state.copyWith(
      bluetoothBonded: true,
      bluetooth: deviceName,
      bluetoothId: remoteId
    );
  }

  void unregisterBluetooth() {
    state = state.copyWith(
      bluetoothBonded: false,
      bluetooth: '',
      bluetoothId: ''
    );
  }

}