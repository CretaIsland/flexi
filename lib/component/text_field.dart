import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../util/design/colors.dart';



class FlexiTextField extends StatelessWidget {
  const FlexiTextField({
    super.key,
    required this.width,
    required this.height,
    this.controller,
    this.hintText,
    this.readOnly = false,
    this.onChanged
  });
  final double width;
  final double height;
  final TextEditingController? controller;
  final String? hintText;
  final bool readOnly;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        cursorWidth: 1.0,
        readOnly: readOnly,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(decorationThickness: 0),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: .025.sw),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.grey[600]),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: FlexiColor.grey[400]!),
            borderRadius: BorderRadius.circular(.01.sh)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: FlexiColor.grey[400]!),
            borderRadius: BorderRadius.circular(.01.sh)
          )
        ),
        onChanged: onChanged
      )
    );
  }
}