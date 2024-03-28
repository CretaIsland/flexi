import 'package:flexi/screen/utils/flexi_font.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../utils/flexi_color.dart';
import 'content/content_list_page.dart';
import 'device/device_list_page.dart';
import 'setting/setting_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _currentPageIndex = 0;
  List<Widget> pageList = [const DeviceListPage(), const ContentListPage(), const SettingPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            flexiPageManager.switchPage(index == 0 ? "/device/list" : index == 1 ? "/content/list" : "/setting");
            _currentPageIndex = index;
          });
        },
        iconSize: screenHeight * .038,
        selectedItemColor: FlexiColor.primary,
        unselectedItemColor: FlexiColor.grey[500],
        selectedLabelStyle: FlexiFont.bottomBarButton.copyWith(color: FlexiColor.primary),
        unselectedLabelStyle: FlexiFont.bottomBarButton,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.connected_tv_outlined), label: "Devices"),
          BottomNavigationBarItem(icon: Icon(Icons.interests), label: "Contents"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting")
        ],
      )
    );
  }
  
}