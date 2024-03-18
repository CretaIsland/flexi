import 'package:flexi/screens/page/content/content_list_page.dart';
import 'package:flexi/screens/page/device/device_list_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height - 60,
            child: _tabIndex == 0 ? const DeviceListPage() : const ContentListPage(),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 60,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    width: 168,
                    height: 44,
                    decoration: BoxDecoration(
                      color: _tabIndex == 0 ? Colors.black87 : Colors.transparent,
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.connected_tv_outlined, color: Colors.white, size: 24),
                        SizedBox(width: 8),
                        Text("Devices", style: TextStyle(color: Colors.white, fontSize: 16))
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _tabIndex = 0;
                    });
                  },
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  child: Container(
                    width: 168,
                    height: 44,
                    decoration: BoxDecoration(
                      color: _tabIndex == 1 ? Colors.black87 : Colors.transparent,
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.interests_outlined, color: Colors.white, size: 24),
                        SizedBox(width: 8),
                        Text("Contents", style: TextStyle(color: Colors.white, fontSize: 16))
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _tabIndex = 1;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}