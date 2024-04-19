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
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.screenColor,
      child: const Center(
        child: Text("Device Recovery Screen"),
      ),
    );
  }
}