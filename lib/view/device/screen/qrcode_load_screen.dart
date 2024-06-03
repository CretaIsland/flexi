import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../common/providers/local_storage_provider.dart';
import '../../../feature/device/controller/wifi_setup_controller.dart';
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

    final selectedFileIndex = StateProvider<int>((ref) => -1);
    final galleryFiles = ref.watch(localStorageProvider);
    final galleryController = ref.watch(localStorageProvider.notifier);
    final wifiCredentialsController = ref.watch(wifiCredentialsControllerProvider.notifier);


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
                  onPressed: () async {
                    if(ref.watch(selectedFileIndex) != -1) {
                      var selectedFile = await galleryFiles[ref.watch(selectedFileIndex)].file;
                      if(selectedFile != null) {
                        if(await wifiCredentialsController.scanQrcodeImage(selectedFile)) {
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
            SizedBox(height: .02.sh),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if(notification is ScrollEndNotification && notification.metrics.pixels == notification.metrics.maxScrollExtent) galleryController.nextLoad();
                  return true;
                },
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3
                  ), 
                  itemCount: galleryFiles.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => ref.watch(selectedFileIndex.notifier).state = index,
                      child: FutureBuilder(
                        future: galleryFiles[index].thumbnailData,
                        builder: (context, snapshot) {
                          if(snapshot.hasData && snapshot.data != null) {
                            return Consumer(
                              builder: (context, ref, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.0,
                                      color: ref.watch(selectedFileIndex) == index ? FlexiColor.primary : FlexiColor.grey[600]!
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
      ),
    );
  }

}