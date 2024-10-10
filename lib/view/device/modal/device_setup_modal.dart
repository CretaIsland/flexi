import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../../component/progress_overlay.dart';
import '../../../component/text_button.dart';
import '../../../core/controller/ble_central_controller.dart';
import '../../../core/controller/network_controller.dart';
import '../../../feature/device/controller/device_register_controller.dart';
import '../../../util/design/colors.dart';



class DeviceSetupModal extends ConsumerWidget {
  const DeviceSetupModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              var selectDevices = ref.read(selectDeviceBluetoothsProvider);
              var registerData = ref.read(registerDataProvider);
              registerData.addAll({'command': 'register', 'deviceId': ''});
              
              ref.watch(totalTaskProvider.notifier).state = selectDevices.length;
              OverlayEntry progressOverlay = OverlayEntry(builder: (context) => const ProgressOverlay());
              Navigator.of(context).overlay!.insert(progressOverlay);

              var successTask = 0;
              for(var device in selectDevices) {
                registerData['deviceId'] = device.advertisement.name!;
                if(await ref.watch(bleCentralControllerProvider.notifier).sendData(device.peripheral, registerData)) {
                  successTask++;
                } else {
                  ref.invalidate(bleCentralControllerProvider);
                }
                ref.watch(completeTaskProvider.notifier).state = ref.watch(completeTaskProvider) + 1;
                await Future.delayed(const Duration(milliseconds: 500));
              }

              await ref.watch(networkControllerProvider.notifier).connectWifi(registerData['ssid']!, registerData['security']!, registerData['password']!);

              Fluttertoast.showToast(
                msg: 'Success $successTask device (Fail ${selectDevices.length - successTask} device)',
                backgroundColor: Colors.black.withOpacity(.8),
                textColor: Colors.white,
                fontSize: .02875.sh
              ).whenComplete(() {
                ref.invalidate(totalTaskProvider);
                ref.invalidate(completeTaskProvider);
                progressOverlay.remove();
                if(context.mounted) {
                  context.pop();
                  context.go('/device/list');
                }
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
        ]
      )
    );
  }
}