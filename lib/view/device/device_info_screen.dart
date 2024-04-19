import 'package:flexi/utils/colors.dart';
import 'package:flutter/material.dart';
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
          ],
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }

}