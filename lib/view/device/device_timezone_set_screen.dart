import 'package:flexi/common/component/bottom_navigation_bar.dart';
import 'package:flexi/common/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceTimezoneSetScreen extends ConsumerStatefulWidget {
  const DeviceTimezoneSetScreen({super.key});

  @override
  ConsumerState<DeviceTimezoneSetScreen> createState() => _DeviceTimezoneSetScreenState();
}

class _DeviceTimezoneSetScreenState extends ConsumerState<DeviceTimezoneSetScreen> {

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
          child: Text("Device Timezone Set Screen"),
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }
}