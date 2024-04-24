import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

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
        onTap: () {
          if(ref.watch(selectModeProvider)) {
            ref.watch(selectModeProvider.notifier).state = false;
            ref.watch(isAllSelectProvider.notifier).state = false;
          }
        },
        child: Container(
          color: FlexiColor.screenColor,
          padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .065, right: screenWidth * .055,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Devices", style: FlexiFont.semiBold30),
                  CircleIconButton(
                    onPressed: () async {
                      if(ref.watch(selectModeProvider)) {
                        showModalBottomSheet(
                          context: context, 
                          backgroundColor: Colors.transparent,
                          builder:(context) => const DeviceResetModal()
                        );
                      } else {
                        if(Platform.isIOS) {
                          openAppSettings();
                          // showModalBottomSheet(
                          //   context: context, 
                          //   isScrollControlled: true,
                          //   backgroundColor: Colors.transparent,
                          //   builder:(context) => HotspotListModal()
                          // );
                        } else {
                          showModalBottomSheet(
                            context: context, 
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder:(context) => HotspotListModal()
                          );
                        }
                      }
                    },
                    icon: Icon(ref.watch(selectModeProvider) ? Icons.link_off_rounded : Icons.add_rounded, color: Colors.white, size: screenHeight * .025),
                    size: screenHeight * .04,
                    fillColor: ref.watch(selectModeProvider) ? FlexiColor.secondary : FlexiColor.primary,
                  )
                ],
              ),
              SizedBox(height: screenHeight * .015),
              FlexiSearchBar(hintText: "Search your devices", textEditingController: TextEditingController()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('${15} Devices', style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                      SizedBox(width: screenWidth * .01),
                      IconButton(
                        onPressed: () {}, 
                        icon: Icon(Icons.refresh_rounded, color: FlexiColor.grey[600], size: screenHeight * .02)
                      )
                    ],
                  ),
                  Visibility(
                    visible: ref.watch(selectModeProvider),
                    child: Row(
                      children: [
                        Text('Select all', style: FlexiFont.regular12),
                        SizedBox(width: screenWidth * .01),
                        CircleIconButton(
                          onPressed: () => ref.watch(isAllSelectProvider.notifier).state = !ref.watch(isAllSelectProvider), 
                          icon: Icon(Icons.check_rounded, color: ref.watch(isAllSelectProvider) ? Colors.white : FlexiColor.grey[600], size: screenHeight * .015),
                          fillColor: ref.watch(isAllSelectProvider) ? FlexiColor.secondary : null,
                          border: ref.watch(isAllSelectProvider) ? null : Border.all(color: FlexiColor.grey[600]!),
                          size: screenHeight * .02,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                  itemBuilder: (context, index) {
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
      onTap: () => ref.watch(selectModeProvider) ? null : context.go("/device/info"),
      onLongPress: () => ref.watch(selectModeProvider) ? null : ref.watch(selectModeProvider.notifier).state = true,
      child: Container(
        width: screenWidth * .89,
        height: screenHeight * .1,
        padding: EdgeInsets.all(screenHeight * .02),
        margin: EdgeInsets.only(bottom: screenHeight * .02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenHeight * .01)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.link_rounded, color: FlexiColor.primary, size: screenHeight * .02),
                SizedBox(width: screenWidth * .033),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Device Name", style: FlexiFont.regular16,),
                    SizedBox(height: screenHeight * .01),
                    Text("Device Id", style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600]))
                  ],
                )
              ],
            ),
            Visibility(
              visible: ref.watch(selectModeProvider),
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