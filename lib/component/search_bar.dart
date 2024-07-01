import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/ui/color.dart';
import '../utils/ui/font.dart';



class FlexiSearchBar extends StatelessWidget {
  const FlexiSearchBar({super.key, this.hintText, this.onChanged});
  final String? hintText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: .89.sw,
      height: .045.sh,
      child: TextField(
        style: FlexiFont.regular16,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 12),
          hintText: hintText,
          hintStyle: FlexiFont.regular16.copyWith(color: FlexiColor.grey[700]),
          filled: true,
          fillColor: FlexiColor.grey[400],
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
        onChanged: onChanged
      )  
    );
  }

}