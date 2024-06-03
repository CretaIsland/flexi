import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../feature/content/controller/text_edit_controller.dart';
import '../../../feature/content/model/content_info.dart';
import '../../../utils/ui/colors.dart';



class TextEditPreview extends ConsumerStatefulWidget {
  const TextEditPreview({super.key, required this.contentInfo});
  final ContentInfo contentInfo;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextEditPreviewState();
}

class _TextEditPreviewState extends ConsumerState<TextEditPreview> {

  late TextEditingController? _textController;
  late double aspectRatio;
  late double responsiveHeight;
  late double responsiveWidth;
  late double textScaler;


  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.contentInfo.text);
    aspectRatio = widget.contentInfo.width / widget.contentInfo.height;
    responsiveWidth = widget.contentInfo.width <= 360 ? 1.sw : (1.sw / 360) * widget.contentInfo.width;
    responsiveHeight = responsiveWidth / aspectRatio;
    if(responsiveHeight > widget.contentInfo.height) {
      textScaler = responsiveHeight / widget.contentInfo.height;
    } else {
      textScaler = widget.contentInfo.height / responsiveHeight;
    } 
  }


  @override
  Widget build(BuildContext context) {
    
    print('content rebuild');
    print(widget.contentInfo.isBold);

    return Container(
      width: 1.sw,
      height: .15.sh,
      color: Colors.black.withOpacity(.6),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: 1.sw, 
              height: .15.sh
            ),
            ...chunkContent(
              Container(
                width: responsiveWidth,
                height: responsiveHeight,
                color: FlexiColor.stringToColor(widget.contentInfo.backgroundColor)
              )
            ),
            Container(
              color: Colors.pink.withOpacity(.2),
              width: 1.sw, 
              height: .15.sh,
              child: TextField(
                controller: _textController,
                maxLines: 10,
                readOnly: ref.watch(sttModeProvider),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none
                ),
                style: TextStyle(
                  fontSize: textScaler * widget.contentInfo.textSize,
                  fontWeight: widget.contentInfo.isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: widget.contentInfo.isItalic ? FontStyle.italic : FontStyle.normal,
                  color: FlexiColor.stringToColor(widget.contentInfo.textColor),
                  height: widget.contentInfo.textSizeType == 's' ? 1.6 : widget.contentInfo.textSizeType == 'm' ? 1.4 : 1.2
                ),
                onChanged: (value) {
                  ref.watch(textEditControllerProvider.notifier).setText(value);
                  print(ref.watch(textEditControllerProvider)!.text);
                },
              ),
            ),
          ],
        )
      ),
    );
  }

  List<Widget> chunkContent(Widget content) {
    List<Widget> chunks = [];

    if(widget.contentInfo.width <= 360) {
      return [content];
    }

    for(int i = 0; i < widget.contentInfo.width ~/ 360; i++) {
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

    if(widget.contentInfo.width % 360 != 0.0) {
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


// clipper
class ContentClipper extends CustomClipper<Rect> {
  ContentClipper({required this.dx, required this.width, required this.height});

  final double dx;
  final double width;
  final double height;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(dx, 0.0, width, height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }

}

