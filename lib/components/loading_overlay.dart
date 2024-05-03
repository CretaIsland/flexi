import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/ui/colors.dart';



class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight,
      color: FlexiColor.grey[200]!.withOpacity(.8),
      child: Center(
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Image.asset("assets/image/wifi_loading.gif")
        ),
      ),
    );
  }

}