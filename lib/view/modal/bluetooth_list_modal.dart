
import 'package:flexi/main.dart';
import 'package:flexi/utils/colors.dart';
import 'package:flexi/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BluetoothListModal extends ConsumerWidget {
  const BluetoothListModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: screenWidth,
      height: screenHeight * .9,
      padding: EdgeInsets.only(left: screenWidth * .055, right: screenWidth * .055),
      decoration: BoxDecoration(
        color: FlexiColor.screenColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(screenHeight * .025), topRight:  Radius.circular(screenHeight * .025))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * .07),
          Container(
            width: screenWidth * .89,
            height: screenHeight * .06,
            padding: EdgeInsets.only(left: screenWidth * .04, right: screenWidth * .04),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenHeight * .01)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Device's Bluetooth", style: FlexiFont.regular14,),
                AdvancedSwitch(
                  width: screenWidth * .11,
                  height: screenHeight * .025,
                  activeColor: FlexiColor.primary,
                  onChanged: (value) {},
                )
              ],
            ),
          ),
          SizedBox(height: screenHeight * .025),
          Text("Connected Device", style: FlexiFont.regular14),
          SizedBox(height: screenHeight * .01),
          Container(
            width: screenWidth * .89,
            height: screenHeight * .06,
            padding: EdgeInsets.only(left: screenWidth * .045),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenHeight * .01),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Device name", style: FlexiFont.regular16.copyWith(color: FlexiColor.primary))),
          ),
          SizedBox(height: screenHeight * .025),
          Text("Saved Devices", style: FlexiFont.regular14),
          SizedBox(height: screenHeight * .01),
          Container(
            width: screenWidth * .89,
            height: screenHeight * .25,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenHeight * .01)
            ),
            child: ListView.separated(
              itemCount: 5,
              itemBuilder:(context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: screenHeight * .015, left: screenWidth * .045, bottom: screenHeight * .015),
                  child: Text('Bluetooth Device Name', style: FlexiFont.regular16),
                );
              },
              separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400]), 
            ),
          ),
          SizedBox(height: screenHeight * .02),
          Row(
            children: [
              Text("Available Devices", style: FlexiFont.regular14),
              IconButton(
                onPressed: () {}, 
                icon: Icon(Icons.refresh, color: FlexiColor.grey[600]),
                iconSize: screenHeight * .02,
              )
            ],
          ),
          Container(
            width: screenWidth * .89,
            height: screenHeight * .25,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenHeight * .01)
            ),
            child: ListView.separated(
              itemCount: 5,
              itemBuilder:(context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: screenHeight * .015, left: screenWidth * .045, bottom: screenHeight * .015),
                  child: Text('Bluetooth Device Name', style: FlexiFont.regular16),
                );
              },
              separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400]), 
            ),
          )
        ],
      ),
    );
  }

}