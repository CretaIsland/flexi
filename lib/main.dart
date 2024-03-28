import 'package:flexi/screen/page/login_page.dart';
import 'package:flexi/screen/utils/flexi_page_manager.dart';
import 'package:flutter/material.dart';


// global variable
late double screenWidth;
late double screenHeight;

// page provider
FlexiPageManager flexiPageManager = FlexiPageManager();


void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const FlexiApp());
}


class FlexiApp extends StatelessWidget {
  const FlexiApp({super.key});

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;


    return const MaterialApp(
      title: "Flexi",
      home: Scaffold(body: LoginPage()),
    );
  }

}