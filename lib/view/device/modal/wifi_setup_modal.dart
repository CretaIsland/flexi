import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../main.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';



class WifiSetupModal extends ConsumerWidget {
  const WifiSetupModal({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: screenWidth * .93,
      height: screenHeight * .4,
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .05, right: screenWidth * .055),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenHeight * .025)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Wifi Setup", style: FlexiFont.semiBold24),
          const SizedBox(height: 14),
          Text("Press Connect once \nthe device has rebooted.", style: FlexiFont.regular16),
          SizedBox(height: screenHeight * .04),
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
          SizedBox(height: screenHeight * .01),
          Center(
            child: TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text("Cancel", style: FlexiFont.regular16),
            ),
          )
        ],
      ),
    );
  }

}
