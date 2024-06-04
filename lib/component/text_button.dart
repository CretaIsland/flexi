import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/ui/font.dart';



class FlexiTextButton extends StatelessWidget {
  const FlexiTextButton({super.key, required this.width, required this.height, required this.text, this.textColor = Colors.white, this.fillColor, this.textStyle, this.onPressed});
  final double width;
  final double height;
  final String text;
  final Color? textColor;
  final Color? fillColor;
  final TextStyle? textStyle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(.01.sh))
          ),
          backgroundColor: WidgetStateProperty.all(fillColor),
        ), 
        child: Text(text, style: textStyle ?? FlexiFont.semiBold16.copyWith(color: textColor))
      ),
    );
  }
}