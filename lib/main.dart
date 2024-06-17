import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'feature/auth/service/auth_service.dart';
import 'router.dart';



late TextScaler textScaler;
bool isLogin = false;


void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initialize();
  runApp(const ProviderScope(child: FlexiApp()));
}

Future<void> initialize() async {
  AuthService authService = AuthService();
  await authService.initialize();
  var result = await authService.autoLogin();
  print(result);
  if(result) isLogin = true;
  FlutterNativeSplash.remove();
}


class FlexiApp extends StatelessWidget {
  const FlexiApp({super.key});

  @override
  Widget build(BuildContext context) {
    textScaler = MediaQuery.of(context).textScaler;

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