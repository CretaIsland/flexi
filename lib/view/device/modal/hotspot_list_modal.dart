import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../component/search_bar.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';



class HotspotListModal extends ConsumerWidget {
  HotspotListModal({super.key});

  final selectedIndexProvider = StateProvider<int>((ref) => -1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: screenWidth,
      height: screenHeight * .9,
      decoration: BoxDecoration(
        color: FlexiColor.screenColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(screenHeight * .025), topRight: Radius.circular(screenHeight * .025))
      ),
      child: Column(
        children: [
          SizedBox(height: screenHeight * .01),
          Container(
            width: screenWidth * .14,
            height: screenHeight * .005,
            decoration: BoxDecoration(
              color: FlexiColor.grey[500],
              borderRadius: BorderRadius.circular(screenHeight * .0025)
            ),
          ),
          SizedBox(height: screenHeight * .055),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: screenWidth * .055),
              child: Text("Device to use \nwith Digital Barricade", style: FlexiFont.regular20, textAlign: TextAlign.left),
            )
          ),
          SizedBox(height: screenHeight * .02),
          FlexiSearchBar(hintText: "Search device", textEditingController: TextEditingController()),
          SizedBox(height: screenHeight * .03),
          Container(
            width: screenWidth * .89,
            height: screenHeight * .53,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenHeight * .01)
            ),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder:(context, index) => GestureDetector(
                onTap: () => ref.watch(selectedIndexProvider.notifier).state = index,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * .045, screenHeight * .02, screenWidth * .045, screenHeight * .02),
                  child: Row(
                    children: [
                      ref.watch(selectedIndexProvider) == index ? 
                        Icon(Icons.check_circle_rounded, color: FlexiColor.primary, size: screenHeight * .025) :
                        Icon(Icons.check_circle_outline_rounded, color: FlexiColor.grey[600], size: screenHeight * .025),
                      SizedBox(width: screenWidth * .038),
                      Icon(Icons.wifi_rounded, color: Colors.black, size: screenHeight * .025),
                      SizedBox(width: screenWidth * .022),
                      Text("DBAP0001", style: FlexiFont.regular16),
                    ],
                  ),
                ),
              ), 
              separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400]),
            ),
          ),
          SizedBox(height: screenHeight * .02),
          SizedBox(
            width: screenWidth * .89,
            height: screenHeight * .06,
            child: TextButton(
              onPressed: () {
                context.pop();
                context.go("/device/setTimezone");
              }, 
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