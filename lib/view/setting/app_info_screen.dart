
import 'package:flexi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppInfoScreen extends ConsumerStatefulWidget {
  const AppInfoScreen({super.key});

  @override
  ConsumerState<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends ConsumerState<AppInfoScreen> {
  
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: FlexiColor.screenColor,
      child: const Center(
        child: Text("App Info Screen"),
      ),
    );
  }
}