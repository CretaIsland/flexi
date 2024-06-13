import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/config.dart';
import '../../../common/providers/network_providers.dart';
import '../../../feature/device/controller/device_info_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class BluetoothModal extends ConsumerWidget {
  const BluetoothModal({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bluetoothState = ref.watch(bluetoothStateControllerProvider);
    final bluetoothController = ref.watch(bluetoothStateControllerProvider.notifier);

    final deviceInfo = ref.watch(deviceInfoControllerProvider);
    final deviceInfoController = ref.watch(deviceInfoControllerProvider.notifier);
    final socketClient = ref.watch(SocketIOClientProvider(ip: deviceInfo.ip, port: Config.socketIOPort).notifier);


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
                  initialValue: deviceInfo.bluetoothBonded,
                  onChanged: (value) {
                    if(value) {
                      bluetoothController.turnOn();
                    } else {
                      bluetoothController.turnOff();
                      deviceInfoController.unregisterBluetooth();
                      String data = '''
                        {
                        "command": "bluetoothUnregister",
                        "deviceId": "${deviceInfo.deviceId}"
                        }
                      ''';
                      socketClient.sendData(data);
                    }
                  },
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
              child: Text(deviceInfo.bluetooth, style: FlexiFont.regular16.copyWith(color: FlexiColor.primary))),
          ),
          SizedBox(height: .025.sh),
          Consumer(
            builder: (context, ref, child) {
              if(Platform.isAndroid) {
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
                      child: bluetoothState ? ref.watch(bondedBluetoothsProvider).when(
                        data: (data) {
                          return ListView.separated(
                            itemCount: data.length,
                            itemBuilder:(context, index) {
                              return InkWell(
                                onTap: () {
                                  ref.watch(deviceInfoControllerProvider.notifier).registerBluetooth(data[index]);
                                  String sendData = '''
                                  {
                                    "command": "bluetoothRegister",
                                    "deviceId": "${deviceInfo.deviceId}",
                                    "bluetooth": "${data[index].name}",
                                    "bluetoothId": "${data[index].remoteId}"
                                  }
                                  ''';
                                  socketClient.sendData(sendData);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: .015.sh, left:  .045.sw, bottom:  .015.sh),
                                  child: Text(data[index].name ?? "", style: FlexiFont.regular16),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400]), 
                          );
                        }, 
                        error: (error, stackTrace) => Center(child: Text("error during get stored device(s).", style: FlexiFont.regular14)), 
                        loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary))
                      ) : const SizedBox.shrink()
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
                      child: bluetoothState ? ref.watch(accessibleBluetoothsProvider).when(
                        data: (stream) {
                          return StreamBuilder(
                            stream: stream, 
                            builder: (context, snapshot) {
                              if(snapshot.hasData) {  
                                final data = snapshot.data ?? [];
                                return ListView.separated(
                                  itemCount: data.length,
                                  itemBuilder:(context, index) {
                                    return InkWell(
                                      onTap: () {
                                        ref.watch(deviceInfoControllerProvider.notifier).registerBluetooth(data[index]);
                                        String sendData = '''
                                          {
                                          "command": "bluetoothRegister",
                                          "deviceId": "${deviceInfo.deviceId}",
                                          "bluetooth": "${data[index].name}",
                                          "bluetoothId": "${data[index].remoteId}"
                                          }
                                        ''';
                                        socketClient.sendData(sendData);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(top: .015.sh, left: .045.sw, bottom: .015.sh),
                                        child: Text(data[index].name ?? "", style: FlexiFont.regular16),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400])
                                );
                              } else if(snapshot.hasError) {
                                return Center(child: Text("error during get bluetooth device(s).", style: FlexiFont.regular14));
                              } else {
                                return Center(child: CircularProgressIndicator(color: FlexiColor.primary));
                              }
                            },
                          );
                        }, 
                        error: (error, stackTrace) => Center(child: Text("error during get bluetooth device(s).", style: FlexiFont.regular14)), 
                        loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary))
                      ) : const SizedBox.shrink()
                    )
                  ],
                );
              } else {
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
                      child: bluetoothState ? ref.watch(accessibleBluetoothsProvider).when(
                        data: (stream) {
                          return StreamBuilder(
                            stream: stream, 
                            builder: (context, snapshot) {
                              if(snapshot.hasData) {  
                                final data = snapshot.data ?? [];
                                return ListView.separated(
                                  itemCount: data.length,
                                  itemBuilder:(context, index) {
                                    return InkWell(
                                      onTap: () {
                                        ref.watch(deviceInfoControllerProvider.notifier).registerBluetooth(data[index]);
                                        String sendData = '''
                                          {
                                          "command": "bluetoothRegister",
                                          "deviceId": "${deviceInfo.deviceId}",
                                          "bluetooth": "${data[index].name}",
                                          "bluetoothId": "${data[index].remoteId}"
                                          }
                                        ''';
                                        socketClient.sendData(sendData);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(top: .015.sh, left: .045.sw, bottom: .015.sh),
                                        child: Text(data[index].name ?? "", style: FlexiFont.regular16),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400])
                                );
                              } else if(snapshot.hasError) {
                                return Center(child: Text("error during get bluetooth device(s).", style: FlexiFont.regular14));
                              } else {
                                return Center(child: CircularProgressIndicator(color: FlexiColor.primary));
                              }
                            },
                          );
                        }, 
                        error: (error, stackTrace) => Center(child: Text("error during get bluetooth device(s).", style: FlexiFont.regular14)), 
                        loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary))
                      ) : const SizedBox.shrink()
                    )
                  ],
                );
              }
            },
          )
        ],
      ),
    );
  }

}