
import 'package:flexi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingMenuScreen extends ConsumerStatefulWidget {
  const SettingMenuScreen({super.key});

  @override
  ConsumerState<SettingMenuScreen> createState() => _SettingMenuScreenState();
}

class _SettingMenuScreenState extends ConsumerState<SettingMenuScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.screenColor,
      child: const Center(
        child: Text("Setting Menu Screen"),
      ),
    );
  }
}