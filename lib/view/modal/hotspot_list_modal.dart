import 'package:flexi/component/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../component/circle_icon_button.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';


class HotspotListModal extends ConsumerWidget {

  const HotspotListModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: screenWidth,
      height: screenHeight * .9,
      padding: EdgeInsets.only(top: screenHeight * .07, left: screenWidth * .055, right: screenWidth * .055),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(screenHeight * .025), topRight: Radius.circular(screenHeight * .025)),
        color: FlexiColor.screenColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Device to use \nwith Digital Barricade", style: FlexiFont.regular20),
          SizedBox(height: screenHeight * .02),
          FlexiSearchBar(hintText: "Search your device", searchTextController: TextEditingController()),
          SizedBox(height: screenHeight * .03),
          Container(
            width: screenWidth * .88,
            height: screenHeight * .54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenHeight * .01),
              color: Colors.white
            ),
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: screenHeight * .02, left: 16, bottom: screenHeight * .02),
                  child: Row(
                    children: [
                      CircleIconButton(
                        size: screenHeight * .02, 
                        icon: Icon(Icons.check, size: screenHeight * .01, color: FlexiColor.grey[600]),
                        border: Border.all(color: FlexiColor.grey[600]!),
                        fillColor: Colors.transparent,
                        onPressed: () { },
                      ),
                      const SizedBox(width: 14),
                      Icon(Icons.wifi, size: screenHeight * .02, color: Colors.black),
                      const SizedBox(width: 8),
                      Text('DBAP0001', style: FlexiFont.regular16)
                    ],
                  ),
                );
              }, 
              separatorBuilder: (BuildContext context, int index) {  
                return Divider(color: FlexiColor.grey[400]);
              },
            ),
          ),
          SizedBox(height: screenHeight * .02),
          SizedBox(
            width: screenWidth * .88,
            height: screenHeight * .06,
            child: TextButton(
              onPressed: () => context.go("/device/setTimezone"),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenHeight * .01))
                ),
                backgroundColor: MaterialStateProperty.all(FlexiColor.primary),
              ), 
              child: Text("Add", style: FlexiFont.semiBold16.copyWith(color: Colors.white))
            ),
          ),
        ],
      ),
    );
  }

}