import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'feature/auth/controller/auth_service.dart';
import 'router.dart';



void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initialize();
  runApp(const ProviderScope(child: FlexiApp()));
}

Future<void> initialize() async {
  AuthController authController = AuthController();
  await authController.initialize();
  await authController.autoLogin();
  FlutterNativeSplash.remove();
}


class FlexiApp extends StatelessWidget {
  const FlexiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }

}