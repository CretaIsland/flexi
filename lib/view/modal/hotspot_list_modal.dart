import 'package:flexi/component/circle_icon_button.dart';
import 'package:flexi/component/search_bar.dart';
import 'package:flexi/utils/colors.dart';
import 'package:flexi/utils/fonts.dart';
import 'package:flexi/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HotSpotListModal extends ConsumerWidget {

  const HotSpotListModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: screenHeight * .9,
      padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .01, right: screenWidth * .055),
      decoration: BoxDecoration(
        color: FlexiColor.screenColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(screenHeight * .025), topRight: Radius.circular(screenHeight * .025))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * .145,
            height: screenHeight * .005,
            margin: EdgeInsets.only(left: screenWidth * .37, bottom: screenHeight * .055),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(.0025),
              color: FlexiColor.grey[500]
            ),
          ),
          Text("Device to use \nwith Digital Barricade", style: FlexiFont.regular16),
          SizedBox(height: screenHeight * .02),
          FlexiSearchBar(hintText: "Search your Devices", searchTextController: TextEditingController()),
          SizedBox(height: screenHeight * .02),
          Container(
            width: screenHeight * .88,
            height: screenHeight * .53,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenHeight * .01)
            ),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return SizedBox(
                  height: screenHeight * .065,
                  child: Row(
                    children: [
                      SizedBox(width: screenWidth * .033),
                      CircleIconButton(
                        size: screenHeight * .02, 
                        icon: Icon(Icons.check, color: FlexiColor.grey[600], size: screenHeight * .01),
                        fillColor: null,
                        border: Border.all(color: FlexiColor.grey[600]!),
                        onPressed: () { },
                      ),
                      SizedBox(width: screenWidth * .033),
                      Icon(Icons.wifi_rounded, size: screenHeight * .0225, color: Colors.black),
                      SizedBox(width: screenWidth * .022),
                      Text("DBAP0001", style: FlexiFont.regular16)
                    ],
                  ),
                );
              }, 
              separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400]), 
              itemCount: 10
            ),
          ),
          SizedBox(height: screenHeight * .02),
          SizedBox(
            width: screenWidth * .89,
            height: screenHeight * .06,
            child: TextButton(
              onPressed: () { context.pop(); }, 
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenHeight * .01))
                ),
                backgroundColor: MaterialStateProperty.all(FlexiColor.primary),
              ), 
              child: Text("Add", style: FlexiFont.semiBold16.copyWith(color: Colors.white))
            ),
          )
        ],
      ),
    );
  }

}