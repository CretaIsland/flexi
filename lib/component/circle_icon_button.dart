import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({super.key, required this.size, required this.icon, this.fillColor, this.border, this.onPressed});

  final double size;
  final Icon icon;
  final Color? fillColor;
  final Border? border;
  final void Function()? onPressed;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: fillColor,
          border: border,
          borderRadius: BorderRadius.circular(size / 2)
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }

}