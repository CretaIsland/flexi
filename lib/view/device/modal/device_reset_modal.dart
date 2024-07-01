import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../common/providers/socket_client_controller.dart';
import '../../../component/text_button.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';
import '../screen/device_list_screen.dart';



class DeviceResetModal extends ConsumerWidget {
  const DeviceResetModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final selectDevices = ref.watch(selectDevicesProvider);

    return Container(
      width: .93.sw,
      height: .35.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .05.sh, right: .055.sw),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.circular(.025.sh)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Are you sure?', style: FlexiFont.semiBold24),
          SizedBox(height: .02.sh),
          Text('This will reset the wifi credentials \nof the device(s)', style: FlexiFont.regular16,),
          SizedBox(height: .03.sh),
          FlexiTextButton(
            width: .82.sw, 
            height: .06.sh, 
            text: 'Reset',
            backgroundColor: FlexiColor.secondary,
            onPressed: () async {
              for(var device in selectDevices) {
                Map<String, String> data = {
                  "command": "unregister",
                  "deviceId": device.deviceId
                };

                var connected = await ref.watch(socketClientControllerProvider.notifier).connect(device.ip);
                if(connected) {
                  ref.watch(socketClientControllerProvider.notifier).sendData(data);
                }
                ref.invalidate(socketClientControllerProvider);
              }
              ref.invalidate(selectDevicesProvider);
              context.pop();
            },
          ),
          SizedBox(
            width: .82.sw,
            height: .06.sh,
            child: TextButton(
              onPressed: () => context.pop(),
              child: Text('Cancel', style: FlexiFont.regular16),
            ),
          )
        ],
      ),
    );
  }

}