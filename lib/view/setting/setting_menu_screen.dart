import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import '../../main.dart';
import '../../utils/ui/colors.dart';
import '../../utils/ui/fonts.dart';



class SettingMenuScreen extends ConsumerStatefulWidget {
  const SettingMenuScreen({super.key});

  @override
  ConsumerState<SettingMenuScreen> createState() => _SettingMenuScreenState();
}

class _SettingMenuScreenState extends ConsumerState<SettingMenuScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.backgroundColor,
      padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .065, right: screenWidth * .055),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Setting", style: FlexiFont.semiBold30),
          SizedBox(height: screenHeight * .05),
          textButton("Account", "/setting/account"),
          SizedBox(height: screenHeight * .03),
          textButton("Device Recovery", "/setting/deviceRecovery"),
          SizedBox(height: screenHeight * .03),
          textButton("App Update", "/setting/app"),
          SizedBox(height: screenHeight * .03),
        ],
      )
    );
  }

  Widget textButton(String btnLabel, String routeName) {
    return InkWell(
      onTap: () => context.go(routeName),
      child: Container(
        width: screenWidth * .89,
        height: screenHeight * .06,
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenHeight * .01)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(btnLabel, style: FlexiFont.regular14),
            Icon(Icons.arrow_forward_ios_outlined, color: FlexiColor.grey[600], size: screenHeight * .02)
          ],
        ),
      ),
    );
  }

}