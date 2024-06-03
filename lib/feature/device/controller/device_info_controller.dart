import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/device_info.dart';

part 'device_info_controller.g.dart';


@riverpod
class DeviceInfoController extends _$DeviceInfoController {

  @override
  DeviceInfo? build() {
    ref.onDispose(() {
      print("<<<<<<< DeviceInfoController dispose <<<<<<<");
    });
    print("<<<<<<< DeviceInfoController build <<<<<<<");
    return null;
  }

  // 현재 편집중인 콘텐츠의 모델을 상태 값으로 가지고 있어야함.
  void setDevice(DeviceInfo selectDevice) {
    state = selectDevice;
  }

  // 변경된 세팅 값 전송하기

}