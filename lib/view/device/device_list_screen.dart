import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../component/bottom_navigation_bar.dart';
import '../../component/circle_icon_button.dart';
import '../../component/search_bar.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import 'modal/device_reset_modal.dart';
import 'modal/hotspot_list_modal.dart';



final selectModeProvider = StateProvider<bool>((ref) => false);
final isAllSelectProvider = StateProvider<bool>((ref) => false);


class DeviceListScreen extends ConsumerStatefulWidget {
  const DeviceListScreen({super.key});

  @override
  ConsumerState<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends ConsumerState<DeviceListScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => ref.watch(selectModeProvider.notifier).state = false,
        child: Container(
          color: FlexiColor.screenColor,
          padding: EdgeInsets.only(top: screenHeight * .065, left: screenWidth * .055, right: screenWidth * .055),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Devices', style: FlexiFont.semiBold30),
                  CircleIconButton(
                    size: screenHeight * .04, 
                    icon: Icon(ref.watch(selectModeProvider) ? Icons.link_off_rounded : Icons.add_rounded, color: Colors.white),
                    fillColor: ref.watch(selectModeProvider) ? FlexiColor.secondary : FlexiColor.primary,
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => ref.watch(selectModeProvider) ? const DeviceResetModal() : HotspotListModal(),
                    ),
                  )
                ],
              ),
              SizedBox(height: screenHeight * .01625),
              FlexiSearchBar(hintText: "Search your devices", searchTextController: TextEditingController()),
              SizedBox(height: screenHeight * .0275),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(" ${10} Devices", style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                  IconButton(
                    onPressed: () {}, 
                    icon: Icon(Icons.refresh_rounded, color: FlexiColor.grey[600], size: screenHeight * .02)
                  ),
                  SizedBox(width: screenWidth * .43),
                  ref.watch(selectModeProvider) ? Text("Select all", style: FlexiFont.regular12) : const SizedBox.shrink(),
                  ref.watch(selectModeProvider) ? SizedBox(width: screenWidth * .011) : const SizedBox.shrink(),
                  ref.watch(selectModeProvider) ? CircleIconButton(
                    size: screenHeight * .02, 
                    icon: Icon(Icons.check, color: ref.watch(isAllSelectProvider) ? Colors.white : FlexiColor.grey[600], size: screenHeight * .015),
                    border: ref.watch(isAllSelectProvider) ? null : Border.all(color: FlexiColor.grey[600]!),
                    fillColor: ref.watch(isAllSelectProvider) ? FlexiColor.secondary : null,
                    onPressed: () => ref.watch(isAllSelectProvider.notifier).state = !ref.watch(isAllSelectProvider.notifier).state,
                  ) : const SizedBox.shrink(),
                ],
              ),
              SizedBox(height: screenHeight * .0125),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return DeviceComponentWidget(index: index);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FlexiBottomNaviagtionBar(),
    );
  }

}


class DeviceComponentWidget extends ConsumerWidget {
  const DeviceComponentWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.go("/device/info"),
      onLongPress: () => ref.watch(selectModeProvider.notifier).state = true,
      child: Container(
        width: screenWidth * .89,
        height: screenHeight * .1,
        padding: EdgeInsets.only(top: screenHeight * .02, left: screenWidth * .045, right: screenWidth * .045),
        margin: EdgeInsets.only(bottom: screenHeight * .02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenHeight * .01)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.link_rounded, color: FlexiColor.primary),
                SizedBox(width: screenWidth * .033),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Device Name", style: FlexiFont.regular16),
                    Text("Device ID", style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600]))
                  ],
                ),
              ],
            ),
            ref.watch(selectModeProvider) ? Padding(
              padding: EdgeInsets.only(top: screenHeight * .0175),
              child: CircleIconButton(
                size: screenHeight * .02, 
                icon: Icon(Icons.check, color: ref.watch(isAllSelectProvider) ? Colors.white : FlexiColor.grey[600], size: screenHeight * .015),
                border: ref.watch(isAllSelectProvider) ? null : Border.all(color: FlexiColor.grey[600]!),
                fillColor: ref.watch(isAllSelectProvider) ? FlexiColor.secondary : null,
                onPressed: () {}
              ),
            ) : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

}