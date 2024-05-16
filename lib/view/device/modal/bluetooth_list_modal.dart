import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../feature/device/controller/bluetooth_controller.dart';
import '../../../feature/device/provider/bluetooth_provider.dart';
import '../../../main.dart';
import '../../../utils/ui/colors.dart';
import '../../../utils/ui/fonts.dart';



class BluetoothListModal extends ConsumerWidget {
  const BluetoothListModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bluetoothState = ref.watch(bluetoothControllerProvider);
    final bluetoothController = ref.watch(bluetoothControllerProvider.notifier);

    return Container(
      width: screenWidth,
      height: screenHeight * .9,
      padding: EdgeInsets.only(left: screenWidth * .055, right: screenWidth * .055),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(screenHeight * .025), topRight:  Radius.circular(screenHeight * .025))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * .04),
          Container(
            width: screenWidth * .89,
            height: screenHeight * .06,
            padding: EdgeInsets.only(left: screenWidth * .04, right: screenWidth * .04),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenHeight * .01)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Device's Bluetooth", style: FlexiFont.regular14,),
                AdvancedSwitch(
                  width: screenWidth * .11,
                  height: screenHeight * .025,
                  enabled: Platform.isAndroid,
                  activeColor: FlexiColor.primary,
                  initialValue: bluetoothState,
                  onChanged: (value) {
                    if(value) {
                      bluetoothController.turnOn();
                    } else {
                      bluetoothController.turnOff();
                    }
                  },
                )
              ],
            ),
          ),
          SizedBox(height: screenHeight * .025),
          Text("Connected Device", style: FlexiFont.regular14),
          SizedBox(height: screenHeight * .01),
          Container(
            width: screenWidth * .89,
            height: screenHeight * .06,
            padding: EdgeInsets.only(left: screenWidth * .045),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenHeight * .01),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Device name", style: FlexiFont.regular16.copyWith(color: FlexiColor.primary))),
          ),
          SizedBox(height: screenHeight * .025),
          deviceListView(bluetoothState)
        ],
      ),
    );
  }

  Widget deviceListView(bool bluetoothState) {
    if(Platform.isAndroid) {
      return Consumer(
        builder: (context, ref, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Saved Devices", style: FlexiFont.regular14),
              SizedBox(height: screenHeight * .01),
              Container(
                width: screenWidth * .89,
                height: screenHeight * .25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenHeight * .01)
                ),
                child: bluetoothState ? ref.watch(bondedBluetoothsProvider).when(
                  data: (data) {
                    print(data);
                    return ListView.separated(
                      itemCount: data.length,
                      itemBuilder:(context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(top: screenHeight * .015, left: screenWidth * .045, bottom: screenHeight * .015),
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
              SizedBox(height: screenHeight * .02),
              Text("Available Devices", style: FlexiFont.regular14),
              SizedBox(height: screenHeight * .01),
              Container(
                width: screenWidth * .89,
                height: screenHeight * .25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenHeight * .01)
                ),
                child: bluetoothState ? ref.watch(bluetoothStreamProvider).when(
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
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.only(top: screenHeight * .015, left: screenWidth * .045, bottom: screenHeight * .015),
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
        },
      );
    } else {
      return Consumer(
        builder:(context, ref, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Available Devices", style: FlexiFont.regular14),
              SizedBox(height: screenHeight * .01),
              Container(
                width: screenWidth * .89,
                height: screenHeight * .55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenHeight * .01)
                ),
                child: bluetoothState ? ref.watch(bluetoothStreamProvider).when(
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
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.only(top: screenHeight * .015, left: screenWidth * .045, bottom: screenHeight * .015),
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
        },
      );
    }
   
  }

}