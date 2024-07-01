import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../common/providers/socket_client_controller.dart';
import '../../../component/text_button.dart';
import '../../../feature/content/controller/content_info_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';
import '../screen/content_send_screen.dart';



class ContentSendModal extends ConsumerWidget {
  const ContentSendModal({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final contentInfo = ref.watch(contentInfoControllerProvider);

    return Container(
      width: .93.sw,
      height: .35.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .05.sh, right: .055.sw),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.circular(.025.sh)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Are you sure?', style: FlexiFont.semiBold24),
          SizedBox(height: .02.sh),
          Text('This will send content \nto device.', style: FlexiFont.regular16,),
          SizedBox(height: .03.sh),
          FlexiTextButton(
            width: .82.sw, 
            height: .06.sh, 
            text: 'Send',
            backgroundColor: FlexiColor.primary,
            onPressed: () async {
              if(contentInfo.backgroundType != 'color') {
                File? contentFile = await ref.watch(contentInfoControllerProvider.notifier).getContentFile();
                if(contentFile != null) {
                  var connected = await ref.watch(socketClientControllerProvider.notifier).connect(ref.watch(selectDevicesProvider)[0].ip);
                  if(connected) {
                    Map<String, dynamic> data = contentInfo.toJson();
                    data.addAll({"command": "playerContent", "deviceId": ref.watch(selectDevicesProvider)[0].deviceId});
                    data.remove('textSizeType');
                    data.remove('filePath');
                    data.remove('fileThumbnail');
                    data['textSize'] = data['textSize'].round();
                    ref.watch(socketClientControllerProvider.notifier).sendFile(contentFile, contentInfo.fileName, data);
                  }
                }
              } else {
                var connected = await ref.watch(socketClientControllerProvider.notifier).connect(ref.watch(selectDevicesProvider)[0].ip);
                if(connected) {
                  Map<String, dynamic> data = contentInfo.toJson();
                  data.addAll({"command": "playerContent", "deviceId": ref.watch(selectDevicesProvider)[0].deviceId});
                  data.remove('textSizeType');
                  data.remove('filePath');
                  data.remove('fileThumbnail');
                  data['textSize'] = data['textSize'].round();
                  ref.watch(socketClientControllerProvider.notifier).sendData(data);
                }
              }
              context.pop();
            },
          ),
          SizedBox(
            width: .82.sw,
            height: .06.sh,
            child: TextButton(
              onPressed: () => context.pop(),
              child: Text('Cancel', style: FlexiFont.regular16),
            ),
          )
        ]
      )
    );
  }

}