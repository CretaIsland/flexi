import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../feature/content/controller/content_edit_controller.dart';
import '../../../feature/content/model/content_model.dart';
import '../../../util/design/colors.dart';
import '../screen/text_edit_screen.dart';
import 'content_clipper.dart';



class TextEditPreview extends ConsumerStatefulWidget {
  const TextEditPreview({super.key, required this.content});
  final ContentModel content;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextEditPreviewState();
}

class _TextEditPreviewState extends ConsumerState<TextEditPreview> {

  late TextEditingController _textEditingController;
  late ContentModel content;
  late double aspectRatio;
  late double responsiveWidth;
  late double responsiveHeight;
  late double textScaler;


  @override
  void initState() {
    super.initState();
    content = widget.content;
    _textEditingController = TextEditingController(text: content.text);
    aspectRatio = content.width / content.height;
    responsiveWidth = content.width <= 360 ? 1.sw : (1.sw / 360) * content.width;
    responsiveHeight = responsiveWidth / aspectRatio;
    textScaler = 0.0;
    if(responsiveHeight > content.height) {
      textScaler = responsiveHeight / content.height;
    } else {
      textScaler = content.height / responsiveHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    content = widget.content;
    _textEditingController = TextEditingController(text: content.text);
    return Container(
      width: 1.sw,
      height: .15.sh,
      color: Colors.black.withOpacity(.6),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: 1.sw,
              height: .15.sh,
            ),
            ...chunkContent(
              Container(
                width: responsiveWidth,
                height: responsiveHeight,
                decoration: BoxDecoration(
                  color: FlexiColor.stringToColor(content.backgroundColor),
                  image: content.backgroundType != 'color' && content.fileThumbnail != null ?
                    DecorationImage(
                      image: Image.memory(base64Decode(content.fileThumbnail!)).image,
                      fit: BoxFit.cover
                    ) : null
                ),
              ),
            ),
            SizedBox(
              width: 1.sw, 
              height: .15.sh,
              child: TextField(
                controller: _textEditingController,
                maxLines: 5,
                readOnly: ref.watch(sttModeProvider),
                focusNode: ref.watch(keyboardEventProvider),
                cursorHeight: responsiveHeight,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 5),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  iconColor: FlexiColor.primary
                ),
                style: TextStyle(
                  fontSize: textScaler * content.textSize,
                  fontWeight: content.bold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: content.italic ? FontStyle.italic : FontStyle.normal,
                  color: FlexiColor.stringToColor(content.textColor),
                  height: content.textSizeType == 'S' ? 1.55 : content.textSizeType == 'M' ? 1.25 : 1,
                  decorationThickness: 0
                ),
                onEditingComplete: () => ref.watch(contentEditControllerProvider.notifier).setText(_textEditingController.text),
                onTapOutside: (event) => ref.watch(contentEditControllerProvider.notifier).setText(_textEditingController.text),
                onSubmitted: (value) => ref.watch(contentEditControllerProvider.notifier).setText(_textEditingController.text),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> chunkContent(Widget contentWidget) {
    List<Widget> chunks = [];

    if(content.width <= 360) {
      return [contentWidget];
    }

    for(int i = 0; i < content.width ~/ 360; i++) {
      chunks.add(
        Positioned(
          left: i * -1.sw,
          top: i * responsiveHeight,
          child: ClipRect(
            clipper: ContentClipper(dx: (i * 1.sw), width: 1.sw, height: responsiveHeight),
            child: contentWidget,
          ),
        )
      );
    }

    if(content.width % 360 != 0.0) {
      chunks.add(
        Positioned(
          left: chunks.length * -1.sw,
          top: chunks.length * responsiveHeight,
          child: ClipRect(
            clipper: ContentClipper(dx: (chunks.length * 1.sw), width: responsiveWidth % 1.sw, height: responsiveHeight),
            child: contentWidget,
          ),
        )
      );
    }

    return chunks;
  }

}