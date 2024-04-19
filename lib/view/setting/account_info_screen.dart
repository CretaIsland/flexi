
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
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.screenColor,
      child: const Center(
        child: Text("Account Info Screen"),
      ),
    );
  }
}