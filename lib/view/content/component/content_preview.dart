import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../feature/content/model/content_info.dart';
import '../../../utils/ui/colors.dart';



class ContentPreview extends ConsumerStatefulWidget {
  const ContentPreview({super.key, required this.previewWidth, required this.previewHeight, required this.contentInfo});
  final double previewWidth;
  final double previewHeight;
  final ContentInfo contentInfo;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentPreviewState();
}

class _ContentPreviewState extends ConsumerState<ContentPreview> {

  final _contentScrollEnd = StateProvider((ref) => false);
  late ScrollController _contentController;
  late ScrollController _textController;

  late double aspectRatio;
  late double responsiveHeight;
  late double responsiveWidth;
  late double textScaler;


  void _handleContentScroll() {
    if(_contentController.position.atEdge && _contentController.position.pixels != 0 && _textController.position.pixels != 0) {
      ref.watch(_contentScrollEnd.notifier).state = true;
    }
  }
  void _handleTextScroll() {
    if(_textController.position.pixels == 0) {
      ref.watch(_contentScrollEnd.notifier).state = false;
    }
  }

  @override
  void initState() {
    super.initState();
    aspectRatio =  widget.contentInfo.width / widget.contentInfo.height;
    responsiveHeight = widget.previewHeight;
    responsiveWidth = responsiveHeight * aspectRatio;
    if(responsiveHeight > widget.contentInfo.height) {
      textScaler = responsiveHeight / widget.contentInfo.height;
    } else {
      textScaler = widget.contentInfo.height / responsiveHeight;
    } 
    _contentController = ScrollController();
    _textController = ScrollController();
    _contentController.addListener(_handleContentScroll);
    _textController.addListener(_handleTextScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _contentController.removeListener(_handleContentScroll);
    _textController.removeListener(_handleTextScroll);
    _contentController.dispose();
    _textController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.previewWidth,
      height: widget.previewHeight,
      child: SingleChildScrollView(
        controller: _contentController,
        physics: ref.watch(_contentScrollEnd) ? const NeverScrollableScrollPhysics() : null,
        scrollDirection: Axis.horizontal,
        child: Container(
          width: responsiveWidth,
          height: responsiveHeight,
          decoration: BoxDecoration(
            color: FlexiColor.stringToColor(widget.contentInfo.backgroundColor),
            image: widget.contentInfo.backgroundType != 'color' ? DecorationImage(
              image: Image.memory(base64Decode(widget.contentInfo.contentThumbnail)).image,
              fit: BoxFit.cover
            ) : null
          ),
          child: SingleChildScrollView(
            controller: _textController,
            physics: ref.watch(_contentScrollEnd) ? null : const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: responsiveHeight,
              child: Text(
                widget.contentInfo.text, 
                style: TextStyle(
                  fontSize: textScaler * widget.contentInfo.textSize,
                  fontWeight: widget.contentInfo.isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: widget.contentInfo.isItalic ? FontStyle.italic : FontStyle.normal,
                  color: FlexiColor.stringToColor(widget.contentInfo.textColor)
                )
              )
            ),
          )
        ),
      ),
    );
  }

}
