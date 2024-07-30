import 'package:flutter/material.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/device/controller/device_register_controller.dart';
import '../../../util/ui/colors.dart';
import '../../../util/ui/fonts.dart';
import '../../common/component/search_bar.dart';



class TimezoneSetScreen extends ConsumerStatefulWidget {
  const TimezoneSetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimezoneSetScreenState();
}

class _TimezoneSetScreenState extends ConsumerState<TimezoneSetScreen> {

  final ScrollController _scrollController = ScrollController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(selectTimezoneProvider.notifier).state = await FlutterNativeTimezone.getLocalTimezone();
      print(ref.watch(selectTimezoneProvider));
      int index = ref.watch(timezonesProvider).indexWhere((element) => element['locationName'] == ref.watch(selectTimezoneProvider));
      print(index);
      print(ref.watch(timezonesProvider)[index]);
      _scrollController.jumpTo(index * 61);
    });
  }


  @override
  Widget build(BuildContext context) {
    var timezones = ref.watch(timezonesProvider);
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
                  icon: Icon(Icons.arrow_back_ios, size: .03.sh, color: FlexiColor.primary),
                ),
                Text('Set Device Timezone', style: FlexiFont.semiBold20),
                TextButton(
                  onPressed: () => context.go('/device/setWifi'), 
                  child: Text('OK', style: FlexiFont.regular16.copyWith(color: FlexiColor.primary))
                )
              ],
            ),
            SizedBox(height: .03.sh),
            FlexiSearchBar(
              hintText: 'Search your timezone',
              onChanged: (value) => setState(() {
                _searchText = value;
              })
            ),
            SizedBox(height: .02.sh),
            Container(
              width: .89.sw,
              height: .7.sh,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(.015.sh)
              ),
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                itemCount: timezones.length,
                itemBuilder: (context, index) => timezones[index]['name']!.contains(_searchText) ? GestureDetector(
                  onTap: () => ref.watch(selectTimezoneProvider.notifier).state = timezones[index]['locationName']!,
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
                            timezones[index]['name']!, 
                            style: ref.watch(selectTimezoneProvider) == timezones[index]['locationName'] ? 
                              FlexiFont.regular16.copyWith(color: FlexiColor.primary) : 
                              FlexiFont.regular16,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )
                        ),
                        Visibility(
                          visible: ref.watch(selectTimezoneProvider) == timezones[index]['locationName'],
                          child: Icon(Icons.check, color: FlexiColor.primary, size: .025.sh),
                        )
                      ],
                    ),
                  ),
                ) : const SizedBox.shrink()
              ),
            )
          ],
        ),
      ),
    );
  }
  
}