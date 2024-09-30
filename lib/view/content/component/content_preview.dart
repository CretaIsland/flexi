import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../feature/content/model/content_model.dart';
import '../../../util/design/colors.dart';



class ContentPreview extends ConsumerWidget {
  const ContentPreview({super.key, required this.width, required this.height, required this.content});
  final double width;
  final double height;
  final ContentModel content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double contentWidth = height * (content.width / content.height);
    double textScaler = height / content.height;
    if(height <= content.height) {
      textScaler = content.height / height;
    }

    return SizedBox(
      width: width,
      height: height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: contentWidth,
          height: height,
          padding: EdgeInsets.only(
            left: (contentWidth / content.width) * content.x,
            top: (height / content.height) * content.y
          ),
          decoration: BoxDecoration(
            color: FlexiColor.stringToColor(content.backgroundColor),
            image: content.backgroundType != 'color' && content.fileThumbnail != null ? DecorationImage(
              image: Image.memory(base64Decode(content.fileThumbnail!)).image,
              fit: BoxFit.cover
            ) : null
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
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
      )
    );
  }
}