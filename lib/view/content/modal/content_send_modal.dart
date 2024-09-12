import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../core/controller/network_controller.dart';
import '../../../feature/content/controller/content_info_controller.dart';
import '../../../feature/content/controller/content_send_controller.dart';
import '../../../util/design/colors.dart';
import '../../../component/text_button.dart';
import '../../../component/progress_overlay.dart';



class ContentSendModal extends ConsumerWidget {
  const ContentSendModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var content = ref.watch(contentInfoControllerProvider);
    return Container(
      width: .93.sw,
      height: .35.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw, bottom: .03.sh),
      margin: EdgeInsets.only(bottom: .02.sh),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.circular(.025.sh)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Are you sure?', style: Theme.of(context).textTheme.displayMedium),
          Text('This will send content \nto device.', style: Theme.of(context).textTheme.bodyMedium),
          FlexiTextButton(
            width: .82.sw,
            height: .06.sh,
            text: 'Send',
            backgroundColor: FlexiColor.primary,
            onPressed: () async {
              var successTask = 0;
              ref.watch(totalTaskProvider.notifier).state = ref.watch(selectDevicesProvider).length;
              OverlayEntry loadingScreen = OverlayEntry(builder: (context) => const ProgressOverlay());
              Navigator.of(context).overlay!.insert(loadingScreen);

              for(var device in ref.read(selectDevicesProvider)) {
                if(content.backgroundType == 'color') {
                  var connected = await ref.watch(socketClientControllerProvider.notifier).connect(device.ip);
                  if(connected) {
                    Map<String, dynamic> data = content.toJson();
                    data.addAll({"command": "playerContent", "deviceId": device.deviceId, "requestTime": DateTime.now().toUtc().toIso8601String()});
                    data['textColor'] = FlexiColor.stringToColor(data['textColor']).toString();
                    data['backgroundColor'] = FlexiColor.stringToColor(data['backgroundColor']).toString();
                    data.remove('textSizeType');
                    data.remove('filePath');
                    data.remove('fileThumbnail');
                    ref.watch(socketClientControllerProvider.notifier).sendData(data);
                    successTask += 1;
                  }
                } else {
                  File? contentFile = await ref.watch(contentInfoControllerProvider.notifier).getContentFile();
                  if(contentFile != null) {
                    var connected = await ref.watch(socketClientControllerProvider.notifier).connect(device.ip);
                    if(connected) {
                      Map<String, dynamic> data = content.toJson();
                      data.addAll({"command": "playerContent", "deviceId": device.deviceId, "requestTime": DateTime.now().toUtc().toIso8601String()});
                      data['textColor'] = FlexiColor.stringToColor(data['textColor']).toString();
                      data['backgroundColor'] = FlexiColor.stringToColor(data['backgroundColor']).toString();
                      data.remove('textSizeType');
                      data.remove('filePath');
                      data.remove('fileThumbnail');
                      await ref.watch(socketClientControllerProvider.notifier).sendFile(content.fileName, contentFile);
                      await ref.watch(socketClientControllerProvider.notifier).sendData(data);
                      successTask += 1;
                    }
                  }
                }
                await ref.watch(socketClientControllerProvider.notifier).disconnect();
                ref.watch(completeTaskProvider.notifier).state = ref.watch(completeTaskProvider) + 1;
                await Future.delayed(const Duration(seconds: 1));
              }

              Fluttertoast.showToast(
                msg: 'Success $successTask devices (Fail ${ref.read(totalTaskProvider) - successTask} devices)',
                backgroundColor: Colors.black.withOpacity(.8),
                textColor: Colors.white,
                fontSize: .02375.sh
              ).whenComplete(() {
                ref.invalidate(totalTaskProvider);
                ref.invalidate(completeTaskProvider);
                ref.invalidate(selectDevicesProvider);
                
                loadingScreen.remove();
                context.pop();
                context.go('/content/info');
              });
            }
          ),
          SizedBox(
            width: .82.sw,
            height: .06.sh,
            child: TextButton(
              child: Text('Cancle', style: Theme.of(context).textTheme.bodyMedium),
              onPressed: () => context.pop(),
            ),
          )
        ],
      ),
    );
  }

}