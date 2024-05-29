import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/ui/fonts.dart';



class ContentPreview extends ConsumerStatefulWidget {
  const ContentPreview({super.key, required this.previewWidth, required this.previewHeight});
  final double previewWidth;
  final double previewHeight;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentPreviewState();
}

class _ContentPreviewState extends ConsumerState<ContentPreview> {

  final _contentScrollEnd = StateProvider((ref) => false);
  late ScrollController _contentController;
  late ScrollController _textController;

  // 테스트용
  double contentWidth = 320;
  double contentHeight = 28;
    
  late double aspectRatio;
  late double responsiveHeight;
  late double responsiveWidth;


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
    aspectRatio =  contentWidth / contentHeight;
    responsiveHeight = widget.previewHeight;
    responsiveWidth = responsiveHeight * aspectRatio;
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
            color: Colors.pink.shade100,
            // 콘텐츠의 썸네일
            // image: DecorationImage(
            //   image: AssetImage('assets/image/login_illustration.png'),
            //   fit: BoxFit.fill
            // )
          ),
          child: SingleChildScrollView(
            controller: _textController,
            physics: ref.watch(_contentScrollEnd) ? null : const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: responsiveHeight,
              child: Text("Example Text", style: FlexiFont.regular24)
            ),
          )
        ),
      ),
    );
  }

}
