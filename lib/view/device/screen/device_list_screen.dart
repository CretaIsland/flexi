import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../components/search_bar.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';
import '../modal/accessible_device_list_modal.dart';
import '../modal/device_reset_modal.dart';



final selectModeProvider = StateProvider<bool>((ref) => false);
final selectAllProvider = StateProvider<bool>((ref) => false);
final selectDevicesProvider = StateProvider<List<int>>((ref) => List.empty());


class DeviceListScreen extends ConsumerWidget {
  const DeviceListScreen({super.key, required this.rootContext});
  final BuildContext rootContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.watch(selectModeProvider.notifier).state = false;
        ref.watch(selectAllProvider.notifier).state = false;
        ref.invalidate(selectDevicesProvider);
      },
      child: Container(
        color: FlexiColor.backgroundColor,
        padding: EdgeInsets.only(left: .055.sw, top: .065.sh, right: .055.sw),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Devices', style: FlexiFont.semiBold30),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: rootContext, 
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => ref.watch(selectModeProvider) ? const DeviceResetModal() : AccessibleDeviceListModal(),
                    );
                  },
                  child: Container(
                    width: .04.sh,
                    height: .04.sh,
                    decoration: BoxDecoration(
                      color: ref.watch(selectModeProvider) ? FlexiColor.secondary : FlexiColor.primary,
                      borderRadius: BorderRadius.circular(.02.sh)
                    ),
                    child: Center(
                      child: Icon(
                        ref.watch(selectModeProvider) ? Icons.link_off : Icons.add,
                        color: Colors.white,
                        size: .03.sh,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: .02.sh),
            FlexiSearchBar(
              hintText: 'Search your device',
              onChanged: (value) { },
            ),
            SizedBox(height: .025.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('${15} Devices', style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.refresh, color: FlexiColor.grey[600], size: .02.sh),
                    )
                  ],
                ),
                Visibility(
                  visible: ref.watch(selectModeProvider),
                  child: Row(
                    children: [
                      Text('Select All', style: FlexiFont.regular12,),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () {
                          ref.watch(selectAllProvider.notifier).state = !ref.watch(selectAllProvider);
                        },
                        child: ref.watch(selectAllProvider) ? 
                          Icon(Icons.check_circle, color: FlexiColor.secondary, size: .025.sh) :
                          Icon(Icons.check_circle_outline, color: FlexiColor.grey[600], size: .025.sh)
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: .015.sh),
            Expanded(
              child: deviceListView()
            )
          ],
        ),
      ),
    );
  }

  Consumer deviceListView() {
    return Consumer(
      builder: (context, ref, child) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 15,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () => ref.watch(selectModeProvider.notifier).state = true,
              onTap: () {
                if(ref.watch(selectModeProvider)) {

                } else {
                  context.go('/device/info');
                }
              },
              child: Container(
                width: .89.sw,
                height: .1.sh,
                padding: EdgeInsets.only(left: .04.sw, right: .04.sw),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(.01.sh)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: .02.sh),
                        Row(
                          children: [
                            Icon(Icons.link_rounded, color: FlexiColor.primary, size: .02.sh),
                            SizedBox(width: .015.sh),
                            Text("Device name", style: FlexiFont.regular16,)
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: .03.sh),
                          child: Text("Device ID", style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                          // child: Row(
                          //   children: [
                          //     Icon(Icons.bluetooth, color: FlexiColor.primary, size: screenHeight * .02),
                          //     Text("bluetooth name", style: FlexiFont.regular12.copyWith(color: FlexiColor.primary))
                          //   ],
                          // ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: ref.watch(selectModeProvider),
                      child: ref.watch(selectDevicesProvider).contains(index) ? 
                        Icon(Icons.check_circle, color: FlexiColor.secondary, size: .025.sh) :
                        Icon(Icons.check_circle_outline, color: FlexiColor.grey[600], size: .025.sh)
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

}