import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../feature/content/model/content_model.dart';
import '../../../util/utils.dart';



class ContentPreview extends ConsumerStatefulWidget {
  const ContentPreview(this.width, this.height, this.content, {super.key,});
  final double width;
  final double height;
  final ContentModel content;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentPreviewState();
}

class _ContentPreviewState extends ConsumerState<ContentPreview> {

  late ScrollController _contentScroller;
  late ScrollController _textScroller;
  late double _aspectRatio;
  late double _responsiveHeight;
  late double _responsiveWidth;
  late double _textScaler;

  bool _contentScrollEnd = false;
  bool _isTextOverflow = false;

  @override
  void initState() {
    super.initState();
    _contentScroller = ScrollController();
    _textScroller = ScrollController();

    _aspectRatio =  widget.content.width / widget.content.height;
    _responsiveHeight = widget.height;
    _responsiveWidth = _responsiveHeight * _aspectRatio;
    if(_responsiveHeight > widget.content.height) {
      _textScaler = _responsiveHeight / widget.content.height;
    } else {
      _textScaler = widget.content.height / _responsiveHeight;
    } 
  }

  @override
  void dispose() {
    super.dispose();
    _contentScroller.removeListener(_handleContentScroll);
    _textScroller.removeListener(_handleTextScroll);
    _contentScroller.dispose();
    _textScroller.dispose();
  }

  void _handleContentScroll() {
    if(_contentScroller.position.atEdge && _contentScroller.position.pixels != 0 && _textScroller.position.pixels == 0) {
      setState(() {
        _contentScrollEnd = true;
      });
    }
  }

  void _handleTextScroll() {
    print(_textScroller.position.pixels);
    if(_textScroller.position.pixels == 0) {
      setState(() {
        _contentScrollEnd = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: SingleChildScrollView(
        controller: _contentScroller,
        scrollDirection: Axis.horizontal,
        physics: _contentScrollEnd ? const NeverScrollableScrollPhysics() : null,
        child: Container(
          width: _responsiveWidth,
          height: _responsiveHeight,
          decoration: BoxDecoration(
            color: FlexiUtils.stringToColor(widget.content.backgroundColor),
            image: widget.content.backgroundType != 'color' && widget.content.fileThumbnail != null ? DecorationImage(
              image: Image.memory(base64Decode(widget.content.fileThumbnail!)).image,
              fit: BoxFit.cover
            ) : null
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final TextSpan textSpan = TextSpan(
                text: widget.content.text,
                style: TextStyle(
                  fontSize: _textScaler * widget.content.textSize,
                  color: FlexiUtils.stringToColor(widget.content.textColor),
                  fontWeight: widget.content.bold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: widget.content.italic ? FontStyle.italic : FontStyle.normal
                ),
              );
              final TextPainter textPainter = TextPainter(
                text: textSpan,
                maxLines: 1,
                textDirection: TextDirection.ltr,
              );
              textPainter.layout(maxWidth: constraints.maxWidth - (_responsiveWidth / widget.content.width) * widget.content.x);

              WidgetsBinding.instance.addPostFrameCallback((_) {
                final bool didOverflow = textPainter.didExceedMaxLines;
                if (didOverflow != _isTextOverflow) {
                  setState(() {
                    _isTextOverflow = didOverflow;
                  });

                  if (didOverflow) {
                    _contentScroller.addListener(_handleContentScroll);
                    _textScroller.addListener(_handleTextScroll);
                  }
                }
              });

              return Padding(
                padding: EdgeInsets.only(
                  left: (_responsiveWidth / widget.content.width) * widget.content.x,
                  top: (_responsiveHeight / widget.content.height) * widget.content.y
                ),
                child: SingleChildScrollView(
                  controller: _textScroller,
                  scrollDirection: Axis.horizontal,
                  physics: _contentScrollEnd ? null : const NeverScrollableScrollPhysics(),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.content.text, 
                      style: TextStyle(
                        fontSize: _textScaler * widget.content.textSize,
                        color: FlexiUtils.stringToColor(widget.content.textColor),
                        fontWeight: widget.content.bold ? FontWeight.bold : FontWeight.normal,
                        fontStyle: widget.content.italic ? FontStyle.italic : FontStyle.normal
                      ),
                    ),
                  )
                ),
              );
            }
          )
        ),
      ),
    );
  }

}