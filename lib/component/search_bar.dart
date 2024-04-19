import 'package:flexi/utils/colors.dart';
import 'package:flexi/utils/fonts.dart';
import 'package:flexi/main.dart';
import 'package:flutter/material.dart';


class FlexiSearchBar extends StatelessWidget {
  const FlexiSearchBar({super.key, required this.hintText, required this.searchTextController});
  final String hintText;
  final TextEditingController searchTextController;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * .89,
      height: screenHeight * .055,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenHeight * .035),
        color: FlexiColor.grey[400]
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(Icons.search, color: FlexiColor.grey[700], size: screenHeight * .025),
          const SizedBox(width: 10),
          SizedBox(
            width: screenWidth * .7,
            child: TextField(
              controller: searchTextController,
              style: FlexiFont.regular16,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: FlexiFont.regular16.copyWith(color: FlexiColor.grey[700]),
              ),
            ),
          ),        
        ],
      )
    );
  }

}