import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/ui/font.dart';



class FlexiTextButton extends StatelessWidget {
  const FlexiTextButton({super.key, required this.width, required this.height, this.backgroundColor, this.textColor = Colors.white, required this.text, this.onPressed});
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
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
          backgroundColor: WidgetStateProperty.all(backgroundColor)
        ),
        child: Text(text, style: FlexiFont.semiBold16.copyWith(color: textColor)),
      ),
    );
  }

}