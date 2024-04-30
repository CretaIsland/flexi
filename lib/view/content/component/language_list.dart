import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';

class LanguageList extends ConsumerWidget {
  LanguageList({super.key});

  final Map<String, String> languageList = {
    "한국어" : "KOR", 
    "English" : "ENG",
    "日本語" : "JP",
    "中文" : "CN",
    "français" : "FR"
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currentLanguageButton("한국어"),
        currentLanguageButton("English"),
        currentLanguageButton("日本語"),
        PopupMenuButton<String>(
          onSelected: (value) {
            // ... (이전 코드와 동일)
          },
          itemBuilder: (context) {
            return getPopupMenuItem();
          },
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: FlexiColor.grey[600]!),
            borderRadius: BorderRadius.circular(7),
          ),
          padding: const EdgeInsets.all(5),
          position: PopupMenuPosition.under,
          color: Colors.white,
          child: Container(
            width: screenWidth * .088,
            height: screenHeight * .04,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenHeight * .005)
            ),
            child: Center(
              child: Icon(Icons.more_horiz_rounded, color: FlexiColor.grey[600])
            ),
          ) // 버튼 아래 50픽셀 오프셋
        ),
      ],
    );
  }

  List<PopupMenuEntry<String>> getPopupMenuItem() {
    List<PopupMenuItem<String>> menuItems = [];

    languageList.forEach((key, value) {
      menuItems.add(PopupMenuItem(
        height: screenHeight * .04,
        value: value,
        child: Text(key, style: FlexiFont.regular14),
      ));
    });

    return menuItems;
  }

  Widget currentLanguageButton(String btnLabel) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        width: screenWidth * .24,
        height: screenHeight * .04,
        decoration: BoxDecoration(
          color: Colors.white,
          border: null,
          borderRadius: BorderRadius.circular(screenHeight * .005)
        ),
        child: Center(
          child: Text(btnLabel, style: FlexiFont.regular14)
        ),
      ),
    );
  }

}