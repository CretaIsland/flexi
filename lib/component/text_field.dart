import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/ui/color.dart';



class FlexiTextField extends StatelessWidget {
  const FlexiTextField({super.key, this.width, this.height, this.controller, this.readOnly = false, this.textStyle, this.hintText, this.hintTextStyle, this.backgroundColor = Colors.white, this.onChanged});
  final double? width;
  final double? height;
  final TextEditingController? controller;
  final bool readOnly;
  final TextStyle? textStyle;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final Color? backgroundColor;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? .89.sw,
      height: height ?? .06.sh,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        style: textStyle,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 12),
          hintText: hintText,
          hintStyle: hintTextStyle,
          filled: true,
          fillColor: backgroundColor,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(.01.sh),
            borderSide: BorderSide(color: FlexiColor.grey[400]!)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(.01.sh),
            borderSide: BorderSide(color: FlexiColor.grey[400]!)
          )
        ),
        onChanged: onChanged
      )
    );
  }

}