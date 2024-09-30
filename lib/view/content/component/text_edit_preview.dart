import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../feature/content/controller/content_edit_controller.dart';
import '../../../feature/content/model/content_model.dart';
import '../../../util/design/colors.dart';
import '../screen/text_edit_screen.dart';
import 'content_clipper.dart';



class TextEditPreview extends StatelessWidget {
  const TextEditPreview({super.key, required this.content});
  final ContentModel content;

  @override
  Widget build(BuildContext context) {
    double aspectRatio = content.width / content.height;
    double contentWidth = content.width <= 360 ? 1.sw : (1.sw / 360) * content.width;
    double contentHeight = contentWidth / aspectRatio;
    double textScaler = contentHeight / content.height;
    if(contentHeight <= content.height) {
      textScaler = content.height / contentHeight;
    }

    return Container(
      width: 1.sw,
      height: .15.sh,
      color: Colors.black.withOpacity(.6),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(width: 1.sw, height: .15.sh),
            ...chunkContent(
              contentWidth,
              contentHeight,
              content,
              Container(
                width: contentWidth,
                height: contentHeight,
                decoration: BoxDecoration(
                  color: FlexiColor.stringToColor(content.backgroundColor),
                  image: content.backgroundType != 'color' && content.fileThumbnail != null ?
                    DecorationImage(
                      image: Image.memory(base64Decode(content.fileThumbnail!)).image,
                      fit: BoxFit.cover
                    ) : null
                )
              )
            ),
            SizedBox(
              width: 1.sw, 
              height: .15.sh,
              child: Consumer(
                builder: (context, ref, child) {
                  var content = ref.watch(contentEditControllerProvider);
                  TextEditingController textController = TextEditingController(text: content.text);
                  return TextField(
                    controller: textController,
                    readOnly: ref.watch(sttModeProvider),
                    focusNode: ref.watch(enableKeyboardProvider),
                    cursorHeight: contentHeight,
                    maxLines: 10,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      iconColor: FlexiColor.primary
                    ),
                    style: TextStyle(
                      fontSize: (textScaler * content.textSize) * .75,
                      fontWeight: content.bold ? FontWeight.bold : FontWeight.normal,
                      fontStyle: content.italic ? FontStyle.italic : FontStyle.normal,
                      color: FlexiColor.stringToColor(content.textColor),
                      height: content.textSize == 18 ? 2.25 : content.textSize == 22 ? 1.8 : 1.45,
                      decorationThickness: 0
                    ),
                    onEditingComplete: () => ref.watch(contentEditControllerProvider.notifier).setText(textController.text),
                    onTapOutside: (event) => ref.watch(contentEditControllerProvider.notifier).setText(textController.text),
                    onSubmitted: (value) => ref.watch(contentEditControllerProvider.notifier).setText(textController.text)
                  );
                }
              )
            )
          ]
        )
      )
    );
  }

  List<Widget> chunkContent(double previewWidth, double previewHeight, ContentModel contentData, Widget content) {
    if(contentData.width <= 360) return [content];

    List<Widget> contents = [];
    for(int i = 0; i < contentData.width ~/ 360; i++) {
      contents.add(
        Positioned(
          left: i * -1.sw,
          top: (i * previewHeight) + (i * .005.sh),
          child: ClipRect(
            clipper: ContentClipper(dx: (i * 1.sw), width: 1.sw, height: previewHeight),
            child: content
          )
        )
      );
    }

    if(contentData.width % 360 != 0) {
      contents.add(
        Positioned(
          left: contents.length * -1.sw,
          top: contents.length * (previewHeight + .005.sh),
          child: ClipRect(
            clipper: ContentClipper(dx: (contents.length * 1.sw), width: previewWidth % 1.sw, height: previewHeight),
            child: content
          )
        )
      );
    }

    return contents;
  }
  
}