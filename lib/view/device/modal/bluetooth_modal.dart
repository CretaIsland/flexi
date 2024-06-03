import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../feature/device/controller/bluetooth_controller.dart';
import '../../../feature/device/model/bluetooth_info.dart';
import '../../../feature/device/provider/bluetooth_provider.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';



class BluetoothListModal extends ConsumerWidget {
  BluetoothListModal({super.key});
  final connectedBluetoothInfoProvider = StateProvider<BluetoothInfo>((ref) => const BluetoothInfo());


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bluetoothState = ref.watch(bluetoothControllerProvider);
    final bluetoothStateController = ref.watch(bluetoothControllerProvider.notifier);
    // Device Detail 화면에 들어올 때 받은 디바이스 정보에 있는 BluetoothInfo로 초기화할 것
    final connectedBluetoothInfo = ref.watch(connectedBluetoothInfoProvider);

    return Container(
      width: 1.sw,
      height: .9.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .05.sh, right: .055.sw),
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
            padding: EdgeInsets.only(left: .04.sw, right: .04.sw),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.01.sh)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Device\'s Bluetooth', style: FlexiFont.regular14),
                Consumer(
                  builder: (context, ref, child) { 
                    return AdvancedSwitch(
                      width: .1.sw,
                      height: .025.sh,
                      enabled: Platform.isAndroid,
                      activeColor: FlexiColor.primary,
                      initialValue: bluetoothState,
                      onChanged: (value) {
                        if(value) {
                          bluetoothStateController.turnOn();
                        } else {
                          // 블루투스 해제 메세지 전송
                          bluetoothStateController.turnOff();
                        }
                      },
                    ); 
                  }
                )
              ],
            )
          ),
          SizedBox(height: .02.sh),
          Text('Connected Device', style: FlexiFont.regular14),
          SizedBox(height: .01.sh),
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
                Text(
                  connectedBluetoothInfo.name ?? "abc",
                  style: FlexiFont.regular16.copyWith(color: FlexiColor.primary),
                ),
                // 플레이어에 블루투스 정보를 보내고, 플레이어가 잘 받고 연결도 잘 하면 그 때 CircularProgress 없애기 
                // SizedBox(
                //   width: screenHeight * .02,
                //   height: screenHeight * .02,
                //   child: CircularProgressIndicator(color: FlexiColor.primary, strokeWidth: 2),
                // )
              ]
            )
          ),
          SizedBox(height: .02.sh),
          Consumer(
            builder: (context, ref, child) {
              if(bluetoothState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...(Platform.isAndroid ? bondedDeviceListView() : []),
                    ...availableDeviceListView()
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }

  List<Widget> bondedDeviceListView() {
    return [
      Text('Saved Devices', style: FlexiFont.regular14),
      SizedBox(height: .01.sh),
      Consumer(
        builder: (context, ref, child) { 
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
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ref.watch(connectedBluetoothInfoProvider.notifier).state = data[index];
                        // socket으로 블루투스 연결 정보 전송
                      },
                      child: Padding(
                        padding: EdgeInsets.all(.02.sh),
                        child: Text(data[index].name ?? '', style: FlexiFont.regular16),
                      ),
                    );
                  }, 
                  separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400]),
                );
              }, 
              error: (error, stackTrace) => Center(child: Text('error during get saved device.', style: FlexiFont.regular14)), 
              loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary))
            )
          );
        }
      )
    ];
  }

  List<Widget> availableDeviceListView() {
    return [
      SizedBox(height: .02.sh),
      Text('Available Devices', style: FlexiFont.regular14),
      SizedBox(height: .01.sh),
      Consumer(
        builder: (context, ref, child) { 
          return Container(
            width: .89.sw,
            height: Platform.isAndroid ? .25.sh : .5.sh,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.01.sh)
            ),
            child: ref.watch(bluetoothStreamProvider).when(
              data: (streamData) {
                return StreamBuilder(
                  stream: streamData, 
                  builder: (context, snapshot) {
                    if(snapshot.hasData && snapshot.data != null) {
                      return ListView.separated(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              ref.watch(connectedBluetoothInfoProvider.notifier).state = snapshot.data![index];
                              // socket으로 블루투스 연결 정보 전송
                            },
                            child: Padding(
                              padding: EdgeInsets.all(.02.sh),
                              child: Text(snapshot.data![index].name ?? '', style: FlexiFont.regular16),
                            ),
                          );
                        }, 
                        separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400]),
                      );
                    }
                    return Center(child: CircularProgressIndicator(color: FlexiColor.primary));
                  },
                );
              }, 
              error: (error, stackTrace) => Center(child: Text('error during get available device.', style: FlexiFont.regular14)), 
              loading: () => Center(child: CircularProgressIndicator(color: FlexiColor.primary))
            ),
          ); 
        }
      )
    ];
  }

}