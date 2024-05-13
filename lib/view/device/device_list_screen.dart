import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../components/bottom_navigation_bar.dart';
import '../../components/circle_icon_button.dart';
import '../../components/search_bar.dart';
import '../../feature/device/controller/udp_broadcast_controller.dart';
import '../../main.dart';
import '../../utils/ui/colors.dart';
import '../../utils/ui/fonts.dart';



class DeviceListScreen extends ConsumerStatefulWidget {
  const DeviceListScreen({super.key});

  @override
  ConsumerState<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends ConsumerState<DeviceListScreen> {

  final _selectMode = StateProvider((ref) => false);
  final _isAllSelected = StateProvider((ref) => false);
  final _selectedItemIndexs = StateProvider<List<int>>((ref) => List.empty());


  @override
  Widget build(BuildContext context) {

    final _uDPBroadcastController = ref.watch(uDPBroadcastControllerProvider);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          ref.invalidate(_selectMode);
          ref.invalidate(_isAllSelected);
          ref.invalidate(_selectedItemIndexs);
        },
        child: Container(
          color: FlexiColor.backgroundColor,
          padding: EdgeInsets.only(left: screenWidth * .055, right: screenWidth * .055),
          child: Column(
            children: [
              SizedBox(height: screenHeight * .05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Devices", style: FlexiFont.semiBold30),
                  CircleIconButton(
                    size: screenHeight * .04, 
                    icon: Icon(Icons.add, color: Colors.white, size: screenHeight * .03),
                    fillColor: FlexiColor.primary,
                    onPressed: () {
              
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
                      Text("${_uDPBroadcastController.length} Devices", style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () => ref.invalidate(uDPBroadcastControllerProvider),
                        child: Icon(Icons.refresh, color: FlexiColor.grey[500], size: screenHeight * .02)
                      )
                    ],
                  ),
                  ref.watch(_selectMode) ? Row(
                    children: [
                      Text("Select all", style: FlexiFont.regular12),
                      const SizedBox(width: 4),
                      CircleIconButton(
                        size: screenHeight * .025, 
                        icon: Icon(
                          Icons.check, 
                          color: ref.watch(_isAllSelected) ? Colors.white : FlexiColor.grey[600], 
                          size: screenHeight * .02
                        ),
                        fillColor: ref.watch(_isAllSelected) ? FlexiColor.secondary : null,
                        border: ref.watch(_isAllSelected) ? null : Border.all(color: FlexiColor.grey[600]!),
                        onPressed: () {
                          ref.watch(_isAllSelected.notifier).state = !ref.watch(_isAllSelected);
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
                  itemCount: _uDPBroadcastController.length,
                  itemBuilder:(context, index) {
                    return InkWell(
                      onTap: () {
                        if(ref.watch(_selectMode)) {
                          ref.watch(_selectedItemIndexs.notifier).state.add(index);
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
                                    Text(ref.watch(uDPBroadcastControllerProvider)[index], style: FlexiFont.regular16,)
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 28),
                                  child: Text("Device ID", style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                                )
                              ],
                            ),
                            Visibility(
                              visible: ref.watch(_selectMode),
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