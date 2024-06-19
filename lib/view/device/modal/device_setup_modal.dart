import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../../../common/constants/config.dart';
import '../../../common/providers/network_providers.dart';
import '../../../component/loading_overlay.dart';
import '../../../component/text_button.dart';
import '../../../feature/device/controller/device_setup_controller.dart';
import '../../../feature/device/provider/timezone_provider.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class DeviceSetupModal extends ConsumerWidget {
  const DeviceSetupModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final wifiCredential = ref.watch(wifiCredentialsControllerProvider);
    final targetDevice = ref.watch(registerDeviceInfoProvider);
    final socketClient = ref.watch(SocketIOClientProvider(ip: targetDevice!.ip, port: Config.socketIOPort).notifier);

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
              // 데이터 보내기
               String sendData = '''
{
"command": "register",
"deviceId": "${targetDevice.deviceId}",
"ssid": "${wifiCredential['ssid']}",
"security": "${wifiCredential['type'] == '' ? 'NONE' : wifiCredential['type']}",
"password": "${wifiCredential['passphrase']}",
"timeZone": "${ref.watch(selectTimezoneProvider)['locationName']}"
}
''';
              socketClient.sendData(sendData);
              // 와이파이 연결
              await ref.watch(networkControllerProvider.notifier).connect(
                ssid: wifiCredential['ssid']!,
                password: wifiCredential['passphrase']!,
                security: wifiCredential['type']!.contains('WPA') ? 
                  NetworkSecurity.WPA : wifiCredential['type']!.contains('WEP') ?
                    NetworkSecurity.WEP : NetworkSecurity.NONE
              );
              loadingOverlay.remove();
              context.pop();
              context.go('/device/list');
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