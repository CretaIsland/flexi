import 'package:flexi/screen/page/setting/account_detail_page.dart';
import 'package:flexi/screen/page/setting/app_update_page.dart';
import 'package:flexi/screen/page/setting/device_recovery_page.dart';
import 'package:flexi/screen/utils/flexi_color.dart';
import 'package:flexi/screen/utils/flexi_font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../utils/flexi_page_manager.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: flexiPageManager,
      child: Consumer<FlexiPageManager>(
        builder: (context, flexiPageHandler, child) {
          switch(flexiPageHandler.currentPageName) {
            case "/setting/account" : 
              return const AccountDetailPage();
            case "/setting/device/recovery" : 
              return const DeviceRecoveryPage();
            case "/setting/version" :
              return const AppUpdatePage();
            default:
              return Container(
                color: FlexiColor.grey[200],
                padding: EdgeInsets.only(top: screenHeight * .065, left: screenWidth * .055, right: screenWidth * .055),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Setting", style: FlexiFont.displaySemibold20),
                    SizedBox(height: screenHeight * .05),
                    settingMenuBTN("Account", "/setting/account"),
                    SizedBox(height: screenHeight * .03),
                    settingMenuBTN("Device Recovery", "/setting/device/recovery"),
                    SizedBox(height: screenHeight * .03),
                    settingMenuBTN("App Update", "/setting/version")
                  ],
                ),
              );
          } 
        },
      ),
    );
  }


  
  Widget settingMenuBTN(String btnLabel, String pageName) {
    return GestureDetector(
      onTap: () => flexiPageManager.switchPage(pageName),
      child: Container(
        width: screenWidth * .88,
        height: screenHeight * .06,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: FlexiColor.grey[400]!),
          borderRadius: BorderRadius.circular(screenHeight * .01)
        ),
        child: Padding(
          padding: EdgeInsets.only(left: screenWidth * .052, right: screenWidth * .052),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(btnLabel, style: FlexiFont.textButtonRegular),
              Icon(Icons.arrow_forward_ios, color: FlexiColor.grey[500], size: screenHeight * .015)
            ],
          ),
        ),
      )
    );
  }


}