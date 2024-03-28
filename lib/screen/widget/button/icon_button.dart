import 'package:flutter/material.dart';

class FlexiIconButton extends StatelessWidget {
  
  const FlexiIconButton({super.key, required this.width, required this.height, this.fillColor, this.border, this.borderRadius, required this.icon, this.onPressed});
  final double width;
  final double height;
  final Color? fillColor;
  final Border? border;
  final BorderRadius? borderRadius;
  final Icon icon;
  final void Function()? onPressed;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: fillColor,
        border: border,
        borderRadius: borderRadius
      ),
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }

}