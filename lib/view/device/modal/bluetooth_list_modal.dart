import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/providers/socket_client_controller.dart';
import '../../../feature/device/controller/device_info_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class BluetoothModal extends ConsumerWidget {
  const BluetoothModal({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 1.sw,
      height: .9.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(.025.sh), topRight:  Radius.circular(.025.sh))
      ),
      child: FutureBuilder(
        future: ref.watch(socketClientControllerProvider.notifier).connect(ref.watch(deviceInfoControllerProvider)!.ip),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null && snapshot.data!) {
            return Column(
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
                        initialValue: ref.watch(deviceInfoControllerProvider)!.bluetoothBonded,
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
                  padding: EdgeInsets.only(left: .045.sw),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(.01.sh),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ref.watch(deviceInfoControllerProvider)!.bluetooth == 'null' ? 
                        '' : ref.watch(deviceInfoControllerProvider)!.bluetooth, 
                      style: FlexiFont.regular16.copyWith(color: FlexiColor.primary)
                    )
                  ),
                ),
                SizedBox(height: .025.sh),
                bluetoothDeviceList()
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      )
    );
  }

  Consumer bluetoothDeviceList() {
    return Consumer(
      builder: (context, ref, child) {
        return ref.watch(bluetoothStateProvider).when(
          data: (data) {
            if(data) {
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
                              final devices = snapshot.data ?? List.empty();
                              return ListView.separated(
                                itemCount: devices.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Map<String, String> data = {
                                      "command": "bluetoothRegister",
                                      "deviceId": ref.watch(deviceInfoControllerProvider)!.deviceId,
                                      "bluetooth": devices[index]['name']!,
                                      "bluetoothId": devices[index]['remoteId']!
                                    };
                                    ref.watch(socketClientControllerProvider.notifier).sendData(data);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(top: .015.sh, left: .045.sw, bottom: .015.sh),
                                    child: Text(devices[index]['name']!, style: FlexiFont.regular16),
                                  ),
                                ),
                                separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400]),
                              );
                            },
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
                        data: (devices) => ListView.separated(
                          itemCount: devices.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Map<String, String> data = {
                                "command": "bluetoothRegister",
                                "deviceId": ref.watch(deviceInfoControllerProvider)!.deviceId,
                                "bluetooth": devices[index]['name']!,
                                "bluetoothId": devices[index]['remoteId']!
                              };
                              ref.watch(socketClientControllerProvider.notifier).sendData(data);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: .015.sh, left: .045.sw, bottom: .015.sh),
                              child: Text(devices[index]['name']!, style: FlexiFont.regular16),
                            ),
                          ), 
                          separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400]),
                        ), 
                        error: (error, stackTrace) => Center(child: Text('error during scan bluetooth', style: FlexiFont.regular14)), 
                        loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary)),
                      ),
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
                        data: (stream) {
                          return StreamBuilder(
                            stream: stream, 
                            builder: (context, snapshot) {
                              final devices = snapshot.data ?? List.empty();
                              return ListView.separated(
                                itemCount: devices.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Map<String, String> data = {
                                      "command": "bluetoothRegister",
                                      "deviceId": ref.watch(deviceInfoControllerProvider)!.deviceId,
                                      "bluetooth": devices[index]['name']!,
                                      "bluetoothId": devices[index]['remoteId']!
                                    };
                                    ref.watch(socketClientControllerProvider.notifier).sendData(data);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(top: .015.sh, left: .045.sw, bottom: .015.sh),
                                    child: Text(devices[index]['name']!, style: FlexiFont.regular16),
                                  ),
                                ),
                                separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400]),
                              );
                            },
                          );
                        }, 
                        error: (error, stackTrace) => Center(child: Text('error during scan bluetooth', style: FlexiFont.regular14)), 
                        loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary)),
                      ),
                    )
                  ],
                );
              }
            }
            return Center(
              child: Text(
                'please turn your bluetooth', 
                style: FlexiFont.regular14
              )
            ); 
          }, 
          error: (error, stackTrace) => Center(child: Text('error during scan bluetooth', style: FlexiFont.regular14)), 
          loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary)),
        );
      },
    );
  }

}