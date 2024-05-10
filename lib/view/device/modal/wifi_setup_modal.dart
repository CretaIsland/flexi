import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../../../components/loading_overlay.dart';
import '../../../feature/device/controller/network_controller.dart';
import '../../../main.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';



class WifiSetupModal extends ConsumerWidget {
  const WifiSetupModal({super.key, required this.ssid, required this.type, required this.password});
  final String ssid;
  final String type;
  final String password;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: screenWidth * .93,
      height: screenHeight * .35,
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .05, right: screenWidth * .055),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenHeight * .025)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Wifi Setup", style: FlexiFont.semiBold24),
          const SizedBox(height: 14),
          Text("Press Connect once \nthe device has rebooted.", style: FlexiFont.regular16),
          SizedBox(height: screenHeight * .02),
          SizedBox(
            width: screenWidth * .82,
            height: screenHeight * .06,
            child: TextButton(
              onPressed: () async {
                OverlayEntry loadingOverlay = OverlayEntry(builder: (_) => const LoadingOverlay());
                Navigator.of(context).overlay!.insert(loadingOverlay);
                // connect network
                final value = await ref.read(networkControllerProvider.notifier).connectNetwork(
                  ssid: ssid, 
                  password: password,
                  security: type.contains("WEP") ? NetworkSecurity.WEP : NetworkSecurity.WPA
                );
                if(value) {
                  context.pop();
                  context.go("/device/list");
                  loadingOverlay.remove();
                } else {
                  context.pop();
                  loadingOverlay.remove();
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenHeight * .01))
                ),
                backgroundColor: MaterialStateProperty.all(FlexiColor.primary),
              ), 
              child: Text("Connect", style: FlexiFont.semiBold16.copyWith(color: Colors.white))
            ),
          ),
          SizedBox(height: screenHeight * .01),
          Center(
            child: TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text("Cancel", style: FlexiFont.regular16),
            ),
          )
        ],
      ),
    );
  }

}
