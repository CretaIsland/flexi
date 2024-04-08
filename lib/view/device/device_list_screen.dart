import 'package:flexi/component/bottom_navigation_bar.dart';
import 'package:flexi/component/circle_icon_button.dart';
import 'package:flexi/component/search_bar.dart';
import 'package:flexi/utils/colors.dart';
import 'package:flexi/utils/fonts.dart';
import 'package:flexi/main.dart';
import 'package:flexi/view/modal/device_reset_modal.dart';
import 'package:flexi/view/modal/hotspot_list_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


final selectModeProvider = StateProvider<bool>((ref) => false);

class DeviceListScreen extends ConsumerStatefulWidget {
  const DeviceListScreen({super.key});

  @override
  ConsumerState<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends ConsumerState<DeviceListScreen> {


  bool isSelectMode = false;
  bool selectAll = false;


  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(tabIndexProvider.notifier).state = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => ref.watch(selectModeProvider.notifier).state = false,
        child: Container(
          color: FlexiColor.screenColor,
          padding: EdgeInsets.only(top: screenHeight * .065, left: screenWidth * .055, right: screenWidth * .055),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Devices", style: FlexiFont.semiBold30),
                  ref.watch(selectModeProvider) ? 
                    CircleIconButton(
                      size: screenHeight * .04, 
                      icon: Icon(Icons.link_off, color: Colors.white, size: screenHeight * .03),
                      fillColor: FlexiColor.secondary,
                      onPressed: () => showModalBottomSheet(
                        context: context, 
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => DeviceResetModal()
                      ),
                    ) 
                    : CircleIconButton(
                      size: screenHeight * .04, 
                      icon: Icon(Icons.add_rounded, color: Colors.white, size: screenHeight * .03),
                      fillColor: FlexiColor.primary,
                      onPressed: () => showModalBottomSheet(
                        context: context, 
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const HotSpotListModal()
                      ),
                    )
                ],
              ),
              SizedBox(height: screenHeight * .0175),
              FlexiSearchBar(hintText: "Search your devices", searchTextController: TextEditingController()),
              SizedBox(height: screenHeight * .03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("15 Devices", style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                      IconButton(
                        onPressed: () {}, 
                        icon: Icon(Icons.refresh_rounded, color: FlexiColor.grey[600]),
                        iconSize: screenHeight * .02,
                      )
                    ],
                  ),
                  ref.watch(selectModeProvider) ? Row(
                    children: [
                      Text("Select all", style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                      const SizedBox(width: 8),
                      CircleIconButton(
                        size: screenHeight * .02, 
                        icon: Icon(Icons.check, color: selectAll ? Colors.white : FlexiColor.grey[600], size: screenHeight * .01),
                        fillColor: selectAll ? FlexiColor.secondary : null,
                        border: selectAll ? null : Border.all(color: FlexiColor.grey[600]!),
                        onPressed: () {
                          setState(() {
                            selectAll = !selectAll;
                          });
                        },
                      )
                    ],
                  ) : const SizedBox.shrink(),
                ],
              ),
              SizedBox(height: screenHeight * .01),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return DeviceComponentWidget(key: UniqueKey());
                  },
                ),
              )
            ],
          )
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }
}


class DeviceComponentWidget extends ConsumerWidget {

  const DeviceComponentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onLongPress: () => ref.watch(selectModeProvider.notifier).state = true,
      onTap: () => ref.watch(selectModeProvider) ? null : context.go("/device/info"),
      child: Container(
        width: screenWidth * .89,
        height: screenHeight * .1,
        margin: EdgeInsets.only(bottom: screenHeight * .02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenHeight * .01)
        ),
        padding: EdgeInsets.only(left: screenWidth * .045 , right: screenWidth * .039, top: screenHeight * .02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.wifi_off, color: FlexiColor.secondary, size: screenHeight * .02),
            SizedBox(width: screenWidth * .033),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Device name", style: FlexiFont.regular16),
                SizedBox(height: screenHeight * .01),
                Row(
                  children: [
                    Text("Device ID", style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                    Container(
                      margin: EdgeInsets.only(left: screenWidth * .05),
                      width: screenWidth * .25,
                      height: screenHeight * .0225,
                      decoration: BoxDecoration(
                        color: FlexiColor.secondary,
                        borderRadius: BorderRadius.circular(screenHeight * .005)
                      ),
                      child: Text("Unregistered", style: FlexiFont.regular12.copyWith(color: Colors.white), textAlign: TextAlign.center),
                    )
                  ],
                )
              ],
            ),
            ref.watch(selectModeProvider) ? Padding(
              padding: EdgeInsets.only(left: screenWidth * .22, top: screenHeight * .02),
              child: CircleIconButton(
                size: screenHeight * .02, 
                icon: Icon(Icons.check, color: FlexiColor.grey[600], size: screenHeight * .01),
                fillColor: null,
                border: Border.all(color: FlexiColor.grey[600]!),
                onPressed: () { }
              ),
            ) : const SizedBox.shrink()
          ],
        )
      ),
    );
  }

}
