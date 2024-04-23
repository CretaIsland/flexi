import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../component/bottom_navigation_bar.dart';
import '../../component/text_field.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
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
       color: FlexiColor.screenColor,
        padding: EdgeInsets.only(top: screenHeight * .03, left: screenWidth * .055, right: screenWidth * .055),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => context.go("/device/setTimezone"),
                    icon: Icon(Icons.arrow_back_ios_new_rounded, color: FlexiColor.primary),
                    iconSize: screenHeight * .015,
                  ),
                  Text("Wifi Setup", style: FlexiFont.semiBold20,),
                  TextButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const WifiSetupModal(),
                    ), 
                    child: Text("OK", style: FlexiFont.regular16.copyWith(color: FlexiColor.primary))
                  )
                ],
              ),
              SizedBox(height: screenHeight * .03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.go("/qrcode/scan"),
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
                                color: FlexiColor.primary.withOpacity(.1),
                                borderRadius: BorderRadius.circular(screenHeight * .1)
                              ),
                              child: Icon(
                                Icons.qr_code,
                                color: FlexiColor.primary,
                                size: screenHeight * .05,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screenHeight * .02, left: screenWidth * .055),
                            child: Text("Scan \nQR-CODE ", style: FlexiFont.semiBold16.copyWith(color: FlexiColor.primary)),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
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
                                color: FlexiColor.primary.withOpacity(.1),
                                borderRadius: BorderRadius.circular(screenHeight * .1)
                              ),
                              child: Icon(
                                Icons.add_photo_alternate_outlined,
                                color: FlexiColor.primary,
                                size: screenHeight * .05,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screenHeight * .02, left: screenWidth * .055),
                            child: Text("Load from \nImage ", style: FlexiFont.semiBold16.copyWith(color: FlexiColor.primary)),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: screenHeight * .03),
              Text("SSID", style: FlexiFont.regular14),
              SizedBox(height: screenHeight * .0125),
              FlexiTextField(
                width: screenWidth * .89, 
                height: screenHeight * .06, 
                textEditingController: _ssidController
              ),
              SizedBox(height: screenHeight * .03),
              Text("Type", style: FlexiFont.regular14),
              SizedBox(height: screenHeight * .0125),
              FlexiTextField(
                width: screenWidth * .89, 
                height: screenHeight * .06, 
                textEditingController: _ssidController
              ),
              SizedBox(height: screenHeight * .03),
              Text("Passphrase", style: FlexiFont.regular14),
              SizedBox(height: screenHeight * .0125),
              FlexiTextField(
                width: screenWidth * .89, 
                height: screenHeight * .06, 
                textEditingController: _ssidController
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }


}