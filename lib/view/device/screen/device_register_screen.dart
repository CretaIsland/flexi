import 'package:flexi/feature/device/controller/device_register_controller.dart';
import 'package:flexi/feature/setting/controller/setting_controller.dart';
import 'package:flexi/view/device/modal/device_setup_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/search_bar.dart';
import '../../../util/design/colors.dart';



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
    ref.watch(registerDataControllerProvider);
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
                  icon: Icon(Icons.arrow_back_ios_rounded, size: .025.sh, color: FlexiColor.primary)
                ),
                Text('Select Device', style: Theme.of(context).textTheme.displaySmall),
                TextButton(
                  onPressed: () => showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: widget.rootContext,
                    builder: (context) => const DeviceSetupModal()
                  ),
                  child: Text('OK', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.primary))
                )
              ]
            ),
            SizedBox(height: .03.sh),
            FlexiSearchBar(
              hintText: 'Search your device',
              onChanged: (value) => setState(() => _searchText = value),
            ),
            SizedBox(height: .03.sh),
            Container(
              width: .89.sw,
              height: .65.sh,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(.015.sh)
              ),
              child: ref.watch(settingControllerProvider)['registerType'] == 'Hotspot' ? 
                hotspotListView() : 
                bluetoothListView()
            )
          ],
        )
      )
    );
  }

  Widget hotspotListView() {
    var selectHotspots = ref.watch(selectHotspotsProvider);
    return ref.watch(accessibleDeviceHotspotsProvider).when(
      data: (stream) => StreamBuilder(
        stream: stream, 
        builder: (context, snapshot) {
          var hotspots = snapshot.data ?? List.empty();
          return hotspots.isEmpty ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: .03.sh,
                height: .03.sh,
                child: CircularProgressIndicator(
                  color: FlexiColor.grey[600],
                  strokeWidth: 2.5
                )
              ),
              SizedBox(height: .01.sh),
              Text('Scanning for nearby device(s)', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: FlexiColor.grey[600]))
            ]
          ) : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: hotspots.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                if(selectHotspots.contains(hotspots[index])) {
                  selectHotspots.remove(hotspots[index]);
                  ref.watch(selectHotspotsProvider.notifier).state = [...selectHotspots];
                } else {  
                  ref.watch(selectHotspotsProvider.notifier).state = [...selectHotspots, hotspots[index]];
                }
              },
              child: Container(
                padding: EdgeInsets.all(.02.sh),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: FlexiColor.grey[400]!))
                ),
                child: Row(
                  children: [
                    selectHotspots.contains(hotspots[index]) ? 
                      Icon(Icons.check_circle_rounded, size: .025.sh, color: FlexiColor.primary) :
                      Icon(Icons.check_circle_outline_rounded, size: .025.sh, color: FlexiColor.grey[600]),
                    SizedBox(width: .025.sw),
                    Icon(Icons.wifi_rounded, size: .025.sh, color: FlexiColor.primary),
                    SizedBox(width: .025.sw),
                    Text(hotspots[index], style: Theme.of(context).textTheme.bodyMedium)
                  ]
                )
              )
            ),
          );
        }
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error during scan WiFi', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: FlexiColor.grey[600]))
      ), 
      loading: () => const SizedBox.shrink()
    );
  }

  Widget bluetoothListView() {
    var selectBluetooths = ref.watch(selectBluetoothsProvider);
    var bluetooths = ref.watch(accessibleDeviceBluetoothsProvider);
    return bluetooths.isEmpty ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: .03.sh,
          height: .03.sh,
          child: CircularProgressIndicator(
            color: FlexiColor.grey[600],
            strokeWidth: 2.5
          )
        ),
        SizedBox(height: .01.sh),
        Text('Scanning for nearby device(s)', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: FlexiColor.grey[600]))
      ]
    ) : ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: bluetooths.length,
      itemBuilder: (context, index) => bluetooths[index].advertisement.name!.contains(_searchText) ? GestureDetector(
        onTap: () {
          if(selectBluetooths.contains(bluetooths[index])) {
            selectBluetooths.remove(bluetooths[index]);
            ref.watch(selectBluetoothsProvider.notifier).state = [...selectBluetooths];
          } else {  
            ref.watch(selectBluetoothsProvider.notifier).state = [...selectBluetooths, bluetooths[index]];
          }
        },
        child: Container(
          padding: EdgeInsets.all(.02.sh),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: FlexiColor.grey[400]!))
          ),
          child: Row(
            children: [
              selectBluetooths.contains(bluetooths[index]) ? 
                Icon(Icons.check_circle_rounded, size: .025.sh, color: FlexiColor.primary) :
                Icon(Icons.check_circle_outline_rounded, size: .025.sh, color: FlexiColor.grey[600]),
              SizedBox(width: .025.sw),
              Icon(Icons.bluetooth_rounded, size: .025.sh, color: FlexiColor.primary),
              SizedBox(width: .025.sw),
              Text(bluetooths[index].advertisement.name!, style: Theme.of(context).textTheme.bodyMedium)
            ]
          )
        )
      ) : const SizedBox.shrink()
    );
  }

}