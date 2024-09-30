import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../feature/content/controller/content_edit_controller.dart';
import '../../../feature/content/model/content_model.dart';
import '../../../util/design/colors.dart';
import 'content_clipper.dart';



class BackgroundEditPreview extends ConsumerWidget {
  const BackgroundEditPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var content = ref.watch(contentEditControllerProvider);
    double aspectRatio = content.width / content.height;
    double contentWidth = content.width <= 360 ? 1.sw : (1.sw / 360) * content.width;
    double contentHeight = contentWidth / aspectRatio;
    double textScaler = contentHeight / content.height;
    if(contentHeight <= content.height) {
      textScaler = content.height / contentHeight;
    }
    return Container(
      width: 1.sw,
      height: .2.sh,
      color: Colors.black.withOpacity(.6),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: 1.sw, 
              height: (contentHeight + .005.sh) * (content.width / 360).ceil()
            ),
            ...chunkContent(
              width: contentWidth, 
              height: contentHeight, 
              contentData: content, 
              content: Container(
                width: contentWidth,
                height: contentHeight,
                padding: EdgeInsets.only(
                  left: (contentWidth / content.width) * content.x,
                  top: (contentHeight / content.height) * content.y
                ),
                decoration: BoxDecoration(
                  color: FlexiColor.stringToColor(content.backgroundColor),
                  image: content.backgroundType != 'color' && content.fileThumbnail != null ? DecorationImage(
                    image: Image.memory(base64Decode(content.fileThumbnail!)).image,
                    fit: BoxFit.cover
                  ) : null
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    content.text,
                    style: TextStyle(
                      fontSize: (textScaler * content.textSize) * .75,
                      color: FlexiColor.stringToColor(content.textColor),
                      fontWeight: content.bold ? FontWeight.bold : FontWeight.normal,
                      fontStyle: content.italic ? FontStyle.italic : FontStyle.normal
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

  List<Widget> chunkContent({required double width, required double height, required ContentModel contentData, required Widget content}) {
    if(contentData.width <= 360) return [content];

    List<Widget> contents = [];
    for(int i = 0; i < contentData.width ~/ 360; i++) {
      contents.add(
        Positioned(
          left: i * -1.sw,
          top: (i * height) + (i * .005.sh),
          child: ClipRect(
            clipper: ContentClipper(dx: (i * 1.sw), width: 1.sw, height: height),
            child: content
          )
        )
      );
    }

    if(contentData.width % 360 != 0) {
      contents.add(
        Positioned(
          left: contents.length * -1.sw,
          top: contents.length * (height + .005.sh),
          child: ClipRect(
            clipper: ContentClipper(dx: (contents.length * 1.sw), width: width % 1.sw, height: height),
            child: content
          )
        )
      );
    }

    return contents;
  }

}