import 'package:flexi/main.dart';
import 'package:flexi/screen/page/content/content_detail_page.dart';
import 'package:flexi/screen/utils/flexi_page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ContentListPage extends StatefulWidget {
  const ContentListPage({super.key});

  @override
  State<ContentListPage> createState() => _ContentListPageState();
}

class _ContentListPageState extends State<ContentListPage> {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: flexiPageManager,
      child: Consumer<FlexiPageManager>(
        builder: (context, flexiPageHandler, child) {
          if(flexiPageHandler.currentPageName == "/content/detail") {
            return const ContentDetailPage(); 
          } else {
            return Container(
              color: Colors.yellow,
            );
          }
        },
      ),
    );
  }

}