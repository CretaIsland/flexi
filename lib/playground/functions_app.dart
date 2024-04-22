import 'package:flutter/material.dart';

class FunctionsApp extends StatefulWidget {
  const FunctionsApp({super.key});

  @override
  State<FunctionsApp> createState() => _FunctionsAppState();
}

class _FunctionsAppState extends State<FunctionsApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Functions'),
      ),
    );
  }
}
