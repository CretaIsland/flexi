import 'package:flexi/common/component/bottom_navigation_bar.dart';
import 'package:flexi/common/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentInfoScreen extends ConsumerStatefulWidget {
  const ContentInfoScreen({super.key});

  @override
  ConsumerState<ContentInfoScreen> createState() => _ContentInfoScreenState();
}

class _ContentInfoScreenState extends ConsumerState<ContentInfoScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(tabIndexProvider.notifier).state = 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: FlexiColor.screenColor,
        child: const Center(
          child: Text("Content List Screen"),
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }
}