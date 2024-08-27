import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/device/controller/device_info_controller.dart';
import '../../../feature/device/controller/device_list_controller.dart';
import '../../../feature/setting/controller/setting_controller.dart';
import '../../../util/design/colors.dart';
import '../../../component/search_bar.dart';
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
          ref.invalidate(selectDevicesProvider);
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
                InkWell(
                  onTap: () {
                    if(_selectMode) {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: widget.rootContext, 
                        builder: (context) => const DeviceResetModal(),
                      );
                    } else {
                      if(Platform.isIOS && ref.watch(settingControllerProvider)['registerOption'] == 'Hotspot') {

                      }
                      context.go('/device/setTimezone');
                    }
                  },
                  child: Container(
                    width: .04.sh,
                    height: .04.sh,
                    decoration: BoxDecoration(
                      color: _selectMode ? FlexiColor.secondary : FlexiColor.primary,
                      borderRadius: BorderRadius.circular(.02.sh)
                    ),
                    child: Icon(_selectMode ? Icons.link_off : Icons.add, size: .03.sh, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(height: .02.sh),
            FlexiSearchBar(
              hintText: 'Search your device',
              onChanged: (value) => setState(() {
                _searchText = value;
              })
            ),
            SizedBox(height: .025.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('${devices.length} Devices', style: Theme.of(context).textTheme.labelSmall!.copyWith(color: FlexiColor.grey[600])),
                    SizedBox(width: .02.sw),
                    InkWell(
                      onTap: () => ref.invalidate(connectedDeviceControllerProvider),
                      child: Icon(Icons.refresh, size: .02.sh, color: FlexiColor.grey[600])
                    )
                  ],
                ),
                Visibility(
                  visible: _selectMode,
                  child: Row(
                    children: [
                      Text('Select All', style: Theme.of(context).textTheme.labelSmall),
                      SizedBox(width: .02.sw),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectAll = !_selectAll;
                          });
                          if(_selectAll) {
                            ref.watch(selectDevicesProvider.notifier).state = devices;
                          } else {
                            ref.watch(selectDevicesProvider.notifier).state = [];
                          }
                        },
                        child: _selectAll ? Icon(Icons.check_circle, size: .025.sh, color: FlexiColor.secondary) :
                          Icon(Icons.check_circle_outline, size: .025.sh, color: FlexiColor.grey[600])
                      )
                    ],
                  )
                )
              ],
            ),
            SizedBox(height: .015.sh),
            Expanded(
              child: devices.isEmpty ? Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: FlexiColor.primary),
                    SizedBox(height: .01.sh),
                    Text('Scanning for nearby devices', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: FlexiColor.grey[600])),
                  ],
                )) : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  return devices[index].deviceName.contains(_searchText) ? GestureDetector(
                    onTap: () {
                      if(_selectMode) {
                        if(selectDevices.contains(devices[index])) {
                          selectDevices.remove(devices[index]);
                          ref.read(selectDevicesProvider.notifier).state = [...selectDevices];
                        } else {
                          ref.read(selectDevicesProvider.notifier).state = [...selectDevices, devices[index]];
                        }
                      } else {
                        ref.watch(deviceInfoControllerProvider.notifier).setDevice(devices[index]);
                        context.go('/device/info');
                      }
                    },
                    onLongPress: () {
                      if(!_selectMode) {
                        setState(() {
                          _selectMode = true;
                        });
                      }
                    },
                    child: Container(
                      width: .89.sw,
                      height: .1.sh,
                      padding: EdgeInsets.only(left: .04.sw, right: .04.sw),
                      margin: EdgeInsets.only(bottom: .02.sh),
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
                                  Icon(Icons.link, color: FlexiColor.primary, size: .02.sh),
                                  SizedBox(width: .015.sw),
                                  Text(devices[index].deviceName, style: Theme.of(context).textTheme.bodyMedium)
                                ]
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: .055.sw),
                                child: Text(devices[index].deviceId, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: FlexiColor.grey[600])),
                              )
                            ],
                          ),
                          Visibility(
                            visible: _selectMode,
                            child: selectDevices.contains(devices[index]) ? Icon(Icons.check_circle, size: .025.sh, color: FlexiColor.secondary)
                              : Icon(Icons.check_circle_outline, size: .025.sh, color: FlexiColor.grey[600])
                          )
                        ],
                      ),
                    ),
                  ) : const SizedBox.shrink();
                }
              ),
            )
          ],
        ),
      ),
    );
  }

}