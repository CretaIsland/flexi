import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../../../common/providers/network_control_provider.dart';
import '../../../components/loading_overlay.dart';
import '../../../components/text_button.dart';
import '../../../feature/device/controller/wifi_setup_controller.dart';
import '../../../feature/device/provider/timezone_provider.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';



class DeviceSetupModal extends ConsumerWidget {
  const DeviceSetupModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final wifiCredentials = ref.watch(wifiCredentialsControllerProvider);
    final networkController = ref.watch(networkControllerProvider.notifier);

    
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
            fillColor: FlexiColor.primary,
            onPressed: () async {
              OverlayEntry loadingOverlay = OverlayEntry(builder: (_) => const LoadingOverlay());
              Navigator.of(context).overlay!.insert(loadingOverlay);

              // register 메세지 전송
              var registerData = {
                'register': {
                  'command': 'register',
                  'deviceId': 'DBAP0001',
                  'ssid': wifiCredentials['ssid'],
                  'type': wifiCredentials['type'],
                  'password': wifiCredentials['passphrase'],
                  'timezone': ref.watch(selectTimezoneProvider)
                }
              };
              // socket을 이용해 전송
              
              final isConnect = await networkController.connectNetwork(
                ssid: wifiCredentials['ssid']!,
                password: wifiCredentials['passphrase'],
                security: wifiCredentials['type'] == 'WPA' ? 
                  NetworkSecurity.WPA : wifiCredentials['type'] == 'WEP' ? 
                    NetworkSecurity.WEP : NetworkSecurity.NONE
              );
              
              loadingOverlay.remove();
              context.pop();
              if(isConnect) {
                ref.invalidate(selectTimezoneProvider);
                ref.invalidate(wifiCredentialsControllerProvider);
                context.go('/device/list');
              }
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