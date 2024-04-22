import 'package:flexi/main.dart';
import 'package:flexi/utils/colors.dart';
import 'package:flutter/material.dart';



class FlexiTextField extends StatefulWidget {
  const FlexiTextField({
    super.key, 
    required this.width, 
    required this.height,
    required this.textEditingController, 
    this.readOnly = false, 
    this.fontStyle,
    this.onChanged, 
    this.onEditingComplete
  });
  
  final double width;
  final double height;
  final TextEditingController textEditingController;
  final bool readOnly;
  final TextStyle? fontStyle;
  final Function(String)? onChanged;
  final void Function()? onEditingComplete;

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
        readOnly: widget.readOnly,
        style: widget.fontStyle,
        maxLines: 1,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight * .01),
            borderSide: BorderSide(color: FlexiColor.grey[400]!)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight * .01),
            borderSide: BorderSide(color: FlexiColor.grey[400]!)
          ),
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true
        ),
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
      ),
    );
  }
}