import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../utils/flexi_color.dart';
import '../../utils/flexi_font.dart';
import '../../widget/button/text_button.dart';
import '../../widget/scaffold/app_bar.dart';
import '../../widget/text_field/text_field.dart';

class AppUpdatePage extends StatefulWidget {
  const AppUpdatePage({super.key});

  @override
  State<AppUpdatePage> createState() => _AppUpdatePageState();
}

class _AppUpdatePageState extends State<AppUpdatePage> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.grey[200],
      padding: EdgeInsets.only(top: screenHeight * .04, left: screenWidth * .066, right: screenWidth * .066, bottom: screenHeight * .035),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FlexiAppBar(title: "App Update", pageName: "/setting"),
          SizedBox(height: screenHeight * .03),
          Text("App version", style: FlexiFont.displayRegular14),
          SizedBox(height: screenHeight * .01),
          FlexiTextField(
            width: screenWidth * .88,
            height: screenHeight * .06,
            fillColor: Colors.white,
            border: Border.all(color: FlexiColor.grey[400]!),
            borderRadius: BorderRadius.circular(screenHeight *.01),
            textEditingController: TextEditingController(text: "V0.0.1"),
            contentPadding: EdgeInsets.only(left: 12, top: screenHeight * .02, bottom: screenHeight * .02),
          ),
          SizedBox(height: screenHeight * .02),
          FlexiTextButton(
            width: screenWidth * .88,
            height: screenHeight * .06,
            fillColor: FlexiColor.primary,
            text: Text("Check For Updates", style: FlexiFont.textButtonSemibold16.copyWith(color: Colors.white)),
            onTap: () {}
          )
        ]
      ),
    );
  }

}