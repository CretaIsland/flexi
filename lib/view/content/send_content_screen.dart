import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../component/circle_icon_button.dart';
import '../../component/search_bar.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';



class SendContentScreen extends ConsumerStatefulWidget {
  const SendContentScreen({super.key});

  @override
  ConsumerState<SendContentScreen> createState() => _SendContentScreenState();
}

class _SendContentScreenState extends ConsumerState<SendContentScreen> {

  final isAllSelectProvider = StateProvider<bool>((ref) => false);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: FlexiColor.screenColor,
        padding: EdgeInsets.only(left: screenWidth * .055, top: screenHeight * .04, right: screenWidth * .055),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.go("/content/info"),
                  icon: Icon(Icons.arrow_back_ios_new_rounded, color: FlexiColor.primary),
                  iconSize: screenHeight * .015,
                ),
                Text("Send to device", style: FlexiFont.semiBold20,),
                TextButton(
                  onPressed: () => context.go("/content/list"), 
                  child: Text("Send", style: FlexiFont.regular16.copyWith(color: FlexiColor.primary))
                )
              ],
            ),
            SizedBox(height: screenHeight * .015),
            FlexiSearchBar(hintText: "Search your content", textEditingController: TextEditingController()),
            SizedBox(height: screenHeight * .025),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Select all', style: FlexiFont.regular12),
                SizedBox(width: screenWidth * .01),
                CircleIconButton(
                  onPressed: () => ref.watch(isAllSelectProvider.notifier).state = !ref.watch(isAllSelectProvider), 
                  icon: Icon(Icons.check_rounded, color: ref.watch(isAllSelectProvider) ? Colors.white : FlexiColor.grey[600], size: screenHeight * .015),
                  fillColor: ref.watch(isAllSelectProvider) ? FlexiColor.primary : null,
                  border: ref.watch(isAllSelectProvider) ? null : Border.all(color: FlexiColor.grey[600]!),
                  size: screenHeight * .02,
                )
              ],
            ),
            SizedBox(height: screenHeight * .02),
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
        )
      ),
    );
  }
}


class DeviceComponent extends ConsumerWidget {
  const DeviceComponent({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {},
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
            Container(
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
          ],
        ),
      ),
    );
  }

}