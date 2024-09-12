import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../feature/content/model/content_model.dart';
import '../../../util/design/colors.dart';



class ContentPreview extends ConsumerStatefulWidget {
  const ContentPreview({super.key, required this.width, required this.height, required this.content});
  final double width;
  final double height;
  final ContentModel content;
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentPreviewState();
}

class _ContentPreviewState extends ConsumerState<ContentPreview> {

  late double _contentWidth;
  late double _textScaler;

  @override
  void initState() {
    super.initState();
    
    _contentWidth = widget.height * (widget.content.width / widget.content.height);
    if(widget.height > widget.content.height) {
      _textScaler = widget.height / widget.content.height;
    } else {
      _textScaler = widget.content.height / widget.height;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: _contentWidth,
          height: widget.height,
          padding: EdgeInsets.only(
            left: (_contentWidth / widget.content.width) * widget.content.x,
            top: (widget.height / widget.content.height) * widget.content.y
          ),
          decoration: BoxDecoration(
            color: FlexiColor.stringToColor(widget.content.backgroundColor),
            image: widget.content.backgroundType != 'color' && widget.content.fileThumbnail != null ? DecorationImage(
              image: Image.memory(base64Decode(widget.content.fileThumbnail!)).image,
              fit: BoxFit.cover
            ) : null
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.content.text,
                style: TextStyle(
                  fontSize: (_textScaler * widget.content.textSize) - .0085.sh,
                  color: FlexiColor.stringToColor(widget.content.textColor),
                  fontWeight: widget.content.bold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: widget.content.italic ? FontStyle.italic : FontStyle.normal
                )
              )
            )
          )
        )
      )
    );
  }
}