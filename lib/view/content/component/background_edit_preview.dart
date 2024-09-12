import 'dart:convert';

import 'package:flexi/feature/content/model/content_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../util/design/colors.dart';
import 'content_clipper.dart';



class BackgroundEditPreview extends StatefulWidget {
  const BackgroundEditPreview({super.key,required this.content});
  final ContentModel content;

  @override
  State<BackgroundEditPreview> createState() => _BackgroundEditPreviewState();
}

class _BackgroundEditPreviewState extends State<BackgroundEditPreview> {

  late double _contentWidth;
  late double _contentHeight;
  late double _textScaler;

  @override
  void initState() {
    super.initState();
    var _aspectRatio = widget.content.width / widget.content.height;
    _contentWidth = widget.content.width <= 360 ? 1.sw : (1.sw / 360) * widget.content.width;
    _contentHeight = _contentWidth / _aspectRatio;
    if(_contentHeight > widget.content.height) {
      _textScaler = _contentHeight / widget.content.height;
    } else {
      _textScaler = widget.content.height / _contentHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: .2.sh,
      color: Colors.black.withOpacity(.6),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: 1.sw,
              height: (_contentHeight + .005.sh) * (widget.content.width / 360).ceil()
            ),
            ...chunkContent(
              width: _contentWidth,
              height: _contentHeight,
              content: Container(
                width: _contentWidth,
                height: _contentHeight,
                decoration: BoxDecoration(
                  color: FlexiColor.stringToColor(widget.content.backgroundColor),
                  image: widget.content.backgroundType != 'color' && widget.content.fileThumbnail != null ?
                    DecorationImage(
                      image: Image.memory(base64Decode(widget.content.fileThumbnail!)).image,
                      fit: BoxFit.cover
                    ) : null
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: (_contentWidth / widget.content.width) * widget.content.x,
                    top: (_contentHeight / widget.content.height) * widget.content.y
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.content.text,
                      style: TextStyle(
                        fontSize: widget.content.textSize * _textScaler,
                        fontWeight: widget.content.bold ? FontWeight.bold : FontWeight.normal,
                        fontStyle: widget.content.italic ? FontStyle.italic : FontStyle.normal,
                        color: FlexiColor.stringToColor(widget.content.textColor)
                      )
                    )
                  )
                )
              )
            )
          ]
        )
      )
    );
  }

  List<Widget> chunkContent({required double width, required double height, required Widget content}) {
    List<Widget> chunks = [];

    if(widget.content.width <= 360) return [content];
    
    for(int i = 0; i < widget.content.width ~/ 360; i++) {
      chunks.add(
        Positioned(
          left: i * -1.sw,
          top: (i * height) + (i * .005.sh),
          child: ClipRect(
            clipper: ContentClipper(dx: (i * 1.sw), width: 1.sw, height: height),
            child: content,
          ),
        )
      );
    }

    if(widget.content.width % 360 != 0.0) {
      chunks.add(
        Positioned(
          left: chunks.length * -1.sw,
          top: chunks.length * (height + .005.sh),
          child: ClipRect(
            clipper: ContentClipper(dx: (chunks.length * 1.sw), width: width % 1.sw, height: height),
            child: content,
          ),
        )
      );
    }

    return chunks;
  }
  
}