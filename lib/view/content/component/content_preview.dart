import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main.dart';
import '../../../utils/ui/fonts.dart';



class ContentPreview extends ConsumerWidget {
  const ContentPreview({super.key, required this.width});
  final double width;

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // 테스트용
    double contentWidth = 360;
    double contentHeight = 28;
    
    double aspectRatio =  contentWidth / contentHeight;
    double responsiveWidth = contentWidth <= 360 ? width : (width / 360) * contentWidth;
    double responsiveHeight = responsiveWidth / aspectRatio;

    return SizedBox(
      width: width,
      height: responsiveHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: responsiveWidth,
          height: responsiveHeight,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(screenHeight * .005)
          ),
          child: Stack(
            children: [
              // 이미지 존재 조건 추가
              Text(
                "Example Text Example Text Example Text", 
                style: FlexiFont.regular11.copyWith(color: Colors.white), 
                maxLines: 1, 
                overflow: TextOverflow.fade
              )
            ],
          ),
        ),
      ),
    );
  }

}