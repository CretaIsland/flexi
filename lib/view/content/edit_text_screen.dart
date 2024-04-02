import 'package:flexi/common/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class EditTextScreen extends ConsumerStatefulWidget {
  const EditTextScreen({super.key});

  @override
  ConsumerState<EditTextScreen> createState() => _EditTextScreenState();
}

class _EditTextScreenState extends ConsumerState<EditTextScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: FlexiColor.screenColor,
        child: const Center(
          child: Text("Edit Text Screen"),
        ),
      ),
    );
  }

}