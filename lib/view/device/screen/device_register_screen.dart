import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/device/controller/device_register_controller.dart';
import '../../../feature/setting/controller/app_setting_controller.dart';
import '../../../util/ui/colors.dart';
import '../../../util/ui/fonts.dart';
import '../../common/component/search_bar.dart';
import '../modal/device_setup_modal.dart';



class DeviceRegisterScreen extends ConsumerStatefulWidget {
  const DeviceRegisterScreen({super.key, required this.rootContext});
  final BuildContext rootContext;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeviceRegisterScreenState();
}

class _DeviceRegisterScreenState extends ConsumerState<DeviceRegisterScreen> {

  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.go('/device/setWifi'),
                  icon: Icon(Icons.arrow_back_ios, size: .03.sh, color: FlexiColor.primary),
                ),
                Text('Select Device', style: FlexiFont.semiBold20),
                TextButton(
                  onPressed: () async {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: widget.rootContext,
                      builder: (context) => const DeviceSetupModal()
                    );
                  },
                  child: Text('OK', style: FlexiFont.regular16.copyWith(color: FlexiColor.primary))
                )
              ],
            ),
            SizedBox(height: .03.sh),
            FlexiSearchBar(
              hintText: 'Search your device',
              onChanged: (value) => setState(() {
                _searchText = value;
              })
            ),
            SizedBox(height: .02.sh),
            Container(
              width: .89.sw,
              height: .7.sh,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(.015.sh)
              ),
              child: ref.watch(appSettingControllerProvider)['registerOption'] == 'Hotspot' ? accessibleDeviceHotspots() : accessibleDeviceBluetooths(),
            )
          ],
        ),
      ),
    );
  }

  Widget accessibleDeviceHotspots() {
    var selectDevices = ref.watch(selectDeviceHotspotsProvider);
    return ref.watch(accessibleDeviceHotspotsProvider).when(
      data: (stream) {
        return StreamBuilder(
          stream: stream, 
          builder: (context, snapshot) {
            var hotspots = snapshot.data ?? List.empty();
            if(hotspots.isEmpty) {
              return Center(
                child: CircularProgressIndicator(color: FlexiColor.primary),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: hotspots.length,
              itemBuilder: (context, index) => hotspots[index].contains(_searchText) ? GestureDetector(
                onTap: () {
                  if(selectDevices.contains(hotspots[index])) {
                    selectDevices.remove(hotspots[index]);
                    ref.watch(selectDeviceHotspotsProvider.notifier).state = [...selectDevices];
                  } else {
                    ref.watch(selectDeviceHotspotsProvider.notifier).state = [...selectDevices, hotspots[index]];
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(.02.sh),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: FlexiColor.grey[400]!))),
                  child: Row(
                    children: [
                      selectDevices.contains(snapshot.data![index]) ?
                        Icon(Icons.check_circle, size: .025.sh, color: FlexiColor.primary) :
                        Icon(Icons.check_circle_outline, size: .025.sh, color: FlexiColor.grey[600]),
                      const SizedBox(width: 12),
                      Icon(Icons.wifi, color: Colors.black, size: .025.sh),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: .6.sw,
                        child: Text(
                          hotspots[index], 
                          style: FlexiFont.regular16,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )
                      )
                    ],
                  ),
                ),
              ) : const SizedBox.shrink(),
            );
          },
        );
      },
      error: (error, stackTrace) => Center(
        child: Text('error during scan hotspot', style: FlexiFont.regular14),
      ), 
      loading: () => Center(
        child: CircularProgressIndicator(color: FlexiColor.primary),
      )
    );
  }

  Widget accessibleDeviceBluetooths() {
    var selectDevices = ref.watch(selectDeviceBluetoothsProvider);
    var devices = ref.watch(accessibleDeviceBluetoothControllerProvider);
    if(devices.isEmpty) {
      return Center(
        child: CircularProgressIndicator(color: FlexiColor.primary),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: devices.length,
      itemBuilder: (context, index) => devices[index].advertisement.name!.contains(_searchText) ? GestureDetector(
        onTap: () {
          if(selectDevices.contains(devices[index])) {
            selectDevices.remove(devices[index]);
            ref.watch(selectDeviceBluetoothsProvider.notifier).state = [...selectDevices];
          } else {
            ref.watch(selectDeviceBluetoothsProvider.notifier).state = [...selectDevices, devices[index]];
          }
        },
        child: Container(
          padding: EdgeInsets.all(.02.sh),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: FlexiColor.grey[400]!))),
          child: Row(
            children: [
              selectDevices.contains(devices[index]) ?
                Icon(Icons.check_circle, size: .025.sh, color: FlexiColor.primary) :
                Icon(Icons.check_circle_outline, size: .025.sh, color: FlexiColor.grey[600]),
              const SizedBox(width: 12),
              Icon(Icons.bluetooth, color: Colors.black, size: .025.sh),
              const SizedBox(width: 8),
              SizedBox(
                width: .6.sw,
                child: Text(
                  devices[index].advertisement.name!, 
                  style: FlexiFont.regular16,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
              )
            ],
          ),
        ),
      ) : const SizedBox.shrink(),
    );
  }
  
}