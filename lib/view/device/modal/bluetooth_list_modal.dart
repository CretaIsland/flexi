import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

import '../../../core/controller/socket_client_controller.dart';
import '../../../feature/device/controller/device_info_controller.dart';
import '../../../util/design/colors.dart';



class BluetoothListModal extends ConsumerWidget {
  const BluetoothListModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var device = ref.watch(deviceInfoControllerProvider);
    return Container(
      width: 1.sw,
      height: .9.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(.025.sh), topRight: Radius.circular(.025.sh))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: .89.sw,
            height: .06.sh,
            padding: EdgeInsets.only(left: .04.sw, right: .05.sw),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.01.sh)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Device's Bluetooth", style: Theme.of(context).textTheme.bodySmall),
                AdvancedSwitch(
                  width: .11.sw,
                  height: .025.sh,
                  activeColor: FlexiColor.primary,
                  initialValue: device.bluetoothBonded,
                  enabled: false
                )
              ]
            )
          ),
          SizedBox(height: .025.sh),
          Text('Connected Device', style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: .01.sh),
          Container(
            width: .89.sw,
            height: .06.sh,
            padding: EdgeInsets.only(left: .04.sw, right: .05.sw),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.01.sh)
            ),
            child: Visibility(
              visible: device.bluetoothBonded,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(device.bluetooth, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.primary)),
                  GestureDetector(
                    onTap: () async {
                      var connected = await ref.watch(socketClientControllerProvider.notifier).connect(device.ip);
                      if(connected) {
                        ref.watch(socketClientControllerProvider.notifier).sendData({
                          "command": "bluetoothUnregister",
                          "deviceId": device.deviceId
                        });
                        ref.watch(deviceInfoControllerProvider.notifier).unregisterBluetooth();
                      }
                    },
                    child: Icon(Icons.cancel_rounded, size: .03.sh, color: FlexiColor.grey[600]),
                  )
                ],
              )
            )
          ),
          SizedBox(height: .025.sh),
          if(Platform.isAndroid) 
            ...[
              Text('Saved Device', style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: .01.sh),
              bondedDeviceList(context, ref),
              SizedBox(height: .025.sh)
            ],
          Text('Available Device', style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: .01.sh),
          accessibleDeviceList(ref)
        ]
      ),
    );
  }

  Widget bondedDeviceList(BuildContext context, WidgetRef ref) {
    return Container(
      width: .89.sw,
      height: .25.sh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(.01.sh)
      ),
      child: ref.watch(bondedBluetoothsProvider).when(
        data: (data) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: data.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () async {
                if(await ref.watch(socketClientControllerProvider.notifier).connect(ref.watch(deviceInfoControllerProvider).ip)) {
                  ref.watch(socketClientControllerProvider.notifier).sendData({
                    "command": "bluetoothRegister",
                    "deviceId": ref.watch(deviceInfoControllerProvider).deviceId,
                    "bluetooth": data[index]['name'],
                    "bluetoothId": data[index]['remoteId']
                  });
                  ref.watch(deviceInfoControllerProvider.notifier).registerBluetooth(data[index]['name']!, data[index]['remoteId']!);
                }
              },
              child: Padding(
                padding: EdgeInsets.only(left: .045.sw, top: .015.sh, bottom: .015.sh),
                child: Text(data[index]['name']!, style: Theme.of(context).textTheme.bodyMedium),
              ),
            ), 
            separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400])
          );
        }, 
        error: (error, stackTrace) => Center(
          child: Text('Error during scan bonded device', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: FlexiColor.grey[600])),
        ), 
        loading: () => SizedBox(
          width: .04.sh,
          height: .04.sh,
          child: CircularProgressIndicator(color: FlexiColor.grey[600], strokeWidth: 2.5),
        )
      )
    );
  }

  Widget accessibleDeviceList(WidgetRef ref) {
    return Container(
      width: .89.sw,
      height: Platform.isAndroid ? .25.sh : .55.sh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(.01.sh)
      ),
      child: ref.watch(accessibleBluetoothsProvider).when(
        data: (stream) {
          return StreamBuilder(
            stream: stream, 
            builder: (context, snapshot) {
              var devices = snapshot.data ?? List.empty();
              return ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: devices.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () async {
                    var connected = await ref.watch(socketClientControllerProvider.notifier).connect(ref.watch(deviceInfoControllerProvider).ip);
                    if(connected) {
                      ref.watch(socketClientControllerProvider.notifier).sendData({
                        "command": "bluetoothRegister",
                        "deviceId": ref.watch(deviceInfoControllerProvider).deviceId,
                        "bluetooth": devices[index]['name'],
                        "bluetoothId": devices[index]['remoteId']
                      });
                      ref.watch(deviceInfoControllerProvider.notifier).registerBluetooth(devices[index]['name']!, devices[index]['remoteId']!);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: .045.sw, top: .015.sh, bottom: .015.sh),
                    child: Text(devices[index]['name']!, style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
                separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400],)
              );
            }
          );
        }, 
        error: (error, stackTrace) => null,
        loading: () => SizedBox(
          width: .03.sh,
          height: .03.sh,
          child: CircularProgressIndicator(color: FlexiColor.grey[600], strokeWidth: 2.0)
        )
      )
    );
  }
}