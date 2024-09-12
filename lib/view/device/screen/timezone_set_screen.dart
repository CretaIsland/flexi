import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:go_router/go_router.dart';
import '../../../component/search_bar.dart';
import '../../../feature/device/controller/device_register_controller.dart';
import '../../../feature/device/provider/timezone_provider.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(ref.watch(registerDataControllerProvider)['timeZone']!.isEmpty) {
        ref.watch(registerDataControllerProvider.notifier).setTimezone(await FlutterTimezone.getLocalTimezone());
      }
      var index = ref.watch(timezonesProvider).indexWhere((timezone) => timezone['timezone'] == ref.watch(registerDataControllerProvider)['timeZone']);
      _scrollController.jumpTo(index * .075.sh);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var timezones = ref.watch(timezonesProvider);
    var selectTimezone = ref.watch(registerDataControllerProvider)['timeZone'];
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
                  icon: Icon(Icons.arrow_back_ios, size: .03.sh, color: FlexiColor.primary)
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
              height: .675.sh,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(.015.sh)
              ),
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                itemCount: timezones.length,
                itemBuilder: (context, index) => timezones[index]['name']!.toLowerCase().contains(_searchText.toLowerCase()) ? GestureDetector(
                  onTap: () => ref.watch(registerDataControllerProvider.notifier).setTimezone(timezones[index]['timezone']!),
                  child: Container(
                    padding: EdgeInsets.all(.02.sh),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: FlexiColor.grey[400]!))),
                    child: Row(
                      children: [
                        SizedBox(
                          width: .7.sw,
                          child: Text(
                            timezones[index]['name']!,
                            style: selectTimezone == timezones[index]['timezone']! ? 
                              Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlexiColor.primary) :
                              Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                        Visibility(
                          visible: selectTimezone == timezones[index]['timezone'],
                          child: Icon(Icons.check, size: .025.sh, color: FlexiColor.primary)
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