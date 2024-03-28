import 'package:flexi/main.dart';
import 'package:flexi/screen/utils/flexi_color.dart';
import 'package:flexi/screen/utils/flexi_font.dart';
import 'package:flutter/material.dart';

class FlexiAppBar extends StatelessWidget {
  
  const FlexiAppBar({super.key, required this.title, required this.pageName, this.actionButton});
  final String title;
  final String pageName;
  final Widget? actionButton;
  

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => flexiPageManager.switchPage(pageName), 
          icon: const Icon(Icons.arrow_back_ios, color: FlexiColor.primary),
          iconSize: screenHeight * .03
        ),
        Text(title, style: FlexiFont.appBarTitle),
        actionButton ?? SizedBox(width: screenHeight * .03)
      ],
    );
  }

}