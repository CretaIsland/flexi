import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../../component/progress_overlay.dart';
import '../../../component/text_button.dart';
import '../../../core/controller/network_controller.dart';
import '../../../feature/content/controller/content_info_controller.dart';
import '../../../feature/device/controller/device_list_controller.dart';
import '../../../util/design/colors.dart';
import '../../../util/utils.dart';



class ContentSendModal extends ConsumerWidget {
  const ContentSendModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var content = ref.watch(contentInfoControllerProvider);
    return Container(
      width: .94.sw,
      height: .35.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .045.sh, right: .055.sw, bottom: .03.sh),
      margin: EdgeInsets.only(bottom: .02.sh),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.circular(.025.sh)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Are you sure?',
            style: Theme.of(context).textTheme.displayMedium
          ),
          Text(
            'This will send content \nto device.',
            style: Theme.of(context).textTheme.bodyMedium
          ),
          FlexiTextButton(
            width: .82.sw, 
            height: .06.sh, 
            text: 'Send',
            backgroundColor: FlexiColor.primary,
            onPressed: () async {
              Map<String, dynamic> contentData = content.toJson();
              File? contentFile;

              contentData.addAll({'command': 'playerContent', 'deviceId': '', 'requestTime': ''});
              contentData['textColor'] = FlexiColor.stringToColor(contentData['textColor']).toString();
              contentData['backgroundColor'] = FlexiColor.stringToColor(contentData['backgroundColor']).toString();
              contentData.remove('textSizeType');
              // content 배경이 이미지 혹은 비디오인 경우
              if(content.backgroundType != 'color') {
                contentFile = await ref.watch(contentInfoControllerProvider.notifier).getContentFile();
                if(contentFile == null) {
                  FlexiUtils.showMsg('The background file for this content is missing');
                  return;
                }
              }
              contentData.remove('filePath');
              contentData.remove('fileThumbnail');

              var selectDevices = ref.read(selectDevicesProvider);
              ref.watch(totalTaskProvider.notifier).state = selectDevices.length;
              OverlayEntry progressOverlay = OverlayEntry(builder: (context) => const ProgressOverlay());
              Navigator.of(context).overlay!.insert(progressOverlay);

              var successTask = 0;
              var socketClient = ref.watch(socketClientControllerProvider.notifier);
              
              if(content.backgroundType == 'color') {
                for(var device in selectDevices) {
                  if(await socketClient.connect(device.ip)) {
                    contentData['deviceId'] = device.deviceId;
                    contentData['requestTime'] = DateTime.now().toUtc().toIso8601String();
                    await socketClient.sendData(contentData);
                    successTask++;
                  }
                  ref.watch(completeTaskProvider.notifier).state = ref.watch(completeTaskProvider) + 1;
                  if(!await socketClient.disconnect()) ref.invalidate(socketClientControllerProvider);
                  await Future.delayed(const Duration(milliseconds: 500));
                }
              } else {
                for(var device in selectDevices) {
                  if(await socketClient.connect(device.ip)) {
                    contentData['deviceId'] = device.deviceId;
                    contentData['requestTime'] = DateTime.now().toUtc().toIso8601String();
                    await socketClient.sendFile(content.fileName, contentFile!);
                    await socketClient.sendData(contentData);
                    successTask++;
                  }
                  ref.watch(completeTaskProvider.notifier).state = ref.watch(completeTaskProvider) + 1;
                  if(!await socketClient.disconnect()) ref.invalidate(socketClientControllerProvider);
                  await Future.delayed(const Duration(milliseconds: 500));
                }
              }

              Fluttertoast.showToast(
                msg: 'Success $successTask device (Fail ${selectDevices.length - successTask} device)',
                backgroundColor: Colors.black.withOpacity(.8),
                textColor: Colors.white,
                fontSize: .02875.sh
              ).whenComplete(() {
                ref.invalidate(totalTaskProvider);
                ref.invalidate(completeTaskProvider);
                ref.invalidate(selectDevicesProvider);
                progressOverlay.remove();
                if(context.mounted) {
                  context.pop();
                  context.go('/content/info');
                }
              });
            }
          ),
          SizedBox(
            width: .82.sw, 
            height: .06.sh, 
            child: TextButton(
              onPressed: () => context.pop(), 
              child: Text('Cancel', style: Theme.of(context).textTheme.labelLarge)
            )
          )
        ]
      )
    );
  }
}