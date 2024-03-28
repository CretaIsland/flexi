import 'package:flexi/screen/widget/text_field/button_text_field.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../utils/flexi_color.dart';
import '../../utils/flexi_font.dart';
import '../../widget/button/text_button.dart';
import '../../widget/scaffold/app_bar.dart';

class DeviceRecoveryPage extends StatefulWidget {
  const DeviceRecoveryPage({super.key});

  @override
  State<DeviceRecoveryPage> createState() => _DeviceRecoveryPageState();
}

class _DeviceRecoveryPageState extends State<DeviceRecoveryPage> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.grey[200],
      padding: EdgeInsets.only(top: screenHeight * .04, left: screenWidth * .066, right: screenWidth * .066, bottom: screenHeight * .035),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FlexiAppBar(title: "Device Recovery", pageName: "/setting"),
          SizedBox(height: screenHeight * .03),
          Text("Device ID", style: FlexiFont.displayRegular14),
          SizedBox(height: screenHeight * .01),
          FlexiButtonTextField(
            width: screenWidth * .88,
            height: screenHeight * .06,
            fillColor: Colors.white,
            border: Border.all(color: FlexiColor.grey[400]!),
            borderRadius: BorderRadius.circular(screenHeight *.01),
            textEditingController: TextEditingController(text: "V0.0.1"),
            contentPadding: EdgeInsets.only(left: 12, top: screenHeight * .02, bottom: screenHeight * .02),
            actionButton: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.qr_code_scanner_outlined, color: FlexiColor.primary),
              iconSize: screenHeight * .02,
            ),
          ),
          SizedBox(height: screenHeight * .02),
          FlexiTextButton(
            width: screenWidth * .88,
            height: screenHeight * .06,
            fillColor: FlexiColor.primary,
            text: Text("Recover", style: FlexiFont.textButtonSemibold16.copyWith(color: Colors.white)),
            onTap: () {}
          )
        ]
      ),
    );
  }
  
}