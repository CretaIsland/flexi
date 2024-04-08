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
      height: screenHeight * .045,
      decoration: BoxDecoration(
        color: FlexiColor.grey[400],
        borderRadius: BorderRadius.circular(screenHeight * .025)
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(Icons.search, color: FlexiColor.grey[700], size: screenHeight * .025),
          SizedBox(
            width: screenWidth * .6,
            child: TextField(
              controller: searchTextController,
              style: FlexiFont.regular16,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 4, bottom: screenHeight * .010625),
                hintText: hintText,
                hintStyle: FlexiFont.regular16.copyWith(color: FlexiColor.grey[700]),
                border: InputBorder.none
              ),
            ),
          )
        ],
      ),
    );
  }
}