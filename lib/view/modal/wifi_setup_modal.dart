import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';

class WifiSetupModal extends StatelessWidget {
  
  const WifiSetupModal({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * .93,
      height: screenHeight * .33,
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.only(top: screenHeight * .05, left: screenWidth * .06),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenHeight * .025),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Wifi Setup", style: FlexiFont.semiBold24),
          SizedBox(height: screenHeight * .025),
          Text("Press Connect once \nthe device has rebooted.", style: FlexiFont.regular16,),
          SizedBox(height: screenHeight * .035),
          SizedBox(
            width: screenWidth * .82,
            height: screenHeight * .06,
            child: TextButton(
              onPressed: () {
                context.pop();
                context.go("/device/list");
              }, 
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenHeight * .01))
                ),
                backgroundColor: MaterialStateProperty.all(FlexiColor.primary),
              ), 
              child: Text("Connect", style: FlexiFont.semiBold16.copyWith(color: Colors.white))
            ),
          ),
          SizedBox(
            width: screenWidth * .82,
            height: screenHeight * .06,
            child: TextButton(
              onPressed: () => context.pop(), 
              child: Text("Cancel", style: FlexiFont.regular16)
            ),
          )
        ],
      ),
    );
  }

}