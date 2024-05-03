import 'package:flutter/material.dart';

import '../utils/ui/colors.dart';
import '../utils/ui/fonts.dart';
import '../main.dart';



class FlexiSearchBar extends StatelessWidget {
  const FlexiSearchBar({super.key, this.hintText, this.textEditingController, this.onChanged, this.onComplete});

  final String? hintText;
  final TextEditingController? textEditingController;
  final void Function(String)? onChanged;
  final void Function()? onComplete;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * .89,
      height: screenHeight * .045,
      child: TextField(
        controller: textEditingController,
        style: FlexiFont.regular16,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          fillColor: FlexiColor.grey[400],
          filled: true,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight * .025),
            borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight * .025),
            borderSide: BorderSide.none
          ),
          hintText: hintText,
          hintStyle: FlexiFont.regular16.copyWith(color: FlexiColor.grey[700]),
          prefixIcon: Icon(Icons.search_outlined, color: FlexiColor.grey[700], size: screenHeight * .025)
        ),
        onChanged: onChanged,
        onEditingComplete: onComplete,
      )
    );
  }

}