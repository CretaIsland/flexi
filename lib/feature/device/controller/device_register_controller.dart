import 'package:bluetooth_low_energy/bluetooth_low_energy.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../util/utils.dart';

part 'device_register_controller.g.dart';



@riverpod
class RegisterDataController extends _$RegisterDataController {

  @override
  Map<String, String> build() {
    return {
      'timeZone': '',
      'ssid': '',
      'security': '',
      'password': ''
    };
  }

  void setTimezone(String timeZone) {
    state = {
      'timeZone': timeZone,
      'ssid': state['ssid']!,
      'security': state['security']!,
      'password': state['password']!
    };
  }

  void setNetwork(String ssid, String security, String password) {
    state = {
      'timeZone': state['timeZone']!,
      'ssid': ssid,
      'security': security,
      'password': password
    };
  }

}

@riverpod
class AccessibleDeviceBluetooths extends _$AccessibleDeviceBluetooths {

  late CentralManager _manager;

  @override
  List<DiscoveredEventArgs> build() {
    ref.onDispose(() {
      _manager.stopDiscovery();
    });
    _manager = CentralManager();
    initialize();
    return List.empty();
  }

  void initialize() async {
    if(await Permission.locationWhenInUse.request().isGranted 
      && await Permission.bluetoothScan.request().isGranted
        && await Permission.bluetoothConnect.request().isGranted) {

      await _manager.startDiscovery();
      _manager.discovered.listen((result) {
        if(result.advertisement.name != null && FlexiUtils.checkDevice(result.advertisement.name!, '')) {
          final peripheral = result.peripheral;
          final index = state.indexWhere((element) => element.peripheral == peripheral);
          if(index != -1) {
            state.remove(result);
            state = [...state];
          } else {
            state = [...state, result];
          }
        }
      });
    }
  }

}