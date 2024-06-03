import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../components/text_field.dart';
import '../../../feature/device/controller/wifi_setup_controller.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';
import '../modal/device_setup_modal.dart';



class WifiSetScreen extends ConsumerStatefulWidget {
  const WifiSetScreen({super.key, required this.rootContext});
  final BuildContext rootContext;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WifiSetScreenState();
}

class _WifiSetScreenState extends ConsumerState<WifiSetScreen> {


  late TextEditingController _ssidController;
  late TextEditingController _typeController;
  late TextEditingController _passphraseController;

  @override
  void initState() {
    super.initState();
    _ssidController = TextEditingController();
    _typeController = TextEditingController();
    _passphraseController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _ssidController.dispose();
    _typeController.dispose();
    _passphraseController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final wifiCredential = ref.watch(wifiCredentialsControllerProvider);
    _ssidController.value = TextEditingValue(text: wifiCredential['ssid']!);
    _typeController.value = TextEditingValue(text: wifiCredential['type']!);
    _passphraseController.value = TextEditingValue(text: wifiCredential['passphrase']!);

    
    return Padding(
      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.go('/device/setTimezone'),
                  icon: Icon(Icons.arrow_back_ios, color: FlexiColor.primary, size: .03.sh),
                ),
                Text('Wifi Setup', style: FlexiFont.semiBold20),
                TextButton(
                  onPressed: () => showModalBottomSheet(
                    context: widget.rootContext,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const DeviceSetupModal(),
                  ),
                  child: Text('OK', style: FlexiFont.regular16.copyWith(color: FlexiColor.primary)),
                )
              ],
            ),
            SizedBox(height: .02.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                qrcodeButton('Scan \nQR-CODE', Icons.qr_code, '/qrcode/scan'),
                qrcodeButton('Load from \nImage', Icons.add_photo_alternate_outlined, '/qrcode/load')
              ],
            ),
            SizedBox(height: .03.sh),
            Text('SSID', style: FlexiFont.regular14),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              controller: _ssidController,
              onChanged: (value) {
                ref.watch(wifiCredentialsControllerProvider.notifier).setWifiCredentials(
                  value, 
                  wifiCredential['type']!, 
                  wifiCredential['passphrase']!
                );
              },
            ),
            SizedBox(height: .025.sh),
            Text('Type', style: FlexiFont.regular14),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              controller: _typeController,
              onChanged: (value) {
                ref.watch(wifiCredentialsControllerProvider.notifier).setWifiCredentials(
                  wifiCredential['ssid']!, 
                  value, 
                  wifiCredential['passphrase']!
                );
              },
            ),
            SizedBox(height: .025.sh),
            Text('Passphrase', style: FlexiFont.regular14),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              controller: _passphraseController,
              onChanged: (value) {
                ref.watch(wifiCredentialsControllerProvider.notifier).setWifiCredentials(
                  wifiCredential['ssid']!, 
                  wifiCredential['type']!, 
                  value
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget qrcodeButton(String text, IconData icon, String routePath) {
    return InkWell(
      onTap: () => context.go(routePath),
      child: Container(
        width: .43.sw,
        height: .25.sh,
        padding: EdgeInsets.all(.025.sh),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(.01.sh)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Container(
                width: .1.sh,
                height: .1.sh,
                decoration: BoxDecoration(
                  color: FlexiColor.primary.withOpacity(.1),
                  borderRadius: BorderRadius.circular(.05.sh)
                ),
                child: Icon(icon, color: FlexiColor.primary, size: .05.sh)
              ),
            ),
            SizedBox(height: .025.sh),
            Text(text, style: FlexiFont.semiBold16.copyWith(color: FlexiColor.primary))
          ],
        ),
      ),
    );
  }

}