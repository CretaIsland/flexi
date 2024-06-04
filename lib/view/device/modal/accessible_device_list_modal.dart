import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/search_bar.dart';
import '../../../component/text_button.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class AccessibleDeviceListModal extends ConsumerWidget {
  
  AccessibleDeviceListModal({super.key});
  final selectHotspotProvider = StateProvider<int>((ref) => -1);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 1.sw,
      height: .9.sh,
      padding: EdgeInsets.only(left: .055.sw, top: .07.sh, right: .055.sw),
      decoration: BoxDecoration(
        color: FlexiColor.backgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(.025.sh), topRight: Radius.circular(.025.sh))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Device to use \nwith Digital Barricade', style: FlexiFont.regular20),
          SizedBox(height: .02.sh),
          FlexiSearchBar(
            hintText: 'Search your device',
            onChanged: (value) {},
          ),
          SizedBox(height: .03.sh),
          Container(
            width: .89.sw,
            height: .5.sh,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.01.sh)
            ),
            child: accessibleDeviceListView(),
          ),
          SizedBox(height: .02.sh),
          FlexiTextButton(
            width: .89.sw, 
            height: .06.sh, 
            text: 'Add',
            fillColor: FlexiColor.primary,
            onPressed: () {
              context.pop();
              context.go('/device/setTimezone');
            },
          )
        ],
      ),
    );
  }

  Consumer accessibleDeviceListView() {
    return Consumer(
      builder: (context, ref, child) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: 10,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => ref.watch(selectHotspotProvider.notifier).state = index,
              child: Padding(
                padding: EdgeInsets.all(.02.sh),
                child: Row(
                  children: [
                    ref.watch(selectHotspotProvider) == index ?
                      Icon(Icons.check_circle, color: FlexiColor.primary, size: .025.sh) : 
                      Icon(Icons.check_circle_outline, color: FlexiColor.grey[600], size: .025.sh),
                    const SizedBox(width: 12),
                    Icon(Icons.wifi, color: Colors.black, size: .025.sh),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: .6.sw,
                      child: Text(
                        'DBAP0001', 
                        style: FlexiFont.regular16,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(color: FlexiColor.grey[400]),
        );  
      },
    );
  }

}