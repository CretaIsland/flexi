import 'package:flexi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../component/bottom_navigation_bar.dart';
import '../../main.dart';
import '../../utils/fonts.dart';


class DeviceInfoScreen extends ConsumerStatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  ConsumerState<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

final volumeProvider = StateProvider<double>((ref) => 0);


class _DeviceInfoScreenState extends ConsumerState<DeviceInfoScreen> {


    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: FlexiColor.screenColor,
        padding: EdgeInsets.only(top: screenHeight * .04, left: screenWidth * .055, right: screenWidth * .055),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.go("/device/list"),
                  icon: Icon(Icons.arrow_back_ios, size: screenHeight * .02, color: FlexiColor.primary)
                ),
                Text("Device Detail", style: FlexiFont.semiBold20),
                TextButton(
                  onPressed: () => context.go("/device/list"), 
                  child: Text("OK", style: FlexiFont.regular16.copyWith(color: FlexiColor.primary))
                )
              ],
            ),
            SizedBox(height: screenHeight * .03),
            Text("Content", style: FlexiFont.regular14),
            SizedBox(height: screenHeight * .01),
            Container(
              width: screenWidth * .89,
              height: screenHeight * .0675,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenHeight * .01)
              ),
              child: Center(
                child: Container(
                  width: screenWidth * .82,
                  height: screenHeight * .0375,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(screenHeight * .005)
                  ),
                )
              ),
            ),
            SizedBox(height: screenHeight * .015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Network", style: FlexiFont.regular14,),
                    SizedBox(height: screenHeight * .01),
                    Container(
                      width: screenWidth * .43,
                      height: screenHeight * .125,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(screenHeight * .01)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.wifi_rounded, size: screenHeight * .045, color: FlexiColor.primary),
                          Text("SSID", style: FlexiFont.semiBold14.copyWith(color: FlexiColor.primary))
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bluetooth", style: FlexiFont.regular14,),
                    SizedBox(height: screenHeight * .01),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: screenWidth * .43,
                        height: screenHeight * .125,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(screenHeight * .01)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.bluetooth_rounded, size: screenHeight * .045, color: FlexiColor.primary),
                            Text("device name", style: FlexiFont.semiBold14.copyWith(color: FlexiColor.primary))
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: screenHeight * .015),
            Text("Device Name", style: FlexiFont.regular14),
            SizedBox(height: screenHeight * .015),
            deviceInfoTextField(),
            SizedBox(height: screenHeight * .015),
            Text("Device Volume", style: FlexiFont.regular14),
            SizedBox(height: screenHeight * .015),
            Container(
              width: screenWidth * .89,
              height: screenHeight * .06,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenHeight * .01)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => ref.watch(volumeProvider.notifier).state = 0,
                    icon: Icon(Icons.volume_mute_rounded, color: FlexiColor.primary),
                    iconSize: screenHeight * .03,
                  ),
                  SizedBox(
                    width: screenWidth * .6,
                    height: screenHeight * .005,
                    child: Slider(
                      value: ref.watch(volumeProvider), 
                      min: 0,
                      max: 100,
                      thumbColor: FlexiColor.primary,
                      activeColor: FlexiColor.primary,
                      onChanged: (value) {
                        ref.watch(volumeProvider.notifier).state = value;
                      }
                    ),
                  ),
                  IconButton(
                    onPressed: () => ref.watch(volumeProvider.notifier).state = 100, 
                    icon: Icon(Icons.volume_up_rounded, color: FlexiColor.primary),
                    iconSize: screenHeight * .03,
                  )
                ],
              ),
            ),
            SizedBox(height: screenHeight * .015),
            Text("Devie Timezone", style: FlexiFont.regular14),
            SizedBox(height: screenHeight * .015),
            deviceInfoTextField(),
            SizedBox(height: screenHeight * .015),
            Text("Network", style: FlexiFont.regular14),
            SizedBox(height: screenHeight * .015),
            deviceInfoTextField()
          ],
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }

  Widget deviceInfoTextField() {
    return SizedBox(
      width: screenWidth * .89,
      height: screenHeight * .06,
      child: TextField(
        controller: TextEditingController(),
        style: FlexiFont.regular16,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight * .01),
            borderSide: BorderSide(color: FlexiColor.grey[400]!)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight * .01),
            borderSide: BorderSide(color: FlexiColor.grey[400]!)
          ),
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true
        ),
      ),
    );
  }

}