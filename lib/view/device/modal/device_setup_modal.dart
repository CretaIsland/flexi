import 'dart:io';

import 'package:flexi/core/controller/ble_central_controller.dart';
import 'package:flexi/core/controller/socket_client_controller.dart';
import 'package:flexi/feature/device/controller/device_register_controller.dart';
import 'package:flexi/feature/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../component/progress_overlay.dart';
import '../../../component/text_button.dart';
import '../../../util/design/colors.dart';



class DeviceSetupModal extends ConsumerWidget {
  const DeviceSetupModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(ref.watch(registerDataControllerProvider));
    return Container(
      width: .94.sw,
      height: .35.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .045.sh, right: .055.sw, bottom: .03.sh),
      margin: EdgeInsets.only(bottom: .02.sh),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.circular(.025.sh)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('WiFi Setup', style: Theme.of(context).textTheme.displayMedium),
          Text('Press Connect once \nthe device has rebooted', style: Theme.of(context).textTheme.bodyMedium),
          FlexiTextButton(
            width: .82.sw, 
            height: .06.sh, 
            text: 'Connect',
            backgroundColor: FlexiColor.primary,
            onPressed: () async {
              var successTask = 0;
              Map<String, String> registerData = {
                "command": "register",
                "deviceId": "",
                "ssid": ref.watch(registerDataControllerProvider)['ssid']!,
                "security": ref.watch(registerDataControllerProvider)['security']!,
                "password": ref.watch(registerDataControllerProvider)['password']!,
                "timeZone": ref.watch(registerDataControllerProvider)['timeZone']!
              };
              OverlayEntry progressOverlay = OverlayEntry(builder: (context) => const ProgressOverlay());

              if(ref.watch(settingControllerProvider)['registerType'] == 'Hotspot') {
                if(Platform.isIOS) {
                  ref.watch(totalTaskProvider.notifier).state = 1;
                  Navigator.of(context).overlay!.insert(progressOverlay);
                  
                  var device = await ref.watch(deviceIPControllerProvider.notifier).getDeviceStatus();
                  if(device != null) {
                    if(await ref.watch(socketClientControllerProvider.notifier).connect(device.ip)) {
                      registerData['deviceId'] = device.deviceId;
                      await ref.watch(socketClientControllerProvider.notifier).sendData(registerData);
                      successTask++;
                      await ref.watch(socketClientControllerProvider.notifier).disconnect();
                    }
                  }
                  ref.watch(completeTaskProvider.notifier).state = ref.watch(completeTaskProvider) + 1;
                } else {
                  ref.watch(totalTaskProvider.notifier).state = ref.read(selectHotspotsProvider).length;
                  Navigator.of(context).overlay!.insert(progressOverlay);

                  for(var deviceHotspot in ref.read(selectHotspotsProvider)) {
                    if(await ref.watch(networkControllerProvider.notifier).connect(ssid: deviceHotspot, security: 'WPA', password: 'esl!UU8x')) {
                      var device = await ref.watch(deviceIPControllerProvider.notifier).getDeviceStatus();
                      if(device != null) {
                        if(await ref.watch(socketClientControllerProvider.notifier).connect(device.ip)) {
                          registerData['deviceId'] = device.deviceId;
                          await ref.watch(socketClientControllerProvider.notifier).sendData(registerData);
                          successTask++;
                          if(!await ref.watch(socketClientControllerProvider.notifier).disconnect()) ref.invalidate(socketClientControllerProvider);
                        }
                      }
                    }
                    ref.watch(completeTaskProvider.notifier).state = ref.watch(completeTaskProvider) + 1;
                    await Future.delayed(const Duration(milliseconds: 500));
                  }
                  ref.invalidate(selectHotspotsProvider);
                }
              } else {
                ref.watch(totalTaskProvider.notifier).state = ref.read(selectBluetoothsProvider).length;
                Navigator.of(context).overlay!.insert(progressOverlay);

                for(var deviceBluetooth in ref.read(selectBluetoothsProvider)) {
                  registerData['deviceId'] = deviceBluetooth.advertisement.name!;
                  await ref.watch(bleCentralControllerProvider.notifier).sendData(deviceBluetooth.peripheral, registerData);
                  successTask++;
                  ref.watch(completeTaskProvider.notifier).state = ref.watch(completeTaskProvider) + 1;
                  await Future.delayed(const Duration(milliseconds: 500));
                }
                ref.invalidate(selectBluetoothsProvider);
              }

              await ref.watch(networkControllerProvider.notifier).connect(ssid: registerData['ssid']!, security: registerData['security']!, password: registerData['password']);
              Fluttertoast.showToast(
                msg: 'Success $successTask devices (Fail ${ref.watch(totalTaskProvider) - successTask} devices)',
                backgroundColor: Colors.black.withOpacity(.8),
                textColor: Colors.white,
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize
              ).whenComplete(() {
                ref.invalidate(totalTaskProvider);
                ref.invalidate(completeTaskProvider);
                progressOverlay.remove();
                context.pop();
                context.go('/device/list');
              });
            }
          ),
          SizedBox(
            width: .82.sw, 
            height: .06.sh, 
            child: TextButton(
              onPressed: () => context.pop(), 
              child: Text('Cancel', style: Theme.of(context).textTheme.labelLarge)
            )
          )
        ],
      ),
    );
  }
}