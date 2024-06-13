import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/device/controller/device_setup_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class QrcodeLoadScreen extends ConsumerStatefulWidget {
  const QrcodeLoadScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrcodeLoadScreenState();
}

class _QrcodeLoadScreenState extends ConsumerState<QrcodeLoadScreen> {

  @override
  Widget build(BuildContext context) {

    final localStorageController = ref.watch(localStorageControllerProvider.notifier);
    final localStorageFiles = ref.watch(localStorageControllerProvider);
    final selectFileIndex = StateProvider<int>((ref) => -1);  
    ref.watch(registerDeviceInfoProvider.notifier);

    return Scaffold(
      backgroundColor: FlexiColor.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw, bottom: .02.sh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.go('/device/setWifi'),
                  icon: Icon(Icons.arrow_back_ios, color: FlexiColor.primary, size: .03.sh),
                ),
                Text('Load QRCode Image', style: FlexiFont.semiBold20),
                TextButton(
                  onPressed: () async {
                    if(ref.watch(selectFileIndex) != -1) {
                      var selectedFile = await localStorageFiles[ref.watch(selectFileIndex)].file;
                      if(selectedFile != null) {
                        if(await ref.watch(wifiCredentialsControllerProvider.notifier).scanQrcodeImage(selectedFile)) {
                          context.go('/device/setWifi');
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Invalid QR Code.',
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: Colors.white,
                            textColor: FlexiColor.secondary
                          );
                        }
                      }
                    }
                  }, 
                child: Text('Load', style: FlexiFont.regular16.copyWith(color: FlexiColor.primary)),
                )
              ],
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if(notification is ScrollEndNotification && notification.metrics.pixels == notification.metrics.maxScrollExtent) localStorageController.nextLoad();
                return true;
              },
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3
                ), 
                itemCount: localStorageFiles.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => ref.watch(selectFileIndex.notifier).state = index,
                    child: FutureBuilder(
                      future: localStorageFiles[index].thumbnailData,
                      builder: (context, snapshot) {
                        if(snapshot.hasData && snapshot.data != null) {
                          return Consumer(
                            builder: (context, ref, child) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: ref.watch(selectFileIndex) == index ? FlexiColor.primary : FlexiColor.grey[600]!
                                  )
                                ),
                                child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                              );
                            },
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  );
                },
              ),
            )
          )
        ],
      ),
    );
  }

}