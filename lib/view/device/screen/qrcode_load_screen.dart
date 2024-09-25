import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import '../../../core/controller/local_storage_controller.dart';
import '../../../feature/device/controller/device_register_controller.dart';
import '../../../util/design/colors.dart';
import '../../../util/utils.dart';



final selectImageIndex = StateProvider((ref) => -1);

class QrcodeLoadScreen extends ConsumerWidget {
  const QrcodeLoadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(registerDataControllerProvider);
    var images = ref.watch(galleryImageControllerProvider);
    return Scaffold(
      backgroundColor: FlexiColor.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw, bottom: .02.sh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.go('/device/setWifi'), 
                  icon: Icon(Icons.arrow_back_ios, size: .03.sh, color: FlexiColor.primary)
                ),
                Text('Set Device Timezone', style: Theme.of(context).textTheme.displaySmall),
                TextButton(
                  onPressed: () async {
                    if(ref.read(selectImageIndex) != -1) {
                      var fileBytes = await images[ref.read(selectImageIndex)].originBytes;
                      if(fileBytes == null) {
                        FlexiUtils.showMsg('Error Load QR-Code');
                        return;
                      }
                      var value = await QRCodeDartScanDecoder(formats: [BarcodeFormat.qrCode]).decodeFile(XFile.fromData(fileBytes));
                      if(value == null) {
                        FlexiUtils.showMsg('Invalid QR-Code');
                        return;
                      }
                      var credential = FlexiUtils.getWifiCredential(value.text);
                      if(credential == null) {
                        FlexiUtils.showMsg('Invalid QR-Code');
                        return;
                      }
                      ref.watch(registerDataControllerProvider.notifier).setNetwork(credential['ssid']!, credential['security']!, credential['password']!);
                      if(context.mounted) context.go('/device/setWifi');
                    } else {
                      FlexiUtils.showMsg('Select image');
                    }
                  }, 
                  child: Text('OK', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.primary))
                )
              ]
            )
          ),
          Expanded(
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (notification) {
                if(notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                  ref.watch(galleryImageControllerProvider.notifier).loadNext();
                }
                return true;
              },
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemCount: images.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => ref.watch(selectImageIndex.notifier).state = index,
                  child: FutureBuilder(
                    future: images[index].thumbnailData, 
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                        return Consumer(
                          builder: (context, ref, child) => Container(
                            decoration: BoxDecoration(
                              border: ref.watch(selectImageIndex) == index ?
                                Border.all(color: FlexiColor.primary, width: 3) :
                                Border.all(color: FlexiColor.grey[400]!)
                            ),
                            child: Image.memory(snapshot.data!, fit: BoxFit.cover)
                          )
                        );
                      }
                      return const SizedBox.shrink();
                    }
                  )
                )
              )
            )
          )
        ]
      )
    );
  }
}