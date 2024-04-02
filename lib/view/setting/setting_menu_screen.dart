import 'package:flexi/common/component/bottom_navigation_bar.dart';
import 'package:flexi/common/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingMenuScreen extends ConsumerStatefulWidget {
  const SettingMenuScreen({super.key});

  @override
  ConsumerState<SettingMenuScreen> createState() => _SettingMenuScreenState();
}

class _SettingMenuScreenState extends ConsumerState<SettingMenuScreen> {
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
          child: Text("Setting Menu Screen"),
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }
}