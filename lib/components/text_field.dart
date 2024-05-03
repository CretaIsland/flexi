import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/ui/colors.dart';



class FlexiTextField extends StatefulWidget {
  const FlexiTextField({super.key, required this.width, required this.height, this.textEditingController, this.readOnly, this.textStyle, this.onChanged, this.onComplete});
  final double width;
  final double height;
  final TextEditingController? textEditingController;
  final bool? readOnly;
  final TextStyle? textStyle;
  final void Function(String)? onChanged;
  final void Function()? onComplete;

  @override
  State<FlexiTextField> createState() => _FlexiTextFieldState();
}

class _FlexiTextFieldState extends State<FlexiTextField> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextField(
        controller: widget.textEditingController,
        readOnly: widget.readOnly ?? false,
        style: widget.textStyle,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 12),
          fillColor: Colors.white,
          filled: true,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight * .01),
            borderSide: BorderSide(color: FlexiColor.grey[400]!)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight * .01),
            borderSide: BorderSide(color: FlexiColor.grey[400]!)
          ),
        ),
        onChanged: widget.onChanged,
        onEditingComplete: widget.onComplete,
      ),
    );
  }

}