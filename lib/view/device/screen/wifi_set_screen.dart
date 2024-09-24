import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/text_field.dart';
import '../../../feature/device/controller/device_register_controller.dart';
import '../../../util/design/colors.dart';
import '../modal/device_setup_modal.dart';



class WifiSetScreen extends ConsumerStatefulWidget {
  const WifiSetScreen({super.key, required this.rootContext});
  final BuildContext rootContext;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WifiSetScreenState();
}

class _WifiSetScreenState extends ConsumerState<WifiSetScreen> {

  final TextEditingController _ssidController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ssidController.text = ref.watch(registerDataControllerProvider)['ssid']!;
      _typeController.text = ref.watch(registerDataControllerProvider)['security']!;
      _passwordController.text = ref.watch(registerDataControllerProvider)['password']!;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _ssidController.dispose();
    _typeController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(ref.watch(registerDataControllerProvider));
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
                  icon: Icon(Icons.arrow_back_ios_rounded, size: .025.sh, color: FlexiColor.primary)
                ),
                Text('WiFi Setup', style: Theme.of(context).textTheme.displaySmall),
                TextButton(
                  onPressed: () {
                    ref.watch(registerDataControllerProvider.notifier).setNetwork(_ssidController.text, _typeController.text, _passwordController.text);
                    context.go('/device/register');
                  },
                  child: Text('OK', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.primary))
                )
              ]
            ),
            SizedBox(height: .03.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                qrcodeButton('Scan \nQR-CODE', Icons.qr_code, '/qrcode/scan'),
                qrcodeButton('Load from \nImage', Icons.add_photo_alternate_outlined, '/qrcode/load')
              ]
            ),
            SizedBox(height: .03.sh),
            Text('SSID', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              controller: _ssidController
            ),
            SizedBox(height: .015.sh),
            Text('Type', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              controller: _typeController
            ),
            SizedBox(height: .015.sh),
            Text('Passphrase', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: .01.sh),
            FlexiTextField(
              width: .89.sw, 
              height: .06.sh,
              controller: _passwordController
            )
          ]
        )
      )
    );
  }

  Widget qrcodeButton(String text, IconData icon, String routePath) {
    return GestureDetector(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: .1.sh,
                height: .1.sh,
                decoration: BoxDecoration(
                  color: FlexiColor.primary.withOpacity(.1),
                  borderRadius: BorderRadius.circular(.05.sh)
                ),
                child: Icon(icon, size: .05.sh, color: FlexiColor.primary)
              )
            ),
            SizedBox(height: .025.sh),
            Text(text, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: FlexiColor.primary))
          ]
        )
      )
    );
  }
}