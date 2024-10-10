import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class FlexiTextButton extends StatelessWidget {
  const FlexiTextButton({super.key, required this.width, required this.height, required this.text, this.backgroundColor = Colors.white, this.textColor = Colors.white, this.onPressed});
  final double width;
  final double height;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed, 
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(.01.sh)
            )
          )
        ),
        child: Text(text, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor))
      )
    );
  }
}