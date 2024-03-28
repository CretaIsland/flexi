import 'package:flexi/screen/page/device/device_detail_page.dart';
import 'package:flexi/screen/page/device/set_timezone_page.dart';
import 'package:flexi/screen/page/device/set_wifi_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../utils/flexi_page_manager.dart';

class DeviceListPage extends StatefulWidget {
  const DeviceListPage({super.key});

  @override
  State<DeviceListPage> createState() => _DeviceListPageState();
}

class _DeviceListPageState extends State<DeviceListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: flexiPageManager,
      child: Consumer<FlexiPageManager>(
        builder: (context, flexiPageHandler, child) {
          switch(flexiPageHandler.currentPageName) {
            case "/device/info" : 
              return const DeviceDetailPage();
            case "/device/setting/timezone" : 
              return const SetTimezonePage();
            case "/device/setting/wifi" :
              return const SetWifiPage();
            default:
              return Container(
                color: Colors.green,
              );
          } 
        },
      ),
    );
  }
}