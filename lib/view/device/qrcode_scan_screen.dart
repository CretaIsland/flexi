import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../main.dart';
import '../../utils/ui/colors.dart';



class QrcodeScanScreen extends StatefulWidget {
  const QrcodeScanScreen({super.key});

  @override
  State<QrcodeScanScreen> createState() => _QrcodeScanScreenState();
}

class _QrcodeScanScreenState extends State<QrcodeScanScreen> {

  Barcode? barcode;
  QRViewController? controller;


  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildQrView(context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * .05, left: screenWidth * .02),
                child: IconButton(
                  onPressed: () {
                    controller?.pauseCamera();
                    context.go("/device/setWifi");
                  },
                  icon: Icon(Icons.arrow_back_ios_new_rounded, color: FlexiColor.primary),
                  iconSize: screenHeight * .04,
                ),
              )
            ],
          )
        ]
      )
    );
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: GlobalKey(),
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: FlexiColor.primary,
        borderRadius: 10,
        borderLength: 20,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8
      )
    );
  }

  void onQRViewCreated(QRViewController qrViewController) {
    controller = qrViewController;
    controller!.scannedDataStream.listen((scanData) async {
      setState(() {
        barcode = scanData;
      });
    });
  }

}