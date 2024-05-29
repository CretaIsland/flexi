import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';



class LanguageListBar extends ConsumerWidget {
  LanguageListBar({super.key});
  final Map<String, String> languageList = {
    '한국어': '',
    'English': '',
    '日本語': '',
    '中文': '',
    'français': ''
  };


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          languageButton('English'),
          languageButton('한국어'),
          languageButton('日本語'),
          PopupMenuButton<String>(
            itemBuilder: (context) => popupMenuItems(),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: FlexiColor.grey[600]!),
              borderRadius: BorderRadius.circular(.01.sh)
            ),
            padding: EdgeInsets.all(.005.sh),
            position: PopupMenuPosition.under,
            color: Colors.white,
            child: Container(
              width: .04.sh,
              height: .04.sh,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(.005.sh)
              ),
              child: Center(
                child: Icon(Icons.more_horiz_rounded, color: FlexiColor.grey[600])
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget languageButton(String label) {
    return InkWell(
      onTap: () { },
      child: Container(
        width: .25.sw,
        height: .04.sh,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(.01.sh)
        ),
        child: Center(
          child: Text(label, style: FlexiFont.regular14),
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> popupMenuItems() {
    List<PopupMenuItem<String>> items = [];
    languageList.forEach((key, value) {
      items.add(PopupMenuItem(
        height: .04.sh,
        value: value,
        child: Text(key, style: FlexiFont.regular14)
      ));
    });
    return items;
  }

}