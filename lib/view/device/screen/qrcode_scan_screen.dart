import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../feature/device/controller/device_register_controller.dart';
import '../../../util/design/colors.dart';



class QrcodeScanScreen extends ConsumerStatefulWidget {
  const QrcodeScanScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrcodeScanScreenState();
}

class _QrcodeScanScreenState extends ConsumerState<QrcodeScanScreen> {

  Barcode? barcode;
  QRViewController? _qrViewController;

  @override
  void dispose() {
    super.dispose();
    _qrViewController?.dispose();
  }

  Future<bool> getWiFiCredential(String code) async {
    Map<String, String> credential = {};
    try {
      if(code.contains('WIFI')) {
        List<String> parts = code.split(';');
        for(var part in parts) {
          List<String> value = part.split(':');
          if(value.contains('S')) {
            credential['ssid'] = value.last;
          } else if(value.contains('T')) {
            credential['security'] = value.last;
          } else if(value.contains('P')) {
            credential['password'] = value.last;
          }
        }
        ref.watch(registerDataControllerProvider.notifier).setNetwork(
          credential['ssid'] ?? '', 
          credential['security'] ?? '', 
          credential['password'] ?? ''
        );

        return true;
      }
    } catch (error) {
      print('Error at QrcodeScanScreen.getWiFiCredential >>> $error');
    } 
    return false;
  }

  void onQRViewCreated(QRViewController controller) {
    _qrViewController = controller;
    _qrViewController!.scannedDataStream.listen((data) {
      if(data.code != null) {
        _qrViewController!.pauseCamera();
        getWiFiCredential(data.code!).then((value) {
          if(value) {
            if(context.mounted) context.go('/device/setWifi');
          } else {
            if(context.mounted) {
              Fluttertoast.showToast(
                msg: 'Invalid QRCode',
                backgroundColor: Colors.black.withOpacity(.8),
                textColor: Colors.white,
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize
              ).whenComplete(() => _qrViewController!.resumeCamera());
            }
          }
        });
      }
    });
  }

  Widget buildQRView(BuildContext context) {
    ref.watch(registerDataControllerProvider);
    return QRView(
      key: GlobalKey(), 
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: FlexiColor.primary,
        borderRadius: .01.sh,
        borderLength: 20,
        borderWidth: 5,
        cutOutSize: .8.sw
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(registerDataControllerProvider);
    return Scaffold(
      body: Stack(
        children: [
          buildQRView(context),
          Padding(
            padding: EdgeInsets.only(left: .055.sw, top: .04.sh),
            child: IconButton(
              onPressed: () => context.go('/device/setWifi'), 
              icon: Icon(Icons.arrow_back_ios_rounded, color: FlexiColor.primary, size: .03.sh)
            )
          )
        ]
      )
    );
  }
}