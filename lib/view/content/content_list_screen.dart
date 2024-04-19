import 'package:flexi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentListScreen extends ConsumerStatefulWidget {
  const ContentListScreen({super.key});

  @override
  ConsumerState<ContentListScreen> createState() => _ContentListScreenState();
}

class _ContentListScreenState extends ConsumerState<ContentListScreen> {

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