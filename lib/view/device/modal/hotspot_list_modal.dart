import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/providers/network_providers.dart';
import '../../../components/loading_overlay.dart';
import '../../../components/search_bar.dart';
import '../../../main.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';



class HotspotListModal extends ConsumerWidget {
  HotspotListModal({super.key});
  final selectedIndex = StateProvider<int>((ref) => -1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    List<WifiNetworkInfo> accessWifiList = [];

    return Container(
      width: screenWidth,
      height: screenHeight * .9,
      padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .07, right: screenWidth * .055),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(screenHeight * .025), topRight: Radius.circular(screenHeight * .025))
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Device to use \nwith Digital Barricade", style: FlexiFont.regular20),
            const SizedBox(height: 16),
            const FlexiSearchBar(hintText: "Search your devices"),
            const SizedBox(height: 24),
            Container(
              width: screenWidth * .89,
              height: screenHeight * .5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenHeight * .01)
              ),
              child: ref.watch(wifisProvider).when(
                data: (data) {
                  accessWifiList = data;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => ref.watch(selectedIndex.notifier).state = index,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(
                                ref.watch(selectedIndex) == index ? Icons.check_circle : Icons.check_circle_outline, 
                                color: ref.watch(selectedIndex) == index ? FlexiColor.primary : FlexiColor.grey[600], 
                                size: 16
                              ),
                              const SizedBox(width: 16),
                              const Icon(Icons.wifi, color: Colors.black, size: 16),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: screenWidth * .6,
                                child: Text(accessWifiList[index].ssid ?? "", 
                                  style: FlexiFont.regular16, 
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                )
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }, 
                error: (error, stackTrace) => const Center(child: Text("error during search wifi")), 
                loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary))
              )
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: screenWidth * .89,
              height: screenHeight * .06,
              child: TextButton(
                onPressed: () async {
                  OverlayEntry loadingOverlay = OverlayEntry(builder: (_) => const LoadingOverlay());
                  Navigator.of(context).overlay!.insert(loadingOverlay);
                  // connect wifi
                  await ref.watch(networkNotifierProvider.notifier).change(ssid: accessWifiList[ref.watch(selectedIndex)].ssid!, password: "sqisoft74307");
                  loadingOverlay.remove();
                  context.pop();
                  context.go("/device/setTimezone");
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenHeight * .01))
                  ),
                  backgroundColor: MaterialStateProperty.all(FlexiColor.primary),
                ), 
                child: Text("Add", style: FlexiFont.semiBold16.copyWith(color: Colors.white))
              ),
            )
          ],
        ),
      ),
    );
  }

}