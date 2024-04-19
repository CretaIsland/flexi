import 'package:flexi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceWifiSetScreen extends ConsumerStatefulWidget {
  const DeviceWifiSetScreen({super.key});

  @override
  ConsumerState<DeviceWifiSetScreen> createState() => _DeviceWifiSetScreenState();
}

class _DeviceWifiSetScreenState extends ConsumerState<DeviceWifiSetScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.screenColor,
      child: const Center(
        child: Text("Device Wifi Set Screen"),
      ),
    );
  }
}