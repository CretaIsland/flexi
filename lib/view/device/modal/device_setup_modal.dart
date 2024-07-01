import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../../../common/providers/socket_client_controller.dart';
import '../../../component/loading_overlay.dart';
import '../../../component/text_button.dart';
import '../../../feature/device/controller/device_register_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class DeviceSetupModal extends ConsumerWidget {
  const DeviceSetupModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final registerData = ref.watch(registerDataControllerProvider);

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
          Text('Wifi Setup', style: FlexiFont.semiBold24),
          SizedBox(height: .02.sh),
          Text('Press Connect once \nthe device has rebooted.', style: FlexiFont.regular16,),
          SizedBox(height: .03.sh),
          FlexiTextButton(
            width: .82.sw, 
            height: .06.sh, 
            text: 'Connect',
            backgroundColor: FlexiColor.primary,
            onPressed: () async {
              OverlayEntry loadingOverlay = OverlayEntry(builder: (_) => const LoadingOverlay());
              Navigator.of(context).overlay!.insert(loadingOverlay);
              ref.watch(registerDeviceControllerProvider).whenData((value) async {
                if(value == null) {
                  loadingOverlay.remove();
                  context.pop();
                  Fluttertoast.showToast(msg: 'network error');
                } else {
                  var connected = await ref.watch(socketClientControllerProvider.notifier).connect(value.ip);
                  if(connected) {
                    Map<String, String> data = {
                      "command": "register",
                      "deviceId": value.deviceId,
                      "ssid": registerData['ssid']!,
                      "security": registerData['security']!,
                      "password": registerData['password']!,
                      "timeZone": registerData['timeZone']!
                    };
                    ref.watch(socketClientControllerProvider.notifier).sendData(data);

                    await Future.delayed(const Duration(seconds: 1));

                    await ref.watch(networkControllerProvider.notifier).connect(
                      ssid: registerData['ssid']!,
                      passphrase: registerData['password'],
                      security: registerData['security']!.contains('WPA') ? 
                        NetworkSecurity.WPA : registerData['security']!.contains('WEP') ? NetworkSecurity.WEP : NetworkSecurity.NONE
                    );

                    loadingOverlay.remove();
                    context.pop();
                    context.go('/device/list');
                  } else {
                    loadingOverlay.remove();
                    context.pop();
                    Fluttertoast.showToast(msg: 'network error');
                  }
                }
              });
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