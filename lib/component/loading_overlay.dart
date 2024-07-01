import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/ui/color.dart';



class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      color: FlexiColor.grey[200]!.withOpacity(.8),
      child: Center(
        child: Container(
          width: .075.sh,
          height: .075.sh,
          padding: EdgeInsets.all(.0125.sh),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(.0125.sh)
          ),
          child: Image.asset('assets/image/wifi_loading.gif', fit: BoxFit.cover),
        ),
      ),
    );
  }

}