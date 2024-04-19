import 'package:flexi/component/circle_icon_button.dart';
import 'package:flexi/component/search_bar.dart';
import 'package:flexi/main.dart';
import 'package:flexi/utils/colors.dart';
import 'package:flexi/utils/fonts.dart';
import 'package:flexi/view/modal/device_reset_modal.dart';
import 'package:flexi/view/modal/hotspot_list_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




final selectModeProvider = StateProvider<bool>((ref) => false);
final selectAllProvider = StateProvider<bool>((ref) => false);


class DeviceListScreen extends ConsumerStatefulWidget {
  const DeviceListScreen({super.key});
  @override
  ConsumerState<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends ConsumerState<DeviceListScreen> {

  @override
  Widget build(BuildContext context, ) {
    return GestureDetector(
      onTap: () => ref.watch(selectModeProvider.notifier).state = false,
      child: Container(
        color: FlexiColor.screenColor,
        padding: EdgeInsets.only(top: screenHeight * .065, left: screenWidth * .05, right: screenWidth * .05),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Devices', style: FlexiFont.semiBold30),
                CircleIconButton(
                  size: screenHeight * .04, 
                  icon: Icon(ref.watch(selectModeProvider) ? Icons.link_off : Icons.add_rounded, size: screenHeight * .03, color: Colors.white),
                  fillColor: ref.watch(selectModeProvider) ? FlexiColor.secondary : FlexiColor.primary,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context, 
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => ref.watch(selectModeProvider) ? const DeviceResetModal() : const HotSpotListModal()
                    );
                  },
                )
              ],
            ),
            SizedBox(height: screenHeight * .0175),
            FlexiSearchBar(hintText: "Search your device", searchTextController: TextEditingController()),
            SizedBox(height: screenHeight * .0175),
            Row(
              children: [
                Text(" ${15} Devices", style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600])),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.refresh, size: screenHeight * .02, color: FlexiColor.grey[600]),
                ),
                SizedBox(width: screenWidth * .43),
                ref.watch(selectModeProvider) ? Text("Select all", style: FlexiFont.regular12,) : const SizedBox.shrink(),
                const SizedBox(width: 4),
                ref.watch(selectModeProvider) ? CircleIconButton(
                  size: screenHeight * .02, 
                  icon: Icon(Icons.check, size: screenHeight * .01, color: ref.watch(selectAllProvider) ? Colors.white : FlexiColor.grey[600]),
                  fillColor: ref.watch(selectAllProvider) ? FlexiColor.secondary : Colors.transparent,
                  border: ref.watch(selectAllProvider) ? null : Border.all(color: FlexiColor.grey[600]!),
                  onPressed: () => ref.watch(selectAllProvider.notifier).state = !ref.watch(selectAllProvider),
                ) : const SizedBox.shrink()
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder:(context, index) {
                  return DeviceComponentWidget(index: index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}


// device component widget
class DeviceComponentWidget extends ConsumerWidget {

  const DeviceComponentWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onLongPress: () => ref.watch(selectModeProvider.notifier).state = true,
      child: Container(
        width: screenWidth * .89,
        height: screenHeight * .1,
        margin: EdgeInsets.only(bottom: screenHeight * .02),
        padding: EdgeInsets.only(top: screenHeight * .02, left: 16, right: 16),
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
              children: [
                Icon(Icons.link, size: screenHeight * .02, color: FlexiColor.primary,),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Device Name", style: FlexiFont.regular16),
                    Text("Device ID", style: FlexiFont.regular12.copyWith(color: FlexiColor.grey[600]))
                  ],
                )
              ],
            ),
            ref.watch(selectModeProvider) ? Padding(
              padding: EdgeInsets.only(top: screenHeight * .02),
              child: CircleIconButton(
                size: screenHeight * .02, 
                icon: Icon(Icons.check, size: screenHeight * .01, color: FlexiColor.grey[600]),
                border: Border.all(color: FlexiColor.grey[600]!),
                onPressed: () {},
              ),
            ) : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
  
}