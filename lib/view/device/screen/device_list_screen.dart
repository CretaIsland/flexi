import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:open_settings_plus/open_settings_plus.dart';

import '../../../component/search_bar.dart';
import '../../../feature/device/controller/device_info_controller.dart';
import '../../../feature/device/controller/device_list_controller.dart';
import '../../../feature/device/controller/device_register_controller.dart';
import '../../../feature/setting/controller/setting_controller.dart';
import '../../../util/design/colors.dart';
import '../modal/device_reset_modal.dart';



class DeviceListScreen extends ConsumerStatefulWidget {
  const DeviceListScreen({super.key, required this.rootContext});
  final BuildContext rootContext;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends ConsumerState<DeviceListScreen> {

  String _searchText = '';
  bool _selectMode = false;
  bool _selectAll = false;

  @override
  Widget build(BuildContext context) {
    var devices = ref.watch(connectedDeviceControllerProvider);
    var selectDevices = ref.watch(selectDevicesProvider);
    return GestureDetector(
      onTap: () {
        if(_selectMode) {
          setState(() {
            _selectMode = false;
            _selectAll = false;
          });
        }
      },
      child: Container(
        color: FlexiColor.backgroundColor,
        padding: EdgeInsets.only(left: .055.sw, top: .065.sh, right: .055.sw),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Device', style: Theme.of(context).textTheme.displayLarge),
                GestureDetector(
                  onTap: () async {
                    if(_selectMode) {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: widget.rootContext, 
                        builder: (context) => const DeviceResetModal()
                      );
                    } else {
                      deviceRegister();
                    }
                  },
                  child: Container(
                    width: .04.sh,
                    height: .04.sh,
                    decoration: BoxDecoration(
                      color: _selectMode ? FlexiColor.secondary : FlexiColor.primary,
                      borderRadius: BorderRadius.circular(.02.sh)
                    ),
                    child: Icon(_selectMode ? Icons.link_off_rounded : Icons.add_rounded, size: .03.sh, color: Colors.white)
                  )
                )
              ],
            ),
            SizedBox(height: .02.sh),
            FlexiSearchBar(
              hintText: 'Search your device', 
              onChanged: (value) => setState(() => _searchText = value)
            ),
            SizedBox(height: .025.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('${devices.length} devices', style: Theme.of(context).textTheme.labelSmall!.copyWith(color: FlexiColor.grey[600])),
                    SizedBox(width: .01.sw),
                    GestureDetector(
                      onTap: () => ref.watch(connectedDeviceControllerProvider.notifier).refresh(),
                      child: Icon(Icons.refresh_rounded, size: .02.sh, color: FlexiColor.grey[600])
                    )
                  ]
                ),
                Visibility(
                  visible: _selectMode,
                  child: Row(
                    children: [
                      Text('Select All', style: Theme.of(context).textTheme.labelSmall!.copyWith(color: FlexiColor.grey[600])),
                      SizedBox(width: .01.sw),
                      GestureDetector(
                        onTap: () {
                          setState(() => _selectAll = !_selectAll);
                          if(_selectAll) {
                            ref.watch(selectDevicesProvider.notifier).state = ref.read(connectedDeviceControllerProvider);
                          } else {
                            ref.watch(selectDevicesProvider.notifier).state = List.empty();
                          }
                        },
                        child: _selectAll ? Icon(Icons.check_circle_rounded, size: .025.sh, color: FlexiColor.secondary)
                          : Icon(Icons.check_circle_outline_rounded, size: .025.sh, color: FlexiColor.grey[600])
                      )
                    ]
                  )
                )
              ]
            ),
            SizedBox(height: .015.sh),
            Expanded(
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
                  SizedBox(height: .01.sh),
                  Text('Scanning for nearby device(s)', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: FlexiColor.grey[600]))
                ]
              ) : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: devices.length,
                itemBuilder:(context, index) => devices[index].deviceName.contains(_searchText) ? GestureDetector(
                  onTap: () {
                    if(_selectMode) {
                      if(selectDevices.contains(devices[index])) {
                        selectDevices.remove(devices[index]);
                        ref.watch(selectDevicesProvider.notifier).state = [...selectDevices];
                      } else {
                        ref.watch(selectDevicesProvider.notifier).state = [...selectDevices, devices[index]];
                      }
                    } else {
                      ref.watch(deviceInfoControllerProvider.notifier).setDevice(devices[index]);
                      context.go('/device/info');
                    }
                  },
                  onLongPress: () {
                    if(!_selectMode) setState(() =>_selectMode = true);
                  },
                  child: Container(
                    width: .89.sw,
                    height: .1.sh,
                    padding: EdgeInsets.only(left: .055.sw, right: .055.sw),
                    margin: EdgeInsets.only(bottom: .01.sh),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(.01.sh)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.link_rounded, size: .045.sw, color: FlexiColor.primary),
                                SizedBox(width: .015.sw),
                                Text(devices[index].deviceName, style: Theme.of(context).textTheme.bodyMedium)
                              ]
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: .06.sw),
                              child: Text(devices[index].deviceId, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: FlexiColor.grey[600]))
                            )
                          ]
                        ),
                        Visibility(
                          visible: _selectMode,
                          child: selectDevices.contains(devices[index]) ?
                            Icon(Icons.check_circle_rounded, size: .025.sh, color: FlexiColor.secondary) :
                            Icon(Icons.check_circle_outline_rounded, size: .025.sh, color: FlexiColor.grey[600])
                        )
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

  void deviceRegister() {
    if(ref.watch(settingControllerProvider)['registerType'] == 'Hotspot') {
      if(Platform.isIOS) {
        ref.watch(networkControllerProvider.notifier).wifiConnected().then((value) {
          if(value) {
            if(context.mounted) context.go('/device/setTimezone');
          } else {
            if(context.mounted) {
              showDialog(
                context: widget.rootContext, 
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(.025.sh)),
                  title: Text('Please check the WiFi connection.', style: Theme.of(context).textTheme.displaySmall),
                  titlePadding: EdgeInsets.all(.05.sw),
                  content: Text('To register the device, you must be connected to the hotspot of that device.', style: Theme.of(context).textTheme.bodyMedium),
                  contentPadding: EdgeInsets.all(.05.sw),
                  actions: [
                    TextButton(
                      onPressed: () => const OpenSettingsPlusIOS().wifi(),
                      child: Text('OK', style: Theme.of(context).textTheme.labelMedium)
                    )
                  ],
                  actionsPadding: EdgeInsets.all(.05.sw),
                )
              );
            }
          }
        });
      } else {
        context.go('/device/setTimezone');
      }
    } else {
      context.go('/device/setTimezone');
    }
  }
}