import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';

class ContentDeleteModal extends StatelessWidget {
  const ContentDeleteModal({super.key});

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
          Text("Are you sure?", style: FlexiFont.semiBold24),
          SizedBox(height: screenHeight * .025),
          Text("This will delete the content stored \non your device.", style: FlexiFont.regular16,),
          SizedBox(height: screenHeight * .035),
          SizedBox(
            width: screenWidth * .82,
            height: screenHeight * .06,
            child: TextButton(
              onPressed: () {
                context.pop();
              }, 
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenHeight * .01))
                ),
                backgroundColor: MaterialStateProperty.all(FlexiColor.secondary),
              ), 
              child: Text("Delete", style: FlexiFont.semiBold16.copyWith(color: Colors.white))
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