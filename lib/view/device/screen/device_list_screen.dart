import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/search_bar.dart';
import '../../../feature/device/controller/device_info_controller.dart';
import '../../../feature/device/controller/device_list_controller.dart';
import '../../../feature/device/model/device_info.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';
import '../modal/hotspot_list_modal.dart';
import '../modal/device_reset_modal.dart';



final searchTextProvider = StateProvider<String>((ref) => '');
final selectModeProvider = StateProvider<bool>((ref) => false);
final selectAllProvider = StateProvider<bool>((ref) => false);
final selectDevicesProvider = StateProvider<List<DeviceInfo>>((ref) => List.empty());


class DeviceListScreen extends ConsumerStatefulWidget {
  const DeviceListScreen({super.key, required this.rootContext});
  final BuildContext rootContext;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends ConsumerState<DeviceListScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => ref.invalidate(searchTextProvider));
  }

  @override
  Widget build(BuildContext context) {

    var devices = ref.watch(deviceListControllerProvider);

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
                  onTap: () async {
                    if(ref.watch(selectModeProvider)) {
                      showModalBottomSheet(
                        context: widget.rootContext, 
                        backgroundColor: Colors.transparent,
                        builder: (context) => const DeviceResetModal()
                      );
                    } else {
                      if(Platform.isIOS) {
                        context.go('/device/setTimezone');
                      } else {
                        showModalBottomSheet(
                          context: widget.rootContext, 
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const AccessibleDeviceListModal()
                        );
                      }
                    }
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
              onChanged: (value) => ref.watch(searchTextProvider.notifier).state = value,
            ),
            SizedBox(height: .025.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('${devices.length} Devices', style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
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
                      Text('${devices.length} Devices', style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () {
                          if(ref.watch(selectModeProvider)) {
                            ref.watch(selectAllProvider.notifier).state = false;
                            ref.watch(selectDevicesProvider.notifier).state = List.empty();
                          } else {
                            ref.watch(selectAllProvider.notifier).state = true;
                            ref.watch(selectDevicesProvider.notifier).state = devices;
                          }
                        },
                        child: Icon(Icons.refresh, color: FlexiColor.grey[600], size: .02.sh),
                      )
                    ],
                  )
                )
              ],
            ),
            SizedBox(height: .015.sh),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      return devices[index].deviceName.contains(ref.watch(searchTextProvider)) ? GestureDetector(
                        onLongPress: () => ref.watch(selectModeProvider.notifier).state = true,
                        onTap: () {
                          if(ref.watch(selectModeProvider)) {
                            if(ref.watch(selectDevicesProvider).contains(devices[index])) {
                              ref.watch(selectDevicesProvider).remove(devices[index]);
                              ref.watch(selectDevicesProvider.notifier).state = ref.watch(selectDevicesProvider);
                            } else {
                              ref.watch(selectDevicesProvider.notifier).state = [...ref.watch(selectDevicesProvider), devices[index]];
                            }
                          } else {
                            ref.watch(deviceInfoControllerProvider.notifier).setDevice(devices[index]);
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
                                      Text(devices[index].deviceName, style: FlexiFont.regular16,)
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: .03.sh),
                                    child: Text(devices[index].deviceId, style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                                  )
                                ],
                              ),
                              Visibility(
                                visible: ref.watch(selectModeProvider),
                                child: ref.watch(selectDevicesProvider).contains(devices[index]) ? 
                                  Icon(Icons.check_circle, color: FlexiColor.secondary, size: .025.sh) :
                                  Icon(Icons.check_circle_outline, color: FlexiColor.grey[600], size: .025.sh)
                              )
                            ],
                          ),
                        ),
                      ) : const SizedBox.shrink();
                    },
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }

}