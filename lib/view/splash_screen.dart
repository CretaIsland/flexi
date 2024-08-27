import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../feature/setting/controller/setting_controller.dart';
import '../feature/setting/controller/user_controller.dart';



class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.watch(settingControllerProvider.notifier).getSetting();
      await ref.watch(userControllerProvider.notifier).initialize();
      if(await ref.watch(userControllerProvider.notifier).autoLogin()) {
        context.go('/device/list');
      } else {
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white);
  }

}