import 'package:flexi/screens/page/content/content_detail_page.dart';
import 'package:flexi/screens/page/content/edit_background_page.dart';
import 'package:flexi/screens/page/content/edit_text_page.dart';
import 'package:flexi/screens/page/content/send_content_page.dart';
import 'package:flexi/screens/page/device/device_detail_page.dart';
import 'package:flexi/screens/page/device/set_timezone_page.dart';
import 'package:flexi/screens/page/device/set_wifi_page.dart';
import 'package:flexi/screens/page/home_page.dart';
import 'package:flexi/screens/page/login_page.dart';
import 'package:flexi/screens/page/setting/account_detail_page.dart';
import 'package:flexi/screens/page/setting/app_update_page.dart';
import 'package:flexi/screens/page/setting/device_recovery_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';



late double screenWidth;
late double screenHeight;

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const FlexiApp());
}

class FlexiApp extends StatelessWidget {
  const FlexiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flexi',
      routes: {
        "/login" : (context) => const LoginPage(),
        "/home" : (context) => const HomePage(),
        "/deviceDetail" : (context) => const DeviceDetailPage(),
        "/device/setTimezone" : (context) => const SetTimezonePage(),
        "/device/setWifi" : (context) => const SetWifiPage(),
        "/contentDetail" : (context) => const ContentDetailPage(),
        "/content/text" : (context) => const EditTextPage(),
        "/content/background" : (context) => const EditBackgroundPage(),
        "/content/send" : (context) => const SendContentPage(),
        "/setting/account" :(context) => const AccountDetailPage(),
        "/setting/device/recovery" :(context) => const DeviceRecoveryPage(),
        "/setting/app/version" :(context) => const AppUpdatePage()
      },
      home: const FlexiHomePage(),
    );
  }
}

class FlexiHomePage extends StatefulWidget {
  const FlexiHomePage({super.key});
  @override
  State<FlexiHomePage> createState() => _FlexiHomePageState();
}

class _FlexiHomePageState extends State<FlexiHomePage> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;

    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginPage()
    );
  }
  
}