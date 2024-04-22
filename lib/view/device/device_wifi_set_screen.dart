import 'package:flexi/component/bottom_navigation_bar.dart';
import 'package:flexi/utils/colors.dart';
import 'package:flexi/view/modal/wifi_setup_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';
import '../../utils/fonts.dart';

class DeviceWifiSetScreen extends ConsumerStatefulWidget {
  const DeviceWifiSetScreen({super.key});

  @override
  ConsumerState<DeviceWifiSetScreen> createState() => _DeviceWifiSetScreenState();
}

class _DeviceWifiSetScreenState extends ConsumerState<DeviceWifiSetScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: FlexiColor.screenColor,
        padding: EdgeInsets.only(top: screenHeight * .04, left: screenWidth * .055, right: screenWidth * .055),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back_ios, size: screenHeight * .02, color: FlexiColor.primary)
                ),
                Text("Wifi Setup", style: FlexiFont.semiBold20),
                TextButton(
                  onPressed: () => showModalBottomSheet(
                    context: context, 
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const WifiSetupModal()
                  ),
                  child: Text("OK", style: FlexiFont.regular16.copyWith(color: FlexiColor.primary))
                )
              ],
            ),
            SizedBox(height: screenHeight * .03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                loadWifiCredentialButton(Icons.qr_code, "Scan \nQR-CODE", () { }),
                loadWifiCredentialButton(Icons.add_photo_alternate_outlined, "Load from \nImage", () { }),
              ],
            ),
            SizedBox(height: screenHeight * .03),
            Text("SSID", style: FlexiFont.regular14),
            SizedBox(height: screenHeight * .01),
            wifiCredentialTextField(),
            SizedBox(height: screenHeight * .025),
            Text("Type", style: FlexiFont.regular14),
            SizedBox(height: screenHeight * .01),
            wifiCredentialTextField(),
            SizedBox(height: screenHeight * .025),
            Text("Passphrase", style: FlexiFont.regular14),
            SizedBox(height: screenHeight * .01),
            wifiCredentialTextField()
          ],
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }


  Widget loadWifiCredentialButton(IconData buttonIcon, String buttonLabel, void Function()? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: screenWidth * .43,
        height: screenHeight * .25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenHeight * .01)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: screenHeight * .1,
                height: screenHeight * .1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenHeight * .1),
                  color: FlexiColor.primary.withOpacity(.1)
                ),
                child: Center(
                  child: Icon(buttonIcon, size: screenHeight * .05, color: FlexiColor.primary,),
                ),
              ),
            ),
            SizedBox(height: screenHeight * .03),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * .055),
              child: Text(buttonLabel, style: FlexiFont.semiBold16.copyWith(color: FlexiColor.primary)),
            )
          ],
        ),
      ),
    );
  }

  Widget wifiCredentialTextField() {
    return SizedBox(
      width: screenWidth * .89,
      height: screenHeight * .06,
      child: TextField(
        controller: TextEditingController(),
        style: FlexiFont.regular16,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight * .01),
            borderSide: BorderSide(color: FlexiColor.grey[400]!)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight * .01),
            borderSide: BorderSide(color: FlexiColor.grey[400]!)
          ),
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true
        ),
      ),
    );
  }
  
}