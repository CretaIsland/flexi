import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../feature/content/model/content_model.dart';
import '../../../util/design/colors.dart';
import 'content_clipper.dart';



class BackgroundEditPreview extends ConsumerStatefulWidget {
  const BackgroundEditPreview({super.key, required this.content});
  final ContentModel content;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BackgroundEditPreviewState();
}

class _BackgroundEditPreviewState extends ConsumerState<BackgroundEditPreview> {

  late double _aspectRatio;
  late double _responsiveHeight;
  late double _responsiveWidth;
  late double _textScaler;

  @override
  void initState() {
    super.initState();
    _aspectRatio = widget.content.width / widget.content.height;
    _responsiveWidth = widget.content.width <= 360 ? 1.sw : (1.sw / 360) * widget.content.width;
    _responsiveHeight = _responsiveWidth / _aspectRatio;
    _textScaler = 0.0;
    if(_responsiveHeight > widget.content.height) {
      _textScaler = _responsiveHeight / widget.content.height;
    } else {
      _textScaler = widget.content.height / _responsiveHeight;
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
              height: (_responsiveHeight + .005.sh) * (widget.content.width / 360).ceil(),
            ),
            ...chunkContent(
              width: _responsiveWidth,
              height: _responsiveHeight,
              content: Container(
                width: _responsiveWidth,
                height: _responsiveHeight,
                decoration: BoxDecoration(
                  color: FlexiColor.stringToColor(widget.content.backgroundColor),
                  image: widget.content.backgroundType != 'color' && widget.content.fileThumbnail != null ?
                    DecorationImage(
                      image: Image.memory(base64Decode(widget.content.fileThumbnail!)).image,
                      fit: BoxFit.cover
                    ) : null
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: widget.content.x * 1.0, top: widget.content.y * 1.0),
                  child: Text(
                    widget.content.text,
                    style: TextStyle(
                      fontSize: widget.content.textSize * _textScaler,
                      fontWeight: widget.content.bold ? FontWeight.bold : FontWeight.normal,
                      fontStyle: widget.content.italic ? FontStyle.italic : FontStyle.normal,
                      color: FlexiColor.stringToColor(widget.content.textColor)
                    ),
                  ),
                )
              ),
            ),
          ],
        ),
      ),
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