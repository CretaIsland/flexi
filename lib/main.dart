import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'router.dart';



late TextScaler textScaler;


void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await initialize();
  runApp(const ProviderScope(child: FlexiApp()));
}

Future<void> initialize() async {
  // auto login
  // await Future.delayed(const Duration(seconds: 3));
  // FlutterNativeSplash.remove();
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