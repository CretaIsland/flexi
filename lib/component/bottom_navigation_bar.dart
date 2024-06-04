import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../utils/ui/color.dart';
import '../utils/ui/font.dart';



final currentTabIndex = StateProvider<int>((ref) => 0);

class FlexiBottomNavigationBar extends ConsumerWidget {
  const FlexiBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: .08.sh,
      color: FlexiColor.grey[300],
      padding: EdgeInsets.only(left: .1.sw, right: .1.sw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          tabButton('Devices', Icons.connected_tv_outlined, '/device/list', 0),
          tabButton('Contents', Icons.interests, '/content/list', 1),
          tabButton('Setting', Icons.settings, '/settings', 2)
        ],
      ),
    );
  }

  Widget tabButton(String text, IconData icon, String routePath, int tabIndex) {
    return Consumer(
      builder: (context, ref, child) {
        return InkWell(
          onTap: () {
            ref.watch(currentTabIndex.notifier).state = tabIndex;
            context.go(routePath);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: ref.watch(currentTabIndex) == tabIndex ? FlexiColor.primary : FlexiColor.grey[600], size: .035.sh),
              Text(text, style: FlexiFont.medium12.copyWith(color: ref.watch(currentTabIndex) == tabIndex ? FlexiColor.primary : FlexiColor.grey[600]))
            ],
          ),
        );
      },
    );
  }
}