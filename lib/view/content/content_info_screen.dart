import 'package:flexi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentInfoScreen extends ConsumerStatefulWidget {
  const ContentInfoScreen({super.key});

  @override
  ConsumerState<ContentInfoScreen> createState() => _ContentInfoScreenState();
}

class _ContentInfoScreenState extends ConsumerState<ContentInfoScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.screenColor,
      child: const Center(
        child: Text("Content List Screen"),
      ),
    );
  }
  
}