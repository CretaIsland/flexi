import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../feature/setting/controller/app_setting_controller.dart';
import '../feature/setting/controller/user_controller.dart';



class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  final UserController _userController = UserController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.watch(appSettingControllerProvider.notifier).getAppConfig();
      await _userController.initialize();
      var user = await _userController.autoLogin();
      if(user != null) {
        ref.watch(loginUser.notifier).state = user;
        context.go('/device/list');
      } else {
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox()
    );
  }

}