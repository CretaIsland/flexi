import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../component/search_bar.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';


final selectTimezoneProvider = StateProvider<int>((ref) => -1);

class DeviceTimezoneSetScreen extends ConsumerStatefulWidget {
  const DeviceTimezoneSetScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<DeviceTimezoneSetScreen> createState() => _DeviceTimezoneSetScreenState();
}


class _DeviceTimezoneSetScreenState extends ConsumerState<DeviceTimezoneSetScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.screenColor,
      padding: EdgeInsets.only(top: screenHeight * .04, left: screenWidth * .055, right: screenWidth * .055),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => context.go("/device/list"), 
                icon: Icon(Icons.arrow_back_ios, size: screenHeight * .02, color: FlexiColor.primary)
              ),
              Text("Set Device Timezone", style: FlexiFont.semiBold20),
              TextButton(
                onPressed: () => context.go("/device/setWifi"), 
                child: Text("OK", style: FlexiFont.regular16.copyWith(color: FlexiColor.primary))
              )
            ],
          ),
          SizedBox(height: screenHeight * .03),
          FlexiSearchBar(hintText: "Search timezone", searchTextController: TextEditingController()),
          SizedBox(height: screenHeight * .02),
          Container(
            width: screenWidth * .89,
            height: screenHeight * .7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenHeight * .015),
              color: Colors.white
            ),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder:(context, index) {
                return GestureDetector(
                  onTap: () => ref.watch(selectTimezoneProvider.notifier).state = index,
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight * .02, left: 16, bottom: screenHeight * .02, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Africa", style: ref.watch(selectTimezoneProvider) == index ? FlexiFont.regular16.copyWith(color: FlexiColor.primary) : FlexiFont.regular16),
                        ref.watch(selectTimezoneProvider) == index ? Icon(Icons.check, size: screenHeight * .02, color: FlexiColor.primary) : const SizedBox.shrink()
                      ],
                    ),
                  ),
                );
              }, 
              separatorBuilder:(context, index) {
                return Divider(color: FlexiColor.grey[400]);
              }),
          )
        ],
      ),
    );
  }

}