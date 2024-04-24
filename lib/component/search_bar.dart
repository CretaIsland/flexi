import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/fonts.dart';
import '../main.dart';



class FlexiSearchBar extends StatelessWidget {
  const FlexiSearchBar({super.key, this.hintText, this.textEditingController, this.onChanged, this.onComplete});

  final String? hintText;
  final TextEditingController? textEditingController;
  final void Function(String)? onChanged;
  final void Function()? onComplete;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * .89,
      height: screenHeight * .045,
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: FlexiColor.grey[400],
        borderRadius: BorderRadius.circular(screenHeight * .025)
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: FlexiColor.grey[700], size: screenHeight * .025),
          SizedBox(
            width: screenWidth * .7,
            child: TextField(
              controller: textEditingController,
              style: FlexiFont.regular16,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: FlexiFont.regular16.copyWith(color: FlexiColor.grey[700])
              ),
              onChanged: onChanged,
              onEditingComplete: onComplete,
            ),
          )
        ],
      ),
    );
  }

}