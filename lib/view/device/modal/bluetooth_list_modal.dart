import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/providers/socket_client_controller.dart';
import '../../../feature/device/controller/device_info_controller.dart';
import '../../../util/design/colors.dart';
import '../../../util/design/fonts.dart';



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
        borderRadius: BorderRadius.only(topLeft: Radius.circular(.025.sh), topRight:  Radius.circular(.025.sh))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: .89.sw,
            height: .06.sh,
            padding: EdgeInsets.only(left: .04.sw, right: .04.sw),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.01.sh)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Device's Bluetooth", style: FlexiFont.regular14,),
                AdvancedSwitch(
                  width: .11.sw,
                  height: .025.sh,
                  activeColor: FlexiColor.primary,
                  initialValue: device.bluetoothBonded,
                  enabled: false,
                )
              ],
            ),
          ),
          SizedBox(height: .025.sh),
          Text("Connected Device", style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
          Container(
            width: .89.sw,
            height: .06.sh,
            padding: EdgeInsets.only(left: .045.sw, right: .045.sw),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.01.sh),
            ),
            child: Visibility(
              visible: device.bluetoothBonded,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    device.bluetooth, 
                    style: FlexiFont.regular16.copyWith(color: FlexiColor.primary)
                  ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> data = {
                        "command": "bluetoothUnregister",
                        "deviceId": device.deviceId
                      };
                      var connect = await ref.watch(socketClientControllerProvider.notifier).connect(device.ip);
                      if(connect) {
                        ref.watch(socketClientControllerProvider.notifier).sendData(data);
                        ref.watch(deviceInfoControllerProvider.notifier).unregisterBluetooth();
                      }
                    },
                    child: Icon(Icons.cancel, size: .03.sh, color: FlexiColor.grey[600]),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: .025.sh),
          bluetoothDeviceList(ref)
        ],
      )
    );
  }

  Widget bluetoothDeviceList(WidgetRef ref) {
    var device = ref.watch(deviceInfoControllerProvider);
    return ref.watch(bluetoothStateProvider).when(
      data: (bluetoothState) {
        if(bluetoothState) {
          if(Platform.isIOS) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Available Devices", style: FlexiFont.regular14),
                SizedBox(height: .01.sh),
                Container(
                  width: .89.sw,
                  height: .55.sh,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(.01.sh)
                  ),
                  child: ref.watch(accessibleBluetoothsProvider).when(
                    data: (stream) {
                      return StreamBuilder(
                        stream: stream, 
                        builder: (context, snapshot) {
                          var bluetoothDevices = snapshot.data ?? List.empty();
                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: bluetoothDevices.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () async {
                                Map<String, dynamic> data = {
                                  "command": "bluetoothRegister",
                                  "deviceId": device.deviceId,
                                  "bluetooth": bluetoothDevices[index]['name']!,
                                  "bluetoothId": bluetoothDevices[index]['remoteId']!
                                };
                                var connect = await ref.watch(socketClientControllerProvider.notifier).connect(device.ip);
                                if(connect) {
                                  ref.watch(socketClientControllerProvider.notifier).sendData(data);
                                  ref.watch(deviceInfoControllerProvider.notifier).registerBluetooth(data['bluetooth'], data['bluetoothId']);
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: .015.sh, left: .045.sw, bottom: .015.sh),
                                child: Text(bluetoothDevices[index]['name']!, style: FlexiFont.regular16),
                              ),
                            ),
                            separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400])
                          );
                        }
                      );
                    }, 
                    error: (error, stackTrace) => Center(child: Text('error during scan bluetooth', style: FlexiFont.regular14)), 
                    loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary)),
                  ),
                )
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Saved Devices", style: FlexiFont.regular14),
                SizedBox(height: .01.sh),
                Container(
                  width: .89.sw,
                  height: .25.sh,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(.01.sh)
                  ),
                  child: ref.watch(bondedBluetoothsProvider).when(
                    data: (bluetoothDevices) => ListView.separated(
                      itemCount: bluetoothDevices.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () async {
                          Map<String, dynamic> data = {
                            "command": "bluetoothRegister",
                            "deviceId": device.deviceId,
                            "bluetooth": bluetoothDevices[index]['name']!,
                            "bluetoothId": bluetoothDevices[index]['remoteId']!
                          };
                          var connect = await ref.watch(socketClientControllerProvider.notifier).connect(device.ip);
                          if(connect) {
                            ref.watch(socketClientControllerProvider.notifier).sendData(data);
                            ref.watch(deviceInfoControllerProvider.notifier).registerBluetooth(data['bluetooth'], data['bluetoothId']);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: .015.sh, left: .045.sw, bottom: .015.sh),
                          child: Text(bluetoothDevices[index]['name']!, style: FlexiFont.regular16),
                        ),
                      ),
                      separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400])
                    ), 
                    error: (error, stackTrace) => Center(child: Text('error during scan bluetooth', style: FlexiFont.regular14)), 
                    loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary)),
                  )
                ),
                SizedBox(height: .02.sh),
                Text("Available Devices", style: FlexiFont.regular14),
                SizedBox(height: .01.sh),
                Container(
                  width: .89.sw,
                  height: .25.sh,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(.01.sh)
                  ),
                  child: ref.watch(accessibleBluetoothsProvider).when(
                    data: (stream) => StreamBuilder(
                      stream: stream, 
                      builder: (context, snapshot) {
                        final bluetoothDevices = snapshot.data ?? List.empty();
                        return ListView.separated(
                          itemCount: bluetoothDevices.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () async {
                              Map<String, dynamic> data = {
                                "command": "bluetoothRegister",
                                "deviceId": device.deviceId,
                                "bluetooth": bluetoothDevices[index]['name']!,
                                "bluetoothId": bluetoothDevices[index]['remoteId']!                  
                              };
                              var connect = await ref.watch(socketClientControllerProvider.notifier).connect(device.ip);
                              if(connect) {
                                ref.watch(socketClientControllerProvider.notifier).sendData(data);
                                ref.watch(deviceInfoControllerProvider.notifier).registerBluetooth(data['bluetooth'], data['bluetoothId']);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: .015.sh, left: .045.sw, bottom: .015.sh),
                              child: Text(bluetoothDevices[index]['name']!, style: FlexiFont.regular16),
                            ),
                          ),
                          separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400])
                        );
                      }
                    ),
                    error: (error, stackTrace) => Center(child: Text('error during scan bluetooth', style: FlexiFont.regular14)), 
                    loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary)),
                  ),
                )
              ],
            );
          }
        } else {
          return Center(
            child: Text(
              'please turn your bluetooth', 
              style: FlexiFont.regular14
            )
          );
        }
      }, 
      error: (error, stackTrace) => Center(child: Text('error during scan bluetooth', style: FlexiFont.regular14)), 
      loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary)),
    );
  }

}