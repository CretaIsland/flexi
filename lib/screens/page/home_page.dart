import 'package:flexi/screens/page/content/content_list_page.dart';
import 'package:flexi/screens/page/device/device_list_page.dart';
import 'package:flexi/screens/page/setting/setting_page.dart';
import 'package:flexi/screens/utils/flexi_color.dart';
import 'package:flexi/screens/utils/flexi_font.dart';
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

    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;


    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width,
            height: height * .925,
            child: _tabIndex == 0 ? const DeviceListPage() :  _tabIndex == 1 ? const ContentListPage() : const SettingPage(),
          ),
          Container(
            height: height * .075,
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * .1),
                  child: tabButton(width: width * .15, height: height * .055, btnIcon: Icons.connected_tv_outlined, btnLabel: "Devices", index: 0),
                ),
                tabButton(width: width * .2, height: height * .055, btnIcon: Icons.interests, btnLabel: "Contents", index: 1),
                Padding(
                  padding: EdgeInsets.only(right : width * .1),
                  child:  tabButton(width: width * .15, height: height * .055, btnIcon: Icons.settings, btnLabel: "Setting", index: 2),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget tabButton({required double width, required double height, required IconData btnIcon, required String btnLabel, required int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _tabIndex = index;
        });
      },
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            Icon(btnIcon, color: _tabIndex == index ? FlexiColor.primary : Colors.grey.shade300, size: height * .6),
            Text(btnLabel, style: TextStyle(
              fontFamily: FlexiFont.fontFamily, 
              fontWeight: FlexiFont.medium, 
              fontSize: height * .3, 
              color: _tabIndex == index ? FlexiColor.primary : Colors.grey.shade300
            ))
          ],
        ),
      ),
    );
  }

}