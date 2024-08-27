import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

import '../../../core/controller/gallery_controller.dart';
import '../../../feature/device/controller/device_register_controller.dart';
import '../../../util/design/colors.dart';



class QrcodeLoadScreen extends ConsumerStatefulWidget {
  const QrcodeLoadScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrcodeLoadScreenState();
}

class _QrcodeLoadScreenState extends ConsumerState<QrcodeLoadScreen> {

  int _selectFileIndex = -1;

  Future<bool> getWiFiCredentials(File image) async {
    try {
      List<String> wifiEncryptionTypes = ['', 'OPEN', 'WPA', 'WEP'];
      var barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.qrCode]);
      var result = await barcodeScanner.processImage(InputImage.fromFile(image));
      for(var data in result) {
        if(data.type == BarcodeType.wifi) {
          var wifiInfo = data.value as BarcodeWifi;
          ref.watch(registerDataControllerProvider.notifier).setNetwork(
            wifiInfo.ssid ?? '', 
            wifiInfo.encryptionType == null ? wifiEncryptionTypes[0] : wifiEncryptionTypes[wifiInfo.encryptionType!], 
            wifiInfo.password ?? ''
          );
          return true;
        }
      }
    } catch (error) {
      print('error at DeviceRegisterController.setWifiCredentialFromImage >>> $error');
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(registerDataControllerProvider);
    var localFiles = ref.watch(galleryControllerProvider);
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
                Text('Load QRCode Image', style: Theme.of(context).textTheme.displaySmall),
                TextButton(
                  onPressed: () async {
                    if(_selectFileIndex != -1) {
                      var file = await localFiles[_selectFileIndex].loadFile();
                      if(file != null) {
                        if(await getWiFiCredentials(file)) {
                          context.go('/device/setWifi');
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Invalid QR Code.',
                            backgroundColor: Colors.black.withOpacity(.8),
                            textColor: Colors.white,
                            fontSize: Theme.of(context).textTheme.displaySmall!.fontSize
                          );
                        }
                      }
                    }
                  },
                  child: Text('Load', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.primary))
                )
              ],
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if(notification is ScrollEndNotification && notification.metrics.pixels == notification.metrics.maxScrollExtent) ref.watch(galleryControllerProvider.notifier).loadNext();
                return true;
              },
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3
                ), 
                itemCount: localFiles.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => setState(() {
                      _selectFileIndex = index;
                    }),
                    child: FutureBuilder(
                      future: localFiles[index].thumbnailData,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.done) {
                          if(snapshot.data == null) {
                            return const SizedBox.shrink();
                          }
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: _selectFileIndex == index ? FlexiColor.primary : FlexiColor.grey[600]!)
                            ),
                            child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator(color: FlexiColor.primary));
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

}