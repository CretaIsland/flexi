import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../component/language_list.dart';



class TranslateTextModal extends ConsumerWidget {
  const TranslateTextModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: screenWidth,
      height: screenHeight * .9,
      padding: EdgeInsets.only(left: screenWidth * .055, top: 8, right: screenWidth * .055),
      decoration: BoxDecoration(
        color: FlexiColor.screenColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(screenHeight * .025), topRight: Radius.circular(screenHeight * .025))
      ),
      child: Column(
        children: [
          Container(
            width: screenWidth * .14,
            height: screenHeight * .005,
            decoration: BoxDecoration(
              color: FlexiColor.grey[500],
              borderRadius: BorderRadius.circular(screenHeight * .0025)
            ),
          ),
          SizedBox(height: screenHeight * .06),
          LanguageList(),
          SizedBox(height: screenHeight * .02),
          Container(
            width: screenWidth * .88,
            height: screenHeight * .225,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: FlexiColor.grey[400]!),
              borderRadius: BorderRadius.circular(screenHeight * .01)
            ),
          ),
          SizedBox(height: screenHeight * .04),
          Icon(Icons.arrow_drop_down, color: FlexiColor.primary, size: screenHeight * .05),
          SizedBox(height: screenHeight * .04),
          LanguageList(),
          SizedBox(height: screenHeight * .02),
          Container(
            width: screenWidth * .88,
            height: screenHeight * .225,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: FlexiColor.grey[400]!),
              borderRadius: BorderRadius.circular(screenHeight * .01)
            ),
          ),
          SizedBox(height: screenHeight * .03),
          SizedBox(
            width: screenWidth * .88,
            height: screenHeight * .06,
            child: TextButton(
              onPressed: () => context.pop(),
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