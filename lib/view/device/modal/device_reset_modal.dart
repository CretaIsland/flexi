import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../../component/progress_overlay.dart';
import '../../../component/text_button.dart';
import '../../../core/controller/network_controller.dart';
import '../../../feature/device/controller/connected_device_controller.dart';
import '../../../util/design/colors.dart';



class DeviceResetModal extends ConsumerWidget {
  const DeviceResetModal({super.key});

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
          Text('Are you sure?', style: Theme.of(context).textTheme.displayMedium),
          Text('This will reset the wifi credentials \of the device(s)', style: Theme.of(context).textTheme.bodyMedium),
          FlexiTextButton(
            width: .82.sw, 
            height: .06.sh,  
            text: 'Reset',
            backgroundColor: FlexiColor.secondary,
            onPressed: () async {
              var selectDevices = ref.read(selectDevicesProvider);

              ref.watch(totalTaskProvider.notifier).state = selectDevices.length;
              OverlayEntry progressOverlay = OverlayEntry(builder: (context) => const ProgressOverlay());
              Navigator.of(context).overlay!.insert(progressOverlay);

              var successTask = 0;
              for(var device in selectDevices) {
                if(await ref.watch(socketClientControllerProvider.notifier).connect(device.ip)) {
                  await ref.watch(socketClientControllerProvider.notifier).sendData({'command': 'unregister', 'deviceId': device.deviceId});
                  successTask++;
                }
                ref.watch(completeTaskProvider.notifier).state = ref.watch(completeTaskProvider) + 1;
                if(!await ref.watch(socketClientControllerProvider.notifier).disconnect()) ref.invalidate(socketClientControllerProvider);
                await Future.delayed(const Duration(milliseconds: 500));
              }

              Fluttertoast.showToast(
                msg: 'Success $successTask device (Fail ${selectDevices.length - successTask} device)',
                backgroundColor: Colors.black.withOpacity(.8),
                textColor: Colors.white,
                fontSize: .02875.sh
              ).whenComplete(() {
                ref.invalidate(connectedDeviceControllerProvider);
                ref.invalidate(selectDevicesProvider);
                ref.invalidate(totalTaskProvider);
                ref.invalidate(completeTaskProvider);
                progressOverlay.remove();
                if(context.mounted) {
                  context.pop();
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