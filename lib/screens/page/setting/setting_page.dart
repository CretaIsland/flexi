import 'package:flexi/screens/utils/flexi_color.dart';
import 'package:flexi/screens/utils/flexi_font.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  late double screenWidth, screenHeight;


  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * .065, left: screenWidth * .055),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Setting", style: TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.medium, fontSize: screenHeight * .0375, color: Colors.black)),
          SizedBox(height: screenHeight * .05),
          settingMenuBTN("Account", "/setting/account"),
          SizedBox(height: screenHeight * .03),
          settingMenuBTN("Device Recovery", "/setting/device/recovery"),
          SizedBox(height: screenHeight * .03),
          settingMenuBTN("App Update", "/setting/app/version")
        ],
      ),
    );
  }

  Widget settingMenuBTN(String btnLabel, String pageName) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, pageName);
      },
      child: Container(
        width: screenWidth * .88,
        height: screenHeight * .06,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(screenWidth * .02)
        ),
        child: Padding(
          padding: EdgeInsets.only(left: screenWidth * .05, right: screenWidth * .05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(btnLabel, style: TextStyle(fontFamily: FlexiFont.fontFamily, fontWeight: FlexiFont.regular, fontSize: screenHeight * .0175, color: Colors.black)),
              Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400, size: screenHeight * .015)
            ],
          ),
        ),
      ),
    );
  }


}