import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../feature/setting/controller/app_setting_controller.dart';
import '../feature/setting/controller/auth_controller.dart';



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
      await ref.watch(appSettingControllerProvider.notifier).getAppConfig();
      await ref.watch(authControllerProvider.notifier).initialize();
      if(await ref.watch(authControllerProvider.notifier).autoLogin()) {
        context.go('/device/list');
      } else {
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
    );
  }

}