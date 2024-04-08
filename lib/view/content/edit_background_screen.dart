import 'package:flexi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditBackgroundScreen extends ConsumerStatefulWidget {
  const EditBackgroundScreen({super.key});

  @override
  ConsumerState<EditBackgroundScreen> createState() => _EditBackgroundScreenState();
}

class _EditBackgroundScreenState extends ConsumerState<EditBackgroundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: FlexiColor.screenColor,
        child: const Center(
          child: Text("Edit Background Screen"),
        ),
      ),
    );
  }
}