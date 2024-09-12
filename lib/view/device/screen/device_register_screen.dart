import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../component/search_bar.dart';
import '../../../feature/device/controller/device_register_controller.dart';
import '../../../util/design/colors.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => ref.invalidate(selectDeviceBluetoothsProvider));
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(registerDataControllerProvider);
    var devices = ref.watch(accessibleDeviceBluetoothsProvider);
    var selectDevices = ref.watch(selectDeviceBluetoothsProvider);
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
                  icon: Icon(Icons.arrow_back_ios, size: .03.sh, color: FlexiColor.primary)
                ),
                Text('Select Device', style: Theme.of(context).textTheme.displaySmall),
                TextButton(
                  onPressed: () {
                    if(selectDevices.isNotEmpty) {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: widget.rootContext,
                        builder: (context) => const DeviceSetupModal()
                      );
                    }
                  }, 
                  child: Text('OK', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: selectDevices.isEmpty ? FlexiColor.grey[700] : FlexiColor.primary))
                )
              ]
            ),
            SizedBox(height: .03.sh),
            FlexiSearchBar(
              hintText: 'Search your device', 
              onChanged: (value) => setState(() => _searchText = value)
            ),
            SizedBox(height: .02.sh),
            Container(
              width: .89.sw,
              height: .675.sh,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(.015.sh)
              ),
              child: devices.isEmpty ? Column(
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
                  SizedBox(height: .015.sh),
                  Text('Scanning for nearby device', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: FlexiColor.grey[600]))
                ]
              ) : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: devices.length,
                itemBuilder: (context, index) => devices[index].advertisement.name!.toLowerCase().contains(_searchText.toLowerCase()) ? GestureDetector(
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
                        SizedBox(width: .025.sw),
                        Icon(Icons.bluetooth, size: .025.sh, color: FlexiColor.primary),
                        SizedBox(width: .025.sw),
                        Text(devices[index].advertisement.name!, style: Theme.of(context).textTheme.bodyMedium),
                      ]
                    )
                  )
                ) : const SizedBox.shrink()
              )
            )
          ]
        )
      )
    );
  }
}