import 'package:flexi/component/bottom_navigation_bar.dart';
import 'package:flexi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceRecoveryScreen extends ConsumerStatefulWidget {
  const DeviceRecoveryScreen({super.key});

  @override
  ConsumerState<DeviceRecoveryScreen> createState() => _DeviceRecoveryScreenState();
}

class _DeviceRecoveryScreenState extends ConsumerState<DeviceRecoveryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(tabIndexProvider.notifier).state = 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: FlexiColor.screenColor,
        child: const Center(
          child: Text("Device Recovery Screen"),
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }
}