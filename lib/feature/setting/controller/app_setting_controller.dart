import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/setting_repository.dart';

part 'app_setting_controller.g.dart';



@Riverpod(keepAlive: true)
class AppSettingController extends _$AppSettingController {

  late SettingRepository _settingRepository;


  @override
  Map<String, dynamic> build() {
    ref.onDispose(() {
      print('>>> AppSettingController Dispose >>>');
    });
    print('>>> AppSettingController Build >>>');
    _settingRepository = SettingRepository();
    return {
      "registerOption": "Bluetooth"
    };
  }

  Future<void> getAppConfig() async {
    var config = await _settingRepository.getAppConfig();
    if(config != null) {
      state = config;
    }
  }

  Future<void> setRegisterType(String type) async {
    await _settingRepository.saveAppConfig({"registerOption": type});
    state = {"registerOption": type};
  }

}