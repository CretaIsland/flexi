import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/bottom_navigation_bar.dart';
import '../utils/ui/color.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.state, required this.child});
  final GoRouterState state;
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