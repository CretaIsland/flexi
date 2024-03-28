import 'package:flexi/screen/utils/flexi_font.dart';
import 'package:flutter/material.dart';


class FlexiButtonTextField extends StatefulWidget {
  
  const FlexiButtonTextField({
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
    this.fillColor,
    required this.actionButton
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
  final Widget actionButton;

  @override
  State<FlexiButtonTextField> createState() => _FlexiButtonTextFieldState();
}

class _FlexiButtonTextFieldState extends State<FlexiButtonTextField> {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: widget.width * .7,
            height: widget.height,
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
          ),
          widget.actionButton
        ],
      ),
    );
  }
}