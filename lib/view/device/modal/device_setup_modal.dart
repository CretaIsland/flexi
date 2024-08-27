import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../../../core/controller/socket_client_controller.dart';
import '../../../feature/device/controller/device_register_controller.dart';
import '../../../feature/setting/controller/app_setting_controller.dart';
import '../../../util/design/colors.dart';
import '../../../component/text_button.dart';
import '../../../component/progress_overlay.dart';



class DeviceSetupModal extends ConsumerWidget {
  const DeviceSetupModal({super.key});
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectTimezone = ref.watch(selectTimezoneProvider);
    var registerNetwork = ref.watch(registerNetworkProvider);
    return Container(
      width: .93.sw,
      height: .35.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw, bottom: .03.sh),
      margin: EdgeInsets.only(bottom: .02.sh),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.circular(.025.sh)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Wifi Setup', style: Theme.of(context).textTheme.displayMedium),
          Text('This will reset the wifi credentials \nof the device(s)', style: Theme.of(context).textTheme.bodyMedium),
          FlexiTextButton(
            width: .82.sw,
            height: .06.sh,
            text: 'Connect',
            backgroundColor: FlexiColor.primary,
            onPressed: () async {
              var successTask = 0;
              OverlayEntry loadingScreen = OverlayEntry(builder: (context) => const ProgressOverlay());

              if(ref.watch(appSettingControllerProvider)['registerOption'] == 'Hotspot') {
                ref.watch(totalTaskProvider.notifier).state = ref.read(selectDeviceHotspotsProvider).length;
                Navigator.of(context).overlay!.insert(loadingScreen);

                for(var targetDevice in ref.read(selectDeviceHotspotsProvider)) {
                  var connected = await ref.watch(networkControllerProvider.notifier).connect(ssid: targetDevice, passphrase: 'esl!UU8x');
                  if(connected) {
                    var device = await ref.watch(registerDeviceIPControllerProvider.future);
                    if(device != null) {
                      var socketConnected = await ref.watch(socketClientControllerProvider.notifier).connect(device.ip);
                      if(!socketConnected) break;

                      await ref.watch(socketClientControllerProvider.notifier).sendData({
                        "command": "register",
                        "deviceId": device.deviceId,
                        "ssid": registerNetwork['ssid']!,
                        "security": registerNetwork['security']!,
                        "password": registerNetwork['password']!,
                        "timeZone": selectTimezone
                      });
                      successTask += 1;
                      var socketDisconnected = await ref.watch(socketClientControllerProvider.notifier).disconnect();
                      if(!socketDisconnected) {
                        ref.invalidate(socketClientControllerProvider);
                      }
                      await Future.delayed(const Duration(seconds: 1));
                    }
                  }
                  ref.invalidate(registerDeviceIPControllerProvider);
                  ref.watch(completeTaskProvider.notifier).state = ref.watch(completeTaskProvider) + 1;
                  await Future.delayed(const Duration(seconds: 1));
                }
                ref.invalidate(selectDeviceHotspotsProvider);
              } else {
                ref.watch(totalTaskProvider.notifier).state = ref.read(selectDeviceBluetoothsProvider).length;
                Navigator.of(context).overlay!.insert(loadingScreen);

                for(var targetDevice in ref.read(selectDeviceBluetoothsProvider)) {
                  Map<String, String> data = {
                    "command": "register",
                    "deviceId": targetDevice.advertisement.name!,
                    "ssid": registerNetwork['ssid']!,
                    "security": registerNetwork['security']!,
                    "password": registerNetwork['password']!,
                    "timeZone": selectTimezone.toString()
                  };
                  await ref.watch(bleCentralControllProvider.notifier).sendData(targetDevice.peripheral, data);
                  successTask += 1;
                  ref.watch(completeTaskProvider.notifier).state = ref.watch(completeTaskProvider) + 1;
                  await Future.delayed(const Duration(seconds: 1));
                }
                ref.invalidate(selectDeviceBluetoothsProvider);
              }

              await ref.watch(networkControllerProvider.notifier).connect(
                ssid: registerNetwork['ssid']!,
                passphrase: registerNetwork['password'],
                security: registerNetwork['security']!.contains('WPA') ? 
                  NetworkSecurity.WPA : registerNetwork['security']!.contains('WEP') ? NetworkSecurity.WEP : NetworkSecurity.NONE
              );
              
              Fluttertoast.showToast(
                msg: 'Success $successTask devices (Fail ${ref.read(totalTaskProvider) - successTask} devices)',
                backgroundColor: Colors.black.withOpacity(.8),
                textColor: Colors.white,
                fontSize: .02375.sh
              ).whenComplete(() {
                ref.invalidate(totalTaskProvider);
                ref.invalidate(completeTaskProvider);
                ref.invalidate(selectTimezoneProvider);
                ref.invalidate(registerNetworkProvider);
                loadingScreen.remove();
                context.pop();
                context.go('/device/list');
              });
            }
          ),
          SizedBox(
            width: .82.sw,
            height: .06.sh,
            child: TextButton(
              child: Text('Cancle', style: Theme.of(context).textTheme.bodyMedium),
              onPressed: () => context.pop(),
            ),
          )
        ],
      ),
    );
  }

}