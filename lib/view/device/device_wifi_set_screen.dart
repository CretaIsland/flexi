import 'package:flexi/common/component/bottom_navigation_bar.dart';
import 'package:flexi/common/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceWifiSetScreen extends ConsumerStatefulWidget {
  const DeviceWifiSetScreen({super.key});

  @override
  ConsumerState<DeviceWifiSetScreen> createState() => _DeviceWifiSetScreenState();
}

class _DeviceWifiSetScreenState extends ConsumerState<DeviceWifiSetScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(tabIndexProvider.notifier).state = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: FlexiColor.screenColor,
        child: const Center(
          child: Text("Device Wifi Set Screen"),
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }
}