import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../components/bottom_navigation_bar.dart';
import '../../components/text_field.dart';
import '../../main.dart';
import '../../utils/ui/colors.dart';
import '../../utils/ui/fonts.dart';
import 'modal/wifi_setup_modal.dart';



class DeviceWifiSetScreen extends ConsumerStatefulWidget {
  const DeviceWifiSetScreen({super.key});

  @override
  ConsumerState<DeviceWifiSetScreen> createState() => _DeviceWifiSetScreenState();
}

class _DeviceWifiSetScreenState extends ConsumerState<DeviceWifiSetScreen> {

  late TextEditingController _ssidController;
  late TextEditingController _typeController;
  late TextEditingController _passwordController;


  @override
  void initState() {
    super.initState();
    _ssidController = TextEditingController();
    _typeController = TextEditingController();
    _passwordController = TextEditingController();
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
    return Scaffold(
      body: Container(
        height: screenHeight,
        color: FlexiColor.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * .04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => context.go("/device/setTimezone"),
                    icon: Icon(Icons.arrow_back_ios_new, color: FlexiColor.primary),
                    iconSize: screenHeight * .025,
                  ),
                  Text("Wifi Setup", style: FlexiFont.semiBold20),
                  TextButton(
                    onPressed: () => {
                      showModalBottomSheet(
                        context: context, 
                        backgroundColor: Colors.transparent,
                        builder: (context) => WifiSetupModal(ssid: _ssidController.text, type: _typeController.text, password: _passwordController.text),
                      )
                    },
                    child: Text("OK", style: FlexiFont.regular16.copyWith(color: FlexiColor.primary)),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .03, right: screenWidth * .055),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        iconButton("Scan \nQR-CODE", Icons.qr_code, () => context.go("/qrcode/scan")),
                        iconButton("Load from \nImage", Icons.add_photo_alternate_outlined, () { })
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text("SSID", style: FlexiFont.regular16),
                    const SizedBox(height: 8),
                    FlexiTextField(width: screenWidth * .89, height: screenHeight * .06, textEditingController: _ssidController),
                    const SizedBox(height: 20),
                    Text("Type", style: FlexiFont.regular16),
                    const SizedBox(height: 8),
                    FlexiTextField(width: screenWidth * .89, height: screenHeight * .06, textEditingController: _typeController),
                    const SizedBox(height: 20),
                    Text("Passphrase", style: FlexiFont.regular16),
                    const SizedBox(height: 8),
                    FlexiTextField(width: screenWidth * .89, height: screenHeight * .06, textEditingController: _passwordController)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }

  Widget iconButton(String btnLabel, IconData btnIcon, void Function()? onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: screenWidth * .43,
        height: screenHeight * .25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenHeight * .01)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenHeight * .1,
              height: screenHeight * .1,
              decoration: BoxDecoration(
                color: FlexiColor.primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(screenHeight * .05)
              ),
              child: Center(
                child: Icon(btnIcon, color: FlexiColor.primary, size: screenHeight * .05),
              ),
            ),
            const SizedBox(height: 10),
            Text(btnLabel, style: FlexiFont.semiBold16.copyWith(color: FlexiColor.primary))
          ],
        ),
      ),
    );
  }


}