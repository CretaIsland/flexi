import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/design/colors.dart';
import '../util/design/fonts.dart';



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
          hintText: hintText,
          hintStyle: FlexiFont.regular16.copyWith(color: FlexiColor.grey[700]),
          contentPadding: const EdgeInsets.only(left: 12),
          filled: true,
          fillColor: FlexiColor.grey[400],
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