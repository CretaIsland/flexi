import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../component/search_bar.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';



class DeviceTimezoneSetScreen extends ConsumerStatefulWidget {
  const DeviceTimezoneSetScreen({super.key});

  @override
  ConsumerState<DeviceTimezoneSetScreen> createState() => _DeviceTimezoneSetScreenState();
}

class _DeviceTimezoneSetScreenState extends ConsumerState<DeviceTimezoneSetScreen> {

  final selectedIndexProvider = StateProvider<int>((ref) => -1);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.screenColor,
      padding: EdgeInsets.only(top: screenHeight * .03, left: screenWidth * .055, right: screenWidth * .055),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => context.go("/device/list"),
                icon: Icon(Icons.arrow_back_ios_new_rounded, color: FlexiColor.primary),
                iconSize: screenHeight * .015,
              ),
              Text("Set Device Timezone", style: FlexiFont.semiBold20,),
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
            height: screenHeight * .72,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenHeight * .015)
            ),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: 30,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => ref.watch(selectedIndexProvider.notifier).state = index,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * .045, screenHeight * .02, screenWidth * .045, screenHeight * .02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Africa / Abidjan (GMT +00:00)", style: ref.watch(selectedIndexProvider) == index ? FlexiFont.regular16.copyWith(color: FlexiColor.primary) : FlexiFont.regular16),
                      ref.watch(selectedIndexProvider) == index ? Icon(Icons.check_rounded, color: FlexiColor.primary, size: screenHeight * .025) : const SizedBox.shrink()
                    ],
                  ),
                ),
              ), 
              separatorBuilder: (context, index) => Divider(color: FlexiColor.grey)
            )
          )
        ],
      ),
    );
  }

}