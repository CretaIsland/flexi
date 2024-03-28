import 'package:flutter/material.dart';



class SetTimezonePage extends StatefulWidget {
  const SetTimezonePage({super.key});

  @override
  State<SetTimezonePage> createState() => _SetTimezonePageState();
}

class _SetTimezonePageState extends State<SetTimezonePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Set Timezone Page")
    );
  }
}