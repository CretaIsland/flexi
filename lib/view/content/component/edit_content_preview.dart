import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main.dart';
import '../edit_background_screen.dart';



class EditContentPreview extends ConsumerStatefulWidget {
  const EditContentPreview({super.key});

  @override
  ConsumerState<EditContentPreview> createState() => _EditContentPreviewState();
}

class _EditContentPreviewState extends ConsumerState<EditContentPreview> {

  // test용
  final double contentWidth = 360;
  final double contentHeight = 28;
  late double aspectRatio;
  late double responsiveWidth;
  late double responsiveHeight;

  @override
  void initState() {
    super.initState();
    aspectRatio = contentWidth / contentHeight;
    responsiveWidth = contentWidth <= 360 ? screenWidth : (screenWidth / 360) * contentWidth;
    responsiveHeight = responsiveWidth / aspectRatio;
  }
  


  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight * .2,
      color: Colors.black.withOpacity(.6),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: screenWidth,
              height: (responsiveHeight + 5) * (contentWidth / 360).ceil(),
            ),
            ...chunkContent(
              Container(
                color: ref.watch(selectedColor),
                child: Stack(
                  children: [
                    ref.watch(selectedContentThumbnail) != null ? 
                      SizedBox(
                        width: responsiveWidth,
                        height: responsiveHeight,
                        child: Image.memory(
                          ref.watch(selectedContentThumbnail)!,
                          fit: BoxFit.fitWidth,
                        ),
                      ) : const SizedBox.shrink(),
                    SizedBox(
                      width: responsiveWidth,
                      height: responsiveHeight,
                      child: const Text('Example Text')
                    )
                  ],
                ),
              )
            )
          ]
        )
      ),
    );
  }

  List<Widget> chunkContent(Widget fullContent) {
    List<Widget> chunkContentList = [];


    if(contentWidth <= 360) {
      return [fullContent];
    }

    for(int i = 0; i < contentWidth ~/ 360; i++) {
      chunkContentList.add(
        Positioned(
          left: i * -screenWidth,
          top: i * (responsiveHeight + 5),
          child: ClipRect(
            clipper: ContentClipper(dx: (i * screenWidth), width: screenWidth, height: responsiveHeight),
            child: fullContent
          ),
        )
      );
    }

    if(contentWidth % 360 != 0.0) {
      chunkContentList.add(
        Positioned(
          left: (chunkContentList.length) * -screenWidth,
          top: (chunkContentList.length) * (responsiveHeight + 5),
          child: ClipRect(
            clipper: ContentClipper(dx: ((chunkContentList.length) * screenWidth), width: (responsiveWidth % screenWidth), height: responsiveHeight),
            child: fullContent
          ),
        )
      );
    }

    return chunkContentList;
    
  }

}



// content 분할
class ContentClipper extends CustomClipper<Rect> {

  final double dx;
  final double width;
  final double height;

  ContentClipper({required this.dx, required this.width, required this.height});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(dx, 0.0, width, height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }

}