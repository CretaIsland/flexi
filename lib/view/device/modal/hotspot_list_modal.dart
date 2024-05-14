import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../components/loading_overlay.dart';
import '../../../components/search_bar.dart';
import '../../../feature/device/controller/network_controller.dart';
import '../../../feature/device/model/network_info.dart';
import '../../../feature/device/provider/network_provider.dart';
import '../../../main.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';



class HotspotListModal extends ConsumerWidget {
  HotspotListModal({super.key});
  final selectedNetwork = StateProvider<NetworkInfo?>((ref) => null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              child: networkListView()
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: screenWidth * .89,
              height: screenHeight * .06,
              child: TextButton(
                onPressed: () async {
                  if(ref.watch(selectedNetwork) != null) {
                    OverlayEntry loadingOverlay = OverlayEntry(builder: (_) => const LoadingOverlay());
                    Navigator.of(context).overlay!.insert(loadingOverlay);
                    // connect network
                    final value = await ref.read(networkControllerProvider.notifier).connectNetwork(
                      ssid: ref.watch(selectedNetwork)!.ssid!, 
                      password: "sqisoft74307"
                    );
                    if(value) {
                      context.pop();
                      context.go("/device/setTimezone");
                    }
                    loadingOverlay.remove();
                  }
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

  Consumer networkListView() {
    return Consumer(
      builder: (context, ref, child) {
        return ref.watch(networkStreamProvider).when(
          data: (data) {
            return StreamBuilder(
              stream: data, 
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  if(snapshot.data != null) {
                    final networks = snapshot.data!;
                    return ListView.builder(
                      itemCount: networks.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => ref.watch(selectedNetwork.notifier).state = networks[index],
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Icon(
                                  ref.watch(selectedNetwork) == networks[index] ? Icons.check_circle : Icons.check_circle_outline, 
                                  color: ref.watch(selectedNetwork) == networks[index] ? FlexiColor.primary : FlexiColor.grey[600], 
                                  size: 16
                                ),
                                const SizedBox(width: 16),
                                const Icon(Icons.wifi, color: Colors.black, size: 16),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: screenWidth * .6,
                                  child: Text(networks[index].ssid ?? "", 
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
                  }
                  return const SizedBox.shrink();
                } else if(snapshot.hasError) {
                  return const Center(child: Text("error during search wifi"));
                } else {  
                  return Center(child: CircularProgressIndicator(color: FlexiColor.primary));
                }
              },
            );
          }, 
          error: (error, stackTrace) => const Center(child: Text("error during search wifi")), 
          loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary))
        );
      },
    );
  }

}