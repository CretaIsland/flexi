import 'package:flexi/screen/utils/flexi_font.dart';
import 'package:flutter/material.dart';


class FlexiTextField extends StatefulWidget {

  const FlexiTextField({
    super.key, 
    required this.width, 
    required this.height, 
    required this.textEditingController, 
    this.valueTextStyle, 
    this.labelTextStyle, 
    this.label, 
    this.contentPadding,
    this.border, 
    this.borderRadius, 
    this.fillColor
  });

  final double width;
  final double height;
  final TextEditingController textEditingController;
  final TextStyle? valueTextStyle;
  final TextStyle? labelTextStyle;
  final String? label;
  final EdgeInsets? contentPadding;
  final Border? border;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  
  @override
  State<FlexiTextField> createState() => _FlexiTextFieldState();
  
}

class _FlexiTextFieldState extends State<FlexiTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        border: widget.border,
        borderRadius: widget.borderRadius,
        color: widget.fillColor
      ),
      child: TextField(
        controller: widget.textEditingController,
        style: widget.valueTextStyle ?? FlexiFont.textFieldRegular,
        decoration: InputDecoration(
          contentPadding: widget.contentPadding,
          hintText: widget.label,
          hintStyle: widget.labelTextStyle ?? FlexiFont.textFieldRegular.copyWith(color: Colors.black.withOpacity(0.5)),
          border: InputBorder.none
        ),
      ),
    );
  }
}