import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/ui/colors.dart';
import '../utils/ui/fonts.dart';



class FlexiTextField extends StatelessWidget {
  const FlexiTextField({super.key, required this.width, required this.height, this.controller, this.readOnly = false, this.textStyle, this.fillColor = Colors.white, this.onChanged, this.onComplete});
  final double width;
  final double height;
  final TextEditingController? controller;
  final bool readOnly;
  final TextStyle? textStyle;
  final Color? fillColor;
  final void Function(String)? onChanged;
  final void Function()? onComplete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        style: textStyle ?? FlexiFont.regular16,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 12),
          fillColor: fillColor,
          filled: true,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(.01.sh),
            borderSide: BorderSide(color: FlexiColor.grey[400]!)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(.01.sh),
            borderSide: BorderSide(color: FlexiColor.grey[400]!)
          ),
        ),
        onChanged: onChanged,
        onEditingComplete: onComplete,
      ),
    );
  }
}