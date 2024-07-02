import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/search_bar.dart';
import '../../../feature/device/controller/device_register_controller.dart';
import '../../../utils/ui/color.dart';
import '../../../utils/ui/font.dart';



final searchTextProvider = StateProvider<String>((ref) => '');

class TimezoneSetScreen extends ConsumerWidget {
  const TimezoneSetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(left: .055.sw, top: .04.sh, right: .055.sw),
      child: SingleChildScrollView(
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
                  onPressed: () {
                    ref.invalidate(searchTextProvider);
                    context.go('/device/setWifi');
                  },
                  child: Text('OK', style: FlexiFont.regular16.copyWith(color: FlexiColor.primary)),
                )
              ],
            ),
            SizedBox(height: .03.sh),
            FlexiSearchBar(
              hintText: 'Search your timezone',
              onChanged: (value) => ref.watch(searchTextProvider.notifier).state = value,
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
      ),
    );
  }

  Consumer timezoneListView() {
    return Consumer(
      builder: (context, ref, child) {
        final timezones = ref.watch(timezonesProvider);
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: timezones.length,
          itemBuilder: (context, index) {
            return timezones[index]['label']!.contains(ref.watch(searchTextProvider)) ? InkWell(
              onTap: () => ref.watch(selectTimezone.notifier).state = timezones[index]['locationName']!,
              child: Container(
                padding: EdgeInsets.all(.02.sh),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: FlexiColor.grey[400]!))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: .65.sw,
                      child: Text(
                        timezones[index]['label']!, 
                        style: ref.watch(selectTimezone)== timezones[index]['locationName'] ? 
                          FlexiFont.regular16.copyWith(color: FlexiColor.primary) : 
                          FlexiFont.regular16,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    ),
                    Visibility(
                      visible: ref.watch(selectTimezone) == timezones[index]['locationName'],
                      child: Icon(Icons.check, color: FlexiColor.primary, size: .025.sh),
                    )
                  ],
                ),
              ),
            ) : const SizedBox.shrink();
          },
        );  
      },
    );
  }

}