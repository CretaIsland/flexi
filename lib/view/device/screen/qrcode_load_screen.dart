import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import '../../../core/controller/local_storage_controller.dart';
import '../../../feature/device/controller/device_register_controller.dart';
import '../../../util/design/colors.dart';
import '../../../util/utils.dart';



final selectImageIndexProvider = StateProvider<int>((ref) => -1);

class QrcodeLoadScreen extends ConsumerWidget {
  const QrcodeLoadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var images = ref.watch(galleryImageControllerProvider);
    ref.watch(galleryImageControllerProvider);
    
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
                Text('Load QR-Code', style: Theme.of(context).textTheme.displaySmall),
                TextButton(
                  onPressed: () async {
                    if(ref.read(selectImageIndexProvider) == -1) {
                      FlexiUtils.showAlertMsg('Please select image');
                      return;
                    }
                    
                    var fileBytes = await images[ref.read(selectImageIndexProvider)].originBytes;
                    if(fileBytes == null) {
                      FlexiUtils.showAlertMsg('Error during load QR-Code');
                      return;
                    }

                    var codeValue = await QRCodeDartScanDecoder(formats: [BarcodeFormat.qrCode]).decodeFile(XFile.fromData(fileBytes));
                    if(codeValue == null) {
                      FlexiUtils.showAlertMsg('Invalid QR-Code');
                      return;
                    }

                    var wifiCredential = FlexiUtils.getWifiCredential(codeValue.text);
                    if(wifiCredential == null) {
                      FlexiUtils.showAlertMsg('Invalid QR-Code');
                      return;
                    }

                    var registerData = ref.watch(registerDataProvider);
                    registerData['ssid'] = wifiCredential['ssid']!;
                    registerData['security'] = wifiCredential['security']!;
                    registerData['password'] = wifiCredential['password']!;
                    ref.watch(registerDataProvider.notifier).state = registerData;

                    if(context.mounted) {
                      ref.invalidate(selectImageIndexProvider);
                      context.go('/device/setWifi');
                    }
                  },
                  child: Text('Load', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.primary))
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
                  onTap: () => ref.watch(selectImageIndexProvider.notifier).state = index,
                  child: FutureBuilder(
                    future: images[index].thumbnailData, 
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                        return Consumer(
                          builder: (context, ref, child) => Container(
                            decoration: BoxDecoration(
                              border: ref.watch(selectImageIndexProvider) == index ? Border.all(color: FlexiColor.primary, width: 3)
                                : Border.all(color: FlexiColor.grey[400]!)
                            ),
                            child: Image.memory(snapshot.data!, fit: BoxFit.cover)
                          )
                        );
                      }
                      return const SizedBox();
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