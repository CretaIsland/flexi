import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../utils/ui/color.dart';
import '../utils/ui/font.dart';



final currentTabProvider = StateProvider<int>((ref) => 0);

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
          tabButton(context, ref, 'Devices', Icons.connected_tv_outlined, '/device/list', 0),
          tabButton(context, ref, 'Contents', Icons.interests, '/content/list', 1),
          tabButton(context, ref, 'Setting', Icons.settings, '/settings', 2)
        ],
      ),
    );
  }

  Widget tabButton(BuildContext context, WidgetRef ref, String text, IconData icon, String routePath, int index) {
    return InkWell(
      onTap: () {
        ref.watch(currentTabProvider.notifier).state = index;
        context.go(routePath);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: .035.sh, color: ref.watch(currentTabProvider) == index ? FlexiColor.primary : FlexiColor.grey[600]),
          Text(text, style: FlexiFont.medium12.copyWith(color: ref.watch(currentTabProvider) == index ? FlexiColor.primary : FlexiColor.grey[600]))
        ],
      ),
    );
  }

}