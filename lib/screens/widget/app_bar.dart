import 'package:flexi/main.dart';
import 'package:flexi/screens/utils/flexi_color.dart';
import 'package:flexi/screens/utils/flexi_font.dart';
import 'package:flutter/material.dart';

class FlexiAppBar extends StatelessWidget {
  
  const FlexiAppBar({super.key, required this.title, this.actionBtn});
  final String title;
  final Widget? actionBtn;
  

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(
            Icons.arrow_back_ios,
            color: FlexiColor.primary
          ),
          iconSize: screenHeight * .02
        ),
        Text(title, style: TextStyle(
          fontFamily: FlexiFont.fontFamily, 
          fontWeight: FlexiFont.medium, 
          fontSize: screenHeight * .028, 
          color: Colors.black
        )),
        actionBtn ?? SizedBox(width: screenHeight * .04)
      ],
    );
  }

}