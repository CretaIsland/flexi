import 'package:flexi/component/bottom_navigation_bar.dart';
import 'package:flexi/component/search_bar.dart';
import 'package:flexi/utils/colors.dart';
import 'package:flexi/utils/fonts.dart';
import 'package:flexi/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceTimezoneSetScreen extends ConsumerStatefulWidget {
  const DeviceTimezoneSetScreen({super.key});

  @override
  ConsumerState<DeviceTimezoneSetScreen> createState() => _DeviceTimezoneSetScreenState();
}

class _DeviceTimezoneSetScreenState extends ConsumerState<DeviceTimezoneSetScreen> {

  int _currenetIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(tabIndexProvider.notifier).state = 0);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: FlexiColor.screenColor,
        padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .04, right: screenWidth * .055,),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {}, 
                  icon: Icon(Icons.arrow_back_ios, color: FlexiColor.primary, size: screenHeight * .02)
                ),
                Text("Set Device Timezone", style: FlexiFont.semiBold20),
                TextButton(
                  onPressed: () {},
                  child: Text("OK", style: FlexiFont.regular16.copyWith(color: FlexiColor.primary)),
                )
              ],
            ),
            SizedBox(height: screenHeight * .03),
            FlexiSearchBar(hintText: "Search timezone", searchTextController: TextEditingController()),
            SizedBox(height: screenHeight * .02),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: screenWidth * .89,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenHeight * .015)
                  ),
                  child: ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currenetIndex = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(screenHeight* .02),
                        child: timezoneComponent(index),
                      ),
                    );
                  }, 
                  separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[500]), 
                  itemCount: 20
                ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }

  Widget timezoneComponent(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Africa / Abidjan (GMT +00:00)", style: FlexiFont.regular16),
        _currenetIndex == index ? Icon(Icons.check, color: FlexiColor.primary, size: screenHeight * .025) : const SizedBox.shrink()
      ],
    );
  }

}