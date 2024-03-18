import 'package:flutter/material.dart';




class ContentDetailPage extends StatefulWidget {
  const ContentDetailPage({super.key});

  @override
  State<ContentDetailPage> createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends State<ContentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.navigate_before_outlined, color: Colors.black, size: 24),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const Text("Content Detail", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700))
            ],
          ),
          
        ],
      )
    );
  }
}