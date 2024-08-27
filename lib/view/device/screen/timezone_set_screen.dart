import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../component/search_bar.dart';
import '../../../feature/device/controller/device_register_controller.dart';
import '../../../util/design/colors.dart';



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
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   if(ref.watch(registerDataControllerProvider)['timeZone']!.isEmpty) {
    //     initializeTimeZones();
    //     setLocalLocation(getLocation(""));
    //     ref.watch(registerDataControllerProvider.notifier).setTimezone(await FlutterNativeTimezone.getLocalTimezone());
    //   }
    //   var index = ref.watch(timezonesProvider).indexWhere((timezone) => timezone['name'] == ref.watch(registerDataControllerProvider)['timeZone']);
    //   _scrollController.jumpTo(index * .0865.sh);
    // });
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
                  icon: Icon(Icons.arrow_back_ios_rounded, size: .025.sh, color: FlexiColor.primary)
                ),
                Text('Set Device Timezone', style: Theme.of(context).textTheme.displaySmall),
                TextButton(
                  onPressed: () => context.go('/device/setWifi'), 
                  child: Text('OK', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.primary))
                )
              ]
            ),
            SizedBox(height: .03.sh),
            FlexiSearchBar(
              hintText: 'Search your timezone', 
              onChanged: (value) => setState(() => _searchText = value)
            ),
            SizedBox(height: .02.sh),
            Container(
              width: .89.sw,
              height: .68.sh,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(.015.sh)
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                controller: _scrollController,
                itemCount: timezones.length,
                itemBuilder: (context, index) => timezones[index]['label']!.contains(_searchText) ? GestureDetector(
                  onTap: () => ref.watch(registerDataControllerProvider.notifier).setTimezone(timezones[index]['name']!),
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
                            style: ref.watch(registerDataControllerProvider)['timeZone'] == timezones[index]['name'] ?
                              Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.primary) :
                              Theme.of(context).textTheme.bodyMedium
                          )
                        ),
                        Visibility(
                          visible: ref.watch(registerDataControllerProvider)['timeZone'] == timezones[index]['name'],
                          child: Icon(Icons.check_rounded, size: .025.sh, color: FlexiColor.primary)
                        )
                      ]
                    )
                  )
                ) : const SizedBox.shrink()
              )
            )
          ]
        )
      )
    );
  }
}