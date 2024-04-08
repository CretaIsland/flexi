import 'package:flexi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendContentScreen extends ConsumerStatefulWidget {
  const SendContentScreen({super.key});

  @override
  ConsumerState<SendContentScreen> createState() => _SendContentScreenState();
}

class _SendContentScreenState extends ConsumerState<SendContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: FlexiColor.screenColor,
        child: const Center(
          child: Text("Send Content Screen"),
        ),
      ),
    );
  }
}