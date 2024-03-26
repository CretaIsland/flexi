import 'package:flutter/material.dart';

class FlexiTextButton extends StatelessWidget {
  const FlexiTextButton({super.key, required this.width, required this.height, this.text, this.fillColor, this.border, this.onTap});
  final double width;
  final double height;
  final Text? text;
  final Color? fillColor;
  final Border? border;
  final GestureTapCallback? onTap;
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: fillColor,
          border: border,
          borderRadius: BorderRadius.circular(width * .025)
        ),
        child: Center(
          child: text,
        ),
      ),
    );
  }
}