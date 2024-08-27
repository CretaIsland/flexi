import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/socket_client_controller.dart';
import '../../../feature/device/controller/device_list_controller.dart';
import '../../../util/design/colors.dart';
import '../../../util/design/fonts.dart';
import '../../../component/text_button.dart';
import '../../../component/progress_screen.dart';



class DeviceResetModal extends ConsumerWidget {
  const DeviceResetModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          Text('Are you sure?', style: FlexiFont.semiBold24),
          Text('This will reset the wifi credentials \nof the device(s)', style: FlexiFont.regular16),
          FlexiTextButton(
            width: .82.sw,
            height: .06.sh,
            text: 'Reset',
            backgroundColor: FlexiColor.secondary,
            onPressed: () async {
              var successTask = 0;
              ref.watch(totalTaskProvider.notifier).state = ref.watch(selectDevicesProvider).length;
              OverlayEntry loadingScreen = OverlayEntry(builder: (context) => const ProgressScreen());
              Navigator.of(context).overlay!.insert(loadingScreen);

              for(var device in ref.read(selectDevicesProvider)) {
                var connected = await ref.watch(socketClientControllerProvider.notifier).connect(device.ip);
                if(connected) {
                  await ref.watch(socketClientControllerProvider.notifier).sendData({
                    'command': 'unregister',
                    'deviceId': device.deviceId
                  });
                  successTask += 1;
                  ref.watch(completedTaskProvider.notifier).state = ref.watch(completedTaskProvider) + 1;
                  var disconnected = await ref.watch(socketClientControllerProvider.notifier).disconnect();
                  if(!disconnected) {
                    ref.invalidate(socketClientControllerProvider);
                  }
                  await Future.delayed(const Duration(seconds: 1));
                }
              }

              Fluttertoast.showToast(
                msg: 'Success $successTask devices (Fail ${ref.read(totalTaskProvider) - successTask} devices)',
                backgroundColor: Colors.black.withOpacity(.8),
                textColor: Colors.white,
                fontSize: FlexiFont.regular20.fontSize
              ).whenComplete(() {
                ref.watch(connectedDeviceControllerProvider.notifier).refresh();
                ref.invalidate(totalTaskProvider);
                ref.invalidate(completedTaskProvider);
                ref.invalidate(selectDevicesProvider);
                
                loadingScreen.remove();
                context.pop();
              });
            }
          ),
          SizedBox(
            width: .82.sw,
            height: .06.sh,
            child: TextButton(
              child: Text('Cancle', style: FlexiFont.regular16),
              onPressed: () => context.pop(),
            ),
          )
        ],
      ),
    );
  }

}