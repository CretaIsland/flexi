import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../components/bottom_navigation_bar.dart';
import '../../components/circle_icon_button.dart';
import '../../components/search_bar.dart';
import '../../main.dart';
import '../../utils/ui/colors.dart';
import '../../utils/ui/fonts.dart';
import 'modal/device_reset_modal.dart';
import 'modal/hotspot_list_modal.dart';



final selectedMode = StateProvider<bool>((ref) => false);
final isAllSelected = StateProvider<bool>((ref) => false);
final selectedDeviceIndexs = StateProvider<List<int>>((ref) => []);

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
        onTap: () {
          ref.watch(selectedMode.notifier).state = false;
          ref.watch(isAllSelected.notifier).state = false;
        },
        child: Container(
          color: FlexiColor.backgroundColor,
          padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .065, right: screenWidth * .055),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Devices", style: FlexiFont.semiBold30),
                  CircleIconButton(
                    size: screenHeight * .04, 
                    icon: Icon(ref.watch(selectedMode) ? Icons.link_off_outlined : Icons.add, color: Colors.white, size: screenHeight * .03),
                    fillColor: ref.watch(selectedMode) ? FlexiColor.secondary : FlexiColor.primary,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context, 
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder:(context) => ref.watch(selectedMode) ? const DeviceResetModal() : HotspotListModal()
                      );
                    },
                  )
                ],
              ),
              const SizedBox(height: 12),
              const FlexiSearchBar(hintText: "Search your device"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("${15} Devices", style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () {},
                        child: Icon(Icons.refresh, color: FlexiColor.grey[500], size: screenHeight * .02)
                      )
                    ],
                  ),
                  ref.watch(selectedMode) ? Row(
                    children: [
                      Text("Select all", style: FlexiFont.regular12),
                      const SizedBox(width: 4),
                      CircleIconButton(
                        size: screenHeight * .025, 
                        icon: Icon(
                          Icons.check, 
                          color: ref.watch(isAllSelected) ? Colors.white : FlexiColor.grey[600], 
                          size: screenHeight * .02
                        ),
                        fillColor: ref.watch(isAllSelected) ? FlexiColor.secondary : null,
                        border: ref.watch(isAllSelected) ? null : Border.all(color: FlexiColor.grey[600]!),
                        onPressed: () {
                          ref.watch(isAllSelected.notifier).state = !ref.watch(isAllSelected);
                        },
                      )
                    ],
                  ) : const SizedBox.shrink()
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                  itemBuilder:(context, index) {
                    return DeviceComponent(index: index);
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

class DeviceComponent extends ConsumerWidget {
  const DeviceComponent({super.key, required this.index});
  final int index;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onLongPress: () => ref.watch(selectedMode.notifier).state = true,
      onTap: () {
        if(ref.watch(selectedMode)) {
          ref.watch(selectedDeviceIndexs.notifier).state.add(index);
          return;
        }
        context.go("/device/detail");
      },
      child: Container(
        width: screenWidth * .89,
        height: screenHeight * .1,
        padding: EdgeInsets.only(left: screenWidth * .04, right: screenWidth * .04),
        margin: EdgeInsets.only(bottom: screenHeight * .02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenHeight * .01)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * .02),
                Row(
                  children: [
                    Icon(Icons.link_rounded, color: FlexiColor.primary, size: 16),
                    const SizedBox(width: 12),
                    Text("Device name", style: FlexiFont.regular16,)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: Text("Device ID", style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                )
              ],
            ),
            Visibility(
              visible: ref.watch(selectedMode),
              child: Container(
                width: screenHeight * .02,
                height: screenHeight * .02,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: FlexiColor.grey[600]!),
                  borderRadius: BorderRadius.circular(screenHeight * .01)
                ),
                child: Center(
                  child: Icon(Icons.check_rounded, color: FlexiColor.grey[600], size: screenHeight * .015),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}