import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../common/providers/network_providers.dart';
import '../../../component/search_bar.dart';
import '../../../feature/device/controller/device_setup_controller.dart';
import '../../../feature/device/provider/timezone_provider.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



class TimezoneSetScreen extends ConsumerWidget {
  const TimezoneSetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(deviceSetupControllerProvider);
    return Padding(
      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => context.go('/device/list'),
                icon: Icon(Icons.arrow_back_ios, color: FlexiColor.primary, size: .03.sh),
              ),
              Text('Set Device Timezone', style: FlexiFont.semiBold20),
              TextButton(
                onPressed: () => context.go('/device/setWifi'),
                child: Text('OK', style: FlexiFont.regular16.copyWith(color: FlexiColor.primary)),
              )
            ],
          ),
          SizedBox(height: .03.sh),
          FlexiSearchBar(
            hintText: 'Search your timezone',
            onChanged: (value) {},
          ),
          SizedBox(height: .02.sh),
          Container(
            width: .89.sw,
            height: .7.sh,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.015.sh)
            ),
            child: timezoneListView(),
          )
        ],
      ),
    );
  }

  Consumer timezoneListView() {
    return Consumer(
      builder: (context, ref, child) {
        final timezones = ref.watch(timezonesProvider);
        return ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: timezones.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => ref.watch(selectTimezoneProvider.notifier).state = timezones[index],
              child: Padding(
                padding: EdgeInsets.all(.02.sh),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: .65.sw,
                      child: Text(
                        timezones[index]['label']!, 
                        style: ref.watch(selectTimezoneProvider) == timezones[index] ? 
                          FlexiFont.regular16.copyWith(color: FlexiColor.primary) : 
                          FlexiFont.regular16,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    ),
                    Visibility(
                      visible: ref.watch(selectTimezoneProvider) == timezones[index],
                      child: Icon(Icons.check, color: FlexiColor.primary, size: .025.sh),
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