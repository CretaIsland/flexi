import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../utils/ui/colors.dart';
import '../utils/ui/fonts.dart';
import '../main.dart';


// tab index provider
final tabIndexProvider = StateProvider<int>((ref) => 0);


class FlexiBottomNaviagtionBar extends ConsumerStatefulWidget {
  const FlexiBottomNaviagtionBar({super.key});

  @override
  ConsumerState<FlexiBottomNaviagtionBar> createState() => _FlexiBottomNaviagtionBarState();
}

class _FlexiBottomNaviagtionBarState extends ConsumerState<FlexiBottomNaviagtionBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * .08,
      color: FlexiColor.grey[300],
      padding: EdgeInsets.only(left: screenWidth * .1, right: screenWidth * .1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          tabItem("Devices", Icons.connected_tv_outlined, "/device/list", 0),
          tabItem("Contents", Icons.interests, "/content/list", 1),
          tabItem("Setting", Icons.settings, "/setting/menu", 2)
        ],
      ),
    );
  }

  Widget tabItem(String itemLabel, IconData itemIcon, String routeName, int tabIndex) {
    return GestureDetector(
      onTap: () {
        ref.watch(tabIndexProvider.notifier).state = tabIndex;
        context.go(routeName);
      },
      child: SizedBox(
        width: screenWidth * .15,
        height: screenHeight * .06,
        child: Column(
          children: [
            Icon(itemIcon, color: ref.watch(tabIndexProvider) == tabIndex? FlexiColor.primary : FlexiColor.grey[600], size: screenHeight * .035),
            Text(itemLabel, style: FlexiFont.medium12.copyWith(color: ref.watch(tabIndexProvider) == tabIndex ? FlexiColor.primary : FlexiColor.grey[600]))
          ],
        ),
      ),
    );
  }

}