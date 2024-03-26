import 'package:flutter/material.dart';

class ContentListPage extends StatefulWidget {
  const ContentListPage({super.key});

  @override
  State<ContentListPage> createState() => _ContentListPageState();
}

class _ContentListPageState extends State<ContentListPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("content list page"),
    );
  }
}