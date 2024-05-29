import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';



class QrcodeLoadScreen extends ConsumerStatefulWidget {
  const QrcodeLoadScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrcodeLoadScreenState();
}

class _QrcodeLoadScreenState extends ConsumerState<QrcodeLoadScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlexiColor.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.go('/device/setWifi'),
                  icon: Icon(Icons.arrow_back_ios, color: FlexiColor.primary, size: .03.sh),
                ),
                Text('Load QRCode Image', style: FlexiFont.semiBold20),
                TextButton(
                  onPressed: () => context.go('/device/setWifi'),
                  child: Text('Load', style: FlexiFont.regular16.copyWith(color: FlexiColor.primary)),
                )
              ],
            ),
            SizedBox(height: .02.sh),
          ],
        ),
      ),
    );
  }

}