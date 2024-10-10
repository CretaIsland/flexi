import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import '../../../feature/device/controller/device_register_controller.dart';
import '../../../util/design/colors.dart';
import '../../../util/utils.dart';



class QrcodeScanScreen extends ConsumerStatefulWidget {
  const QrcodeScanScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrcodeScanScreenState();
}

class _QrcodeScanScreenState extends ConsumerState<QrcodeScanScreen> {

  final QRCodeDartScanController _controller = QRCodeDartScanController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(registerDataProvider);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: QRCodeDartScanView(
              controller: _controller,
              typeScan: TypeScan.live,
              formats: const [BarcodeFormat.qrCode],
              onCapture: (capture) {
                var wifiCredential = FlexiUtils.getWifiCredential(capture.text);
                if(wifiCredential != null) {
                  var registerData = ref.watch(registerDataProvider);
                  registerData['ssid'] = wifiCredential['ssid']!;
                  registerData['security'] = wifiCredential['security']!;
                  registerData['password'] = wifiCredential['password']!;
                  ref.watch(registerDataProvider.notifier).state = registerData;
                  context.go('/device/setWifi');
                } else {
                  FlexiUtils.showAlertMsg('Invalid QR-Code');
                }
              }
            )
          ),
          Padding(
            padding: EdgeInsets.only(left: .055.sw, top: .04.sh),
            child: GestureDetector(
              onTap: () => context.go('/device/setWifi'),
              child: Icon(Icons.arrow_back_ios, size: .025.sh, color: FlexiColor.primary)
            ),
          )
        ]
      )
    );
  }
}