import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/design/colors.dart';



class FlexiTextField extends StatelessWidget {
  const FlexiTextField({super.key, required this.width, required this.height, this.controller, this.hintText, this.backgroundColor = Colors.white, this.textStyle, this.readOnly = false,this.onChanged});
  final double width;
  final double height;
  final TextEditingController? controller;
  final String? hintText;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final bool readOnly;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textStyle,
          contentPadding: const EdgeInsets.only(left: 12),
          filled: true,
          fillColor: backgroundColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(.01.sh),
            borderSide: BorderSide(color: FlexiColor.grey[400]!)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(.01.sh),
            borderSide: BorderSide(color: FlexiColor.grey[400]!)
          )
        ),
        style: textStyle,
        readOnly: readOnly,
        onChanged: onChanged
      ),
    );
  }

}