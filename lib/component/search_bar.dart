import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../util/design/colors.dart';



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
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(decorationThickness: 0),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: .025.sw),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.grey[700]),
          filled: true,
          fillColor: FlexiColor.grey[400],
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(.025.sh)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(.025.sh)
          ),
          prefixIcon: Icon(Icons.search, size: .025.sh, color: FlexiColor.grey[700])
        ),
        onChanged: onChanged
      )
    );
  }
}