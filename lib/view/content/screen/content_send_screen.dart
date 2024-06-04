import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/search_bar.dart';
import '../../../feature/content/controller/content_send_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class ContentSendScreen extends ConsumerWidget {
  const ContentSendScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: FlexiColor.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.go('/content/info'),
                  icon: Icon(Icons.arrow_back_ios, color: FlexiColor.primary, size: .03.sh)
                ),
                Text('Send to device', style: FlexiFont.semiBold20),
                TextButton(
                  onPressed: () {
                    // 콘텐츠 전송하기
                    context.go('/content/info');
                  }, 
                  child: Text('Send', style: FlexiFont.regular16.copyWith(color: FlexiColor.primary))
                )
              ],
            ),
            SizedBox(height: .03.sh),
            FlexiSearchBar(
              hintText: 'Search your device',
              onChanged: (value) {},
            ),
            SizedBox(height: .025.sh),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () { },
                        child: Container(
                          width: .89.sw,
                          height: .1.sh,
                          padding: EdgeInsets.only(left: .04.sw, right: .04.sw),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(.01.sh)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: .02.sh),
                                  Row(
                                    children: [
                                      Icon(Icons.link_rounded, color: FlexiColor.primary, size: .02.sh),
                                      SizedBox(width: .015.sh),
                                      Text("Device name", style: FlexiFont.regular16,)
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: .03.sh),
                                    child: Text("Device ID", style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                                  )
                                ],
                              ),
                              ref.watch(selectDeviceProvider) == index ? 
                                Icon(Icons.check_circle, color: FlexiColor.secondary, size: .025.sh) :
                                Icon(Icons.check_circle_outline, color: FlexiColor.grey[600], size: .025.sh)
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }

}