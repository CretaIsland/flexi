import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../feature/content/model/content_info.dart';
import '../../../utils/ui/color.dart';
import 'content_clipper.dart';



class BackgroundEditPreview extends ConsumerWidget {
  const BackgroundEditPreview({super.key, required this.contentInfo});
  final ContentInfo contentInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    double aspectRatio = contentInfo.width / contentInfo.height;
    double responsiveWidth = contentInfo.width <= 360 ? 1.sw : (1.sw / 360) * contentInfo.width;
    double responsiveHeight = responsiveWidth / aspectRatio;
    double textScaler = 0.0;
    if(responsiveHeight > contentInfo.height) {
      textScaler = responsiveHeight / contentInfo.height;
    } else {
      textScaler = contentInfo.height / responsiveHeight;
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
              height: (responsiveHeight + .005.sh) * (contentInfo.width / 360).ceil(),
            ),
            ...chunkContent(
              width: responsiveWidth,
              height: responsiveHeight,
              content: Container(
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
                child: Padding(
                  padding: EdgeInsets.only(left: contentInfo.x * 1.0, top: contentInfo.y * 1.0),
                  child: Text(
                    contentInfo.text,
                    style: TextStyle(
                      fontSize: contentInfo.textSize * textScaler,
                      fontWeight: contentInfo.isBold ? FontWeight.bold : FontWeight.normal,
                      fontStyle: contentInfo.isItalic ? FontStyle.italic : FontStyle.normal,
                      color: FlexiColor.stringToColor(contentInfo.textColor)
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

    if(contentInfo.width <= 360) {
      return [content];
    }

    for(int i = 0; i < contentInfo.width ~/ 360; i++) {
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

    if(contentInfo.width % 360 != 0.0) {
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