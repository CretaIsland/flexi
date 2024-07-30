import 'package:flutter/material.dart';

import '../../../util/ui/colors.dart';
import '../component/bottom_navigation_bar.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlexiColor.backgroundColor,
      body: child,
      bottomNavigationBar: const FlexiBottomNavigationBar(),
    );
  }
}