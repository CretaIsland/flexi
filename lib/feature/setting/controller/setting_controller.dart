import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/setting_repository.dart';

part 'setting_controller.g.dart';



@Riverpod(keepAlive: true)
class SettingController extends _$SettingController {

  late SettingRepository _repository;

  @override
  Map<String, dynamic> build() {
    ref.onDispose(() {
      print('SettingController Dispose');
    });
    print('SettingController Build');
    _repository = SettingRepository();
    return {
      'registerType': 'Bluetooth'
    };
  }

  Future<void> getSetting() async {
    var setting = await _repository.get();
    if(setting != null) state = setting;
  }

  Future<void> setRegisterType(String type) async {
    state = {'registerType': type};
    await _repository.save(state);
  }

}