import 'package:flexi/utils/colors.dart';
import 'package:flexi/utils/fonts.dart';
import 'package:flexi/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeviceResetModal extends StatelessWidget {

  const DeviceResetModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * .34,
      margin: EdgeInsets.only(left: screenWidth * .033, right: screenWidth * .033, bottom: screenHeight * .02),
      padding: EdgeInsets.only(left: screenWidth * .055, right: screenWidth * .055, top: screenHeight * .05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenHeight * .025)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: screenWidth * .033),
            child: Text("Are you sure?", style: FlexiFont.semiBold24),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * .033, top: screenHeight * .025, bottom: screenHeight * .04),
            child: Text("This will reset the wifi credentials \nof the device(s)", style: FlexiFont.regular16),
          ),
          SizedBox(
            width: screenWidth * .82,
            height: screenHeight * .06,
            child: TextButton(
              onPressed: () { context.pop(); }, 
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenHeight * .01))
                ),
                backgroundColor: MaterialStateProperty.all(FlexiColor.secondary),
              ), 
              child: Text("Add", style: FlexiFont.semiBold16.copyWith(color: Colors.white))
            ),
          ),
          SizedBox(height: screenHeight * .01),
          SizedBox(
            width: screenWidth * .82,
            height: screenHeight * .025,
            child: TextButton(
              onPressed: () { context.pop(); }, 
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ), 
              child: Text("Cancel", style: FlexiFont.regular16)
            ),
          )
        ],
      ),
    );
  }

}