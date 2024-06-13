import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/search_bar.dart';
import '../../../feature/content/controller/content_info_controller.dart';
import '../../../feature/content/controller/content_send_controller.dart' as content_send_controller;
import '../../../feature/device/controller/device_list_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';
import '../modal/content_send_modal.dart';



class ContentSendScreen extends ConsumerStatefulWidget {
  const ContentSendScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentSendScreenState();
}

class _ContentSendScreenState extends ConsumerState<ContentSendScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(content_send_controller.searchTextProvider);
    });
  }


  @override
  Widget build(BuildContext context) {
    ref.watch(contentInfoControllerProvider);
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
                  onPressed: () {
                    ref.invalidate(content_send_controller.selectDeviceProvider);
                    context.go('/content/info');
                  },
                  icon: Icon(Icons.arrow_back_ios, color: FlexiColor.primary, size: .03.sh)
                ),
                Text('Send to device', style: FlexiFont.semiBold20),
                TextButton(
                  onPressed: () {
                    // 콘텐츠 전송하기
                    showModalBottomSheet(
                      context: context, 
                      backgroundColor: Colors.transparent,
                      builder:(context) => const ContentSendModal(),
                    );
                  }, 
                  child: Text('Send', style: FlexiFont.regular16.copyWith(color: FlexiColor.primary))
                )
              ],
            ),
            SizedBox(height: .03.sh),
            FlexiSearchBar(
              hintText: 'Search your device',
              onChanged: (value) => ref.watch(content_send_controller.searchTextProvider.notifier).state = value,
            ),
            SizedBox(height: .025.sh),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final devices = ref.watch(deviceListControllerProvider);
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      return devices[index].deviceName.contains(ref.watch(content_send_controller.searchTextProvider)) ? GestureDetector(
                        onTap: () {
                          print('click');
                          if(ref.watch(content_send_controller.selectDeviceProvider) == devices[index]) {
                            ref.watch(content_send_controller.selectDeviceProvider.notifier).state = null;
                          } else {
                            ref.watch(content_send_controller.selectDeviceProvider.notifier).state = devices[index];
                          }
                        },
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
                                      Text(devices[index].deviceName, style: FlexiFont.regular16,)
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: .03.sh),
                                    child: Text(devices[index].deviceId, style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                                  )
                                ],
                              ),
                              ref.watch(content_send_controller.selectDeviceProvider) == devices[index] ? 
                                Icon(Icons.check_circle, color: FlexiColor.primary, size: .025.sh) :
                                Icon(Icons.check_circle_outline, color: FlexiColor.grey[600], size: .025.sh)
                            ],
                          ),
                        ),
                      ) : const SizedBox.shrink();
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