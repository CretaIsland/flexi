import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/ui/colors.dart';
import '../utils/ui/fonts.dart';



class FlexiSearchBar extends StatelessWidget {
  const FlexiSearchBar({super.key, this.hintText, this.controller, this.onChanged, this.onComplete});
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onComplete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: .89.sw,
      height: .045.sh,
      child: TextField(
        controller: controller,
        style: FlexiFont.regular16,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: FlexiFont.regular16.copyWith(color: FlexiColor.grey[700]),
          contentPadding: EdgeInsets.zero,
          fillColor: FlexiColor.grey[400],
          filled: true,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(.025.sh),
            borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(.025.sh),
            borderSide: BorderSide.none
          ),
          prefixIcon: Icon(Icons.search_outlined, color: FlexiColor.grey[700], size: .025.sh)
        ),
        onChanged: onChanged,
        onEditingComplete: onComplete,
      )
    );
  }
}