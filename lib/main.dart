import 'package:flexi/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


late double screenWidth;
late double screenHeight;
late TextScaler textScale;

void main() {
  runApp(const ProviderScope(child: FlexiApp()));
}

class FlexiApp extends ConsumerStatefulWidget {
  const FlexiApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FlexiAppState();
}

class _FlexiAppState extends ConsumerState<FlexiApp> {

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
    textScale = MediaQuery.of(context).textScaler;

    return MaterialApp.router(
      routerConfig: router,
    );
  }

}