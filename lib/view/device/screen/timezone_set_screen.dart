import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    var selectTimezone = ref.watch(registerDataProvider)['timeZone'];
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
              child: ref.watch(timezonesProvider).when(
                data: (data) => ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  itemBuilder: (context, index) => data[index]['name']!.toLowerCase().contains(_searchText.toLowerCase()) ? GestureDetector(
                    onTap: () {
                      var registerData = ref.watch(registerDataProvider);
                      registerData['tiemZone'] = data[index]['timezone']!;
                      ref.watch(registerDataProvider.notifier).state = registerData;
                    },
                    child: Container(
                      padding: EdgeInsets.all(.02.sh),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: FlexiColor.grey[400]!))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: .7.sw,
                            child: Text(
                              data[index]['name']!, 
                              style: selectTimezone == data[index]['timezone'] ? Theme.of(context).textTheme.labelLarge!.copyWith(color: FlexiColor.primary)
                                : Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis
                            )
                          ),
                          Visibility(
                            visible: selectTimezone == data[index]['timezone'],
                            child: Icon(Icons.check, size: .025.sh, color: FlexiColor.primary)
                          )
                        ]
                      )
                    )
                  ) : const SizedBox.shrink()
                ), 
                error: (error, stackTrace) => Center(
                  child: Text('Error during get timezones', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: FlexiColor.grey[600]))
                ), 
                loading: () => SizedBox(
                  width: .03.sh, 
                  height: .03.sh, 
                  child: CircularProgressIndicator(
                    color: FlexiColor.grey[600],
                    strokeWidth: 2.5
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}