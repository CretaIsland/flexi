import 'package:flexi/component/bottom_navigation_bar.dart';
import 'package:flexi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountInfoScreen extends ConsumerStatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  ConsumerState<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends ConsumerState<AccountInfoScreen> {
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
          child: Text("Account Info Screen"),
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }
}