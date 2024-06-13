import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/config.dart';
import '../../../common/providers/network_providers.dart';
import '../../../component/text_button.dart';
import '../../../feature/content/controller/content_info_controller.dart';
import '../../../feature/content/controller/content_send_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class ContentSendModal extends ConsumerWidget {
  const ContentSendModal({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final contentInfo = ref.watch(contentInfoControllerProvider);
    final socketClient = ref.watch(SocketIOClientProvider(ip: ref.watch(selectDeviceProvider)!.ip, port: Config.socketIOPort).notifier);

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
            fillColor: FlexiColor.primary,
            onPressed: () async {
              if(contentInfo!.backgroundType != 'color') {
                File? contentFile = await ref.watch(contentSendControllerProvider.notifier).getContentFile();
                if(contentFile != null) {
                  socketClient.sendFile(
                    deviceId: ref.watch(selectDeviceProvider)!.deviceId, 
                    file: contentFile, 
                    fileName: contentInfo.fileName, 
                    contentInfo: contentInfo
                  );
                }
              } else {
                Map<String, dynamic> contentInfoJson = contentInfo.toJson();
                contentInfoJson.addAll({"command": "playerContent", "deviceId": ref.watch(selectDeviceProvider)!.deviceId});
                contentInfoJson.remove('textSizeType');
                contentInfoJson.remove('filePath');
                contentInfoJson.remove('fileThumbnail');
                contentInfoJson['textSize'] = 11;
                contentInfoJson['language'] = 'en-US';
                print(contentInfoJson);
                String sendData = jsonEncode(contentInfoJson);
                socketClient.sendData(sendData);
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