import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../components/bottom_navigation_bar.dart';
import '../../components/text_field.dart';
import '../../main.dart';
import '../../utils/ui/colors.dart';
import '../../utils/ui/fonts.dart';
import '../content/component/content_preview.dart';
import 'modal/bluetooth_list_modal.dart';



class DeviceDetailScreen extends ConsumerStatefulWidget {
  const DeviceDetailScreen({super.key});

  @override
  ConsumerState<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends ConsumerState<DeviceDetailScreen> {

  late TextEditingController _deviceNameController;
  late TextEditingController _timezoneController;
  late TextEditingController _networkController;
  final deviceVolumeProvider = StateProvider<double>((ref) => 50);


  @override
  void initState() {
    super.initState();
    _deviceNameController = TextEditingController();
    _timezoneController = TextEditingController();
    _networkController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _deviceNameController.dispose();
    _timezoneController.dispose();
    _networkController.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight,
        color: FlexiColor.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * .04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => context.go("/device/list"),
                    icon: Icon(Icons.arrow_back_ios_new, color: FlexiColor.primary),
                    iconSize: screenHeight * .025,
                  ),
                  Text("Device Detail", style: FlexiFont.semiBold20),
                  TextButton(
                    onPressed: () { context.go("/device/list"); },
                    child: Text("OK", style: FlexiFont.regular16.copyWith(color: FlexiColor.primary)),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .03, right: screenWidth * .055, bottom: screenHeight * .03,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Content", style: FlexiFont.regular14),
                    Container(
                      width: screenWidth * .89,
                      padding: EdgeInsets.all(screenHeight * .02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(screenHeight * .01)
                      ),
                      child: Center(
                        child: ContentPreview(width: screenWidth * .82),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Network", style: FlexiFont.regular14),
                            const SizedBox(height: 8),
                            InkWell(
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
                                    Icon(Icons.wifi_rounded, color: FlexiColor.primary, size: screenHeight * .045),
                                    Text("Connected", style: FlexiFont.semiBold14.copyWith(color: FlexiColor.primary))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Bluetooth", style: FlexiFont.regular14),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => const BluetoothListModal(),
                              ),
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
                                    Icon(Icons.bluetooth_rounded, color: FlexiColor.primary, size: screenHeight * .045),
                                    Text("speaker 123", style: FlexiFont.semiBold14.copyWith(color: FlexiColor.primary))
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text("Device Name", style: FlexiFont.regular14),
                    const SizedBox(height: 8),
                    FlexiTextField(width: screenWidth * .89, height: screenHeight * .06),
                    const SizedBox(height: 12),
                    Text("Device Volume", style: FlexiFont.regular14),
                    const SizedBox(height: 8),
                    Container(
                      width: screenWidth * .89,
                      height: screenHeight * .06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: FlexiColor.grey[400]!),
                        borderRadius: BorderRadius.circular(screenHeight * .01)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () => ref.watch(deviceVolumeProvider.notifier).state = 0,
                            icon: Icon(Icons.volume_mute_rounded, color: FlexiColor.primary),
                            iconSize: screenHeight * .03,
                          ),
                          SizedBox(
                            width: screenWidth * .6,
                            height: screenHeight * .005,
                            child: Slider(
                              value: ref.watch(deviceVolumeProvider), 
                              min: 0,
                              max: 100,
                              thumbColor: Colors.white,
                              activeColor: FlexiColor.primary,
                              onChanged: (value) {
                                ref.watch(deviceVolumeProvider.notifier).state = value;
                              }
                            ),
                          ),
                          IconButton(
                            onPressed: () => ref.watch(deviceVolumeProvider.notifier).state = 100, 
                            icon: Icon(Icons.volume_up_rounded, color: FlexiColor.primary),
                            iconSize: screenHeight * .03,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text("Device Timezone", style: FlexiFont.regular14),
                    const SizedBox(height: 8),
                    FlexiTextField(width: screenWidth * .89, height: screenHeight * .06),
                    const SizedBox(height: 12),
                    Text("Network", style: FlexiFont.regular14),
                    const SizedBox(height: 8),
                    FlexiTextField(width: screenWidth * .89, height: screenHeight * .06)
                  ],
                ),
              ) 
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }

}