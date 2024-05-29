import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../utils/ui/colors.dart';



class QrcodeScanScreen extends ConsumerStatefulWidget {
  const QrcodeScanScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrcodeScanScreenState();
}

class _QrcodeScanScreenState extends ConsumerState<QrcodeScanScreen> {


  Barcode? barcode;
  QRViewController? _qrcodeController;


  @override
  void dispose() {
    super.dispose();
    _qrcodeController!.dispose();
  }


  void onQRViewCreated(QRViewController qrViewController) {
    _qrcodeController = qrViewController;
    _qrcodeController!.scannedDataStream.listen((scanData) async {
      // 큐알코드 데이터 얻기
    });
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: GlobalKey(), 
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: FlexiColor.primary,
        borderRadius: .01.sh,
        borderLength: 20,
        borderWidth: 5,
        cutOutSize: .8.sw
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildQrView(context),
          Padding(
            padding: EdgeInsets.only(left: .055.sw, top: .03.sh),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: FlexiColor.primary),
              iconSize: .03.sh,
              onPressed: () {
                _qrcodeController?.pauseCamera();
                context.go('/device/setWifi');
              },
            ),
          )
        ],
      ),
    );
  }

}