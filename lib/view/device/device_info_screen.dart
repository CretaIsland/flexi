import 'package:flexi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DeviceInfoScreen extends ConsumerStatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  ConsumerState<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}


class _DeviceInfoScreenState extends ConsumerState<DeviceInfoScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.screenColor,
      child: const Center(
        child: Text("Device Info Screen"),
      ),
    );
  }

}