import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../feature/device/controller/device_register_controller.dart';
import '../../../util/design/colors.dart';
import '../../../util/utils.dart';



class QrcodeScanScreen extends ConsumerStatefulWidget {
  const QrcodeScanScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrcodeScanScreenState();
}

class _QrcodeScanScreenState extends ConsumerState<QrcodeScanScreen> {

  final MobileScannerController _controller = MobileScannerController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(registerDataControllerProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: MobileScanner(
              controller: _controller,
              onDetect: (capture) async {
                try {
                  await _controller.stop();
                  if(capture.barcodes.first.wifi != null) {
                    ref.watch(registerDataControllerProvider.notifier).setNetwork(
                      capture.barcodes.first.wifi!.ssid ?? '', 
                      capture.barcodes.first.wifi!.encryptionType.name.toUpperCase(), 
                      capture.barcodes.first.wifi!.password ?? ''
                    );
                    if(context.mounted) context.go('/device/setWifi');
                  } else {
                    await _controller.start();
                    FlexiUtils.showMsg('Invalid QR-Code');
                  }
                } catch (error) {
                  print('Error at Scan QR-Code >>> $error');
                  await _controller.start();
                  FlexiUtils.showMsg('Invalid QR-Code');
                }
              }
            )
          ),
          Padding(
            padding: EdgeInsets.only(left: .055.sw, top: .065.sh),
            child: IconButton(
              onPressed: () => context.go('/device/setWifi'),
              icon: Icon(Icons.arrow_back_ios, size: .03.sh, color: FlexiColor.primary)
            )
          )
        ]
      )
    );
  }
}