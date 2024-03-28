import 'package:flutter/material.dart';

class SendContentPage extends StatefulWidget {
  const SendContentPage({super.key});

  @override
  State<SendContentPage> createState() => _SendContentPageState();
}

class _SendContentPageState extends State<SendContentPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Send Content Page")
    );
  }
}