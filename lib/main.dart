import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'router.dart';
import 'util/design/fonts.dart';



void main()  {
  runApp(const ProviderScope(child: FlexiApp()));
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
          theme: ThemeData(
            textTheme: Platform.isAndroid ? FlexiFont.android : FlexiFont.ios
          )
        );
      }
    );
  }
}