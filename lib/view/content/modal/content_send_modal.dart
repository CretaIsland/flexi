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
import '../../../feature/device/controller/connected_device_controller.dart';
import '../../../util/design/colors.dart';
import '../../../util/utils.dart';



class ContentSendModal extends ConsumerWidget {
  const ContentSendModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(contentInfoControllerProvider);
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
          Text('Are you sure?', style: Theme.of(context).textTheme.displayMedium),
          Text('This will send content \nto device', style: Theme.of(context).textTheme.bodyMedium),
          FlexiTextButton(
            width: .82.sw, 
            height: .06.sh,  
            text: 'Delete',
            backgroundColor: FlexiColor.secondary,
            onPressed: () async {
              Map<String, dynamic> content = ref.read(contentInfoControllerProvider).toJson();
              content.addAll({'command': 'playerContent', 'deviceId': '', 'requestTime': ''});
              content['textColor'] = FlexiColor.stringToColor(content['textColor']).toString();
              content['backgroundColor'] = FlexiColor.stringToColor(content['backgroundColor']).toString();
              
              File? contentFile;
              if(content['backgroundType'] != 'color') {
                contentFile = await ref.watch(contentInfoControllerProvider.notifier).getContentFile();
                if(contentFile == null) {
                  FlexiUtils.showAlertMsg('The background file for this content is missing');
                  return;
                }
              }
              content.remove('filePath');
              content.remove('fileThumbnail');

              var selectDevices = ref.read(selectDevicesProvider);
              ref.watch(totalTaskProvider.notifier).state = selectDevices.length;
              OverlayEntry progressOverlay = OverlayEntry(builder: (context) => const ProgressOverlay());
              Navigator.of(context).overlay!.insert(progressOverlay);

              var successTask = 0;
              var socketClientController = ref.watch(socketClientControllerProvider.notifier);

              if(content['backgroundType'] == 'color') {
                for(var device in selectDevices) {
                  if(await socketClientController.connect(device.ip)) {
                    content['deviceId'] = device.deviceId;
                    content['requestTime'] = DateTime.now().toUtc().toIso8601String();
                    await socketClientController.sendData(content);
                    successTask++;
                  }
                  ref.watch(completeTaskProvider.notifier).state = ref.watch(completeTaskProvider) + 1;
                  if(!await ref.watch(socketClientControllerProvider.notifier).disconnect()) ref.invalidate(socketClientControllerProvider);
                  await Future.delayed(const Duration(milliseconds: 500));
                }
              } else {
                for(var device in selectDevices) {
                  if(await socketClientController.connect(device.ip)) {
                    content['deviceId'] = device.deviceId;
                    content['requestTime'] = DateTime.now().toUtc().toIso8601String();
                    await socketClientController.sendFile(content['fileName'], contentFile!);
                    await socketClientController.sendData(content);
                    successTask++;
                  }
                  ref.watch(completeTaskProvider.notifier).state = ref.watch(completeTaskProvider) + 1;
                  if(!await ref.watch(socketClientControllerProvider.notifier).disconnect()) ref.invalidate(socketClientControllerProvider);
                  await Future.delayed(const Duration(milliseconds: 500));
                }
              }

              Fluttertoast.showToast(
                msg: 'Success $successTask device (Fail ${selectDevices.length - successTask} device)',
                backgroundColor: Colors.black.withOpacity(.8),
                textColor: Colors.white,
                fontSize: .02875.sh
              ).whenComplete(() {
                ref.invalidate(selectDevicesProvider);
                ref.invalidate(totalTaskProvider);
                ref.invalidate(completeTaskProvider);
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