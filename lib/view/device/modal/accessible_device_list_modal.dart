import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/loading_overlay.dart';
import '../../../component/search_bar.dart';
import '../../../component/text_button.dart';
import '../../../feature/device/controller/device_setup_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class AccessibleDeviceListModal extends ConsumerWidget {
  const AccessibleDeviceListModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    ref.invalidate(selectHotspotProvider);
    ref.invalidate(accessibilityNetworksProvider);

    return Container(
      width: 1.sw,
      height: .9.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .07.sh, right: .055.sw),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(.025.sh), topRight: Radius.circular(.025.sh))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Device to use \nwith Digital Barricade', style: FlexiFont.regular20),
          SizedBox(height: .02.sh),
          FlexiSearchBar(
            hintText: 'Search your device',
            onChanged: (value) {},
          ),
          SizedBox(height: .03.sh),
          Container(
            width: .89.sw,
            height: .5.sh,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.01.sh)
            ),
            child: Consumer(
              builder: (context, ref, child) {
                return ref.watch(accessibilityNetworksProvider).when(
                  data: (stream) {
                    return StreamBuilder(
                      stream: stream, 
                      builder: (context, snapshot) {
                        if(snapshot.data != null ) {
                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => ref.watch(selectHotspotProvider.notifier).state = snapshot.data![index],
                                child: Padding(
                                  padding: EdgeInsets.all(.02.sh),
                                  child: Row(
                                    children: [
                                      ref.watch(selectHotspotProvider) == snapshot.data![index] ?
                                        Icon(Icons.check_circle, color: FlexiColor.primary, size: .025.sh) : 
                                        Icon(Icons.check_circle_outline, color: FlexiColor.grey[600], size: .025.sh),
                                      const SizedBox(width: 12),
                                      Icon(Icons.wifi, color: Colors.black, size: .025.sh),
                                      const SizedBox(width: 8),
                                      SizedBox(
                                        width: .6.sw,
                                        child: Text(
                                          snapshot.data![index].ssid ?? '', 
                                          style: FlexiFont.regular16,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        )
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400]),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(color: FlexiColor.primary),
                        );
                      },
                    );
                  }, 
                  error: (error, stackTrace) => Center(
                    child: Text('error during scan accessible device', style: FlexiFont.regular14),
                  ), 
                  loading: () => Center(
                    child: CircularProgressIndicator(color: FlexiColor.primary),
                  )
                );
              },
            ),
          ),
          SizedBox(height: .02.sh),
          FlexiTextButton(
            width: .89.sw, 
            height: .06.sh, 
            text: 'Add',
            fillColor: FlexiColor.primary,
            onPressed: () async {
              if(ref.watch(selectHotspotProvider) != null) {
                OverlayEntry loadingOverlay = OverlayEntry(builder: (_) => const LoadingOverlay());
                Navigator.of(context).overlay!.insert(loadingOverlay);
                // connect network
                final value = await ref.read(networkControllerProvider.notifier).connect(
                  ssid: ref.watch(selectHotspotProvider)!.ssid!, 
                  password: "esl!UU8x"
                  // password: "sqisoft74307"
                );
                if(value) {
                  context.pop();
                  context.go("/device/setTimezone");
                }
                loadingOverlay.remove();
              }
            },
          )
        ],
      ),
    );
  }

}