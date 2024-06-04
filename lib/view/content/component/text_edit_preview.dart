import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../feature/content/controller/text_edit_controller.dart';
import '../../../feature/content/model/content_info.dart';
import '../../../utils/ui/color.dart';
import 'content_clipper.dart';



class TextEditPreview extends ConsumerStatefulWidget {
  const TextEditPreview({super.key, required this.contentInfo});
  final ContentInfo contentInfo;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextEditPreviewState();
}

class _TextEditPreviewState extends ConsumerState<TextEditPreview> {

  late ContentInfo contentInfo;
  late TextEditingController textEditingController;
  late double aspectRatio;
  late double responsiveWidth;
  late double responsiveHeight;
  late double textScaler;


  @override
  void initState() {
    super.initState();
    contentInfo = widget.contentInfo;

    textEditingController = TextEditingController(text: contentInfo.text);
    aspectRatio = contentInfo.width / contentInfo.height;
    responsiveWidth = contentInfo.width <= 360 ? 1.sw : (1.sw / 360) * contentInfo.width;
    responsiveHeight = responsiveWidth / aspectRatio;
    textScaler = 0.0;
    if(responsiveHeight > contentInfo.height) {
      textScaler = responsiveHeight / contentInfo.height;
    } else {
      textScaler = contentInfo.height / responsiveHeight;
    }
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    print('content rebuild');
    contentInfo = widget.contentInfo;
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
                  color: FlexiColor.stringToColor(contentInfo.backgroundColor),
                  image: contentInfo.backgroundType != 'color' && contentInfo.contentThumbnail.isNotEmpty ?
                    DecorationImage(
                      image: Image.memory(base64Decode(contentInfo.contentThumbnail)).image,
                      fit: BoxFit.cover
                    ) : null
                ),
              ),
            ),
            SizedBox(
              width: 1.sw, 
              height: .15.sh,
              child: TextField(
                controller: textEditingController,
                maxLines: null,
                readOnly: ref.watch(sttModeProvider),
                focusNode: ref.watch(keyboardEventProvider),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none
                ),
                style: TextStyle(
                  fontSize: textScaler * contentInfo.textSize,
                  fontWeight: contentInfo.isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: contentInfo.isItalic ? FontStyle.italic : FontStyle.normal,
                  color: FlexiColor.stringToColor(contentInfo.textColor),
                  height: contentInfo.textSizeType == 's' ? 1.6 : contentInfo.textSizeType == 'm' ? 1.4 : 1.2
                ),
                onChanged: (value) => ref.watch(textEditControllerProvider.notifier).setText(value)
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> chunkContent(Widget content) {
    List<Widget> chunks = [];

    if(contentInfo.width <= 360) {
      return [content];
    }

    for(int i = 0; i < contentInfo.width ~/ 360; i++) {
      chunks.add(
        Positioned(
          left: i * -1.sw,
          top: i * responsiveHeight,
          child: ClipRect(
            clipper: ContentClipper(dx: (i * 1.sw), width: 1.sw, height: responsiveHeight),
            child: content,
          ),
        )
      );
    }

    if(contentInfo.width % 360 != 0.0) {
      chunks.add(
        Positioned(
          left: chunks.length * -1.sw,
          top: chunks.length * responsiveHeight,
          child: ClipRect(
            clipper: ContentClipper(dx: (chunks.length * 1.sw), width: responsiveWidth % 1.sw, height: responsiveHeight),
            child: content,
          ),
        )
      );
    }

    return chunks;
  }

}