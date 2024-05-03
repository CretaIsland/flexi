import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

import '../../components/search_bar.dart';
import '../../main.dart';
import '../../utils/ui/colors.dart';
import '../../utils/ui/fonts.dart';



class DeviceTimezoneSetScreen extends ConsumerStatefulWidget {
  const DeviceTimezoneSetScreen({super.key});

  @override
  ConsumerState<DeviceTimezoneSetScreen> createState() => _DeviceTimezoneSetScreenState();
}

class _DeviceTimezoneSetScreenState extends ConsumerState<DeviceTimezoneSetScreen> {

  List<Map<String, Object>> timezoneList = [];
  final searchText = StateProvider<String>((ref) => "");
  final selectedIndex = StateProvider<int>((ref) => -1);

  @override
  void initState() {
    super.initState();
    getTimezoneList();
  }

  void getTimezoneList() {
    initializeTimeZones();
    RegExp alphabetsRegex = RegExp(r'[a-zA-Z]');
    for(var item in timeZoneDatabase.locations.values.toList()) {
      TimeZone itemTimezone = item.timeZone(DateTime.now().millisecondsSinceEpoch);
      Duration duration = Duration(milliseconds: itemTimezone.offset);
      String itemAbbreviation = alphabetsRegex.hasMatch(itemTimezone.abbreviation) ? itemTimezone.abbreviation : "UTC";
      String timezone = "${duration.inHours >= 0 ? "+" : ""}${duration.inHours.toString().padLeft(2, "0")}:${(duration.inMinutes.remainder(60)).toString().padLeft(2, "0")}";

      timezoneList.add({"label" : "${item.name}($itemAbbreviation $timezone)"});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlexiColor.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * .04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.go("/device/list"),
                  icon: Icon(Icons.arrow_back_ios_new, color: FlexiColor.primary),
                  iconSize: screenHeight * .025,
                ),
                Text("Set Device Timezone", style: FlexiFont.semiBold20),
                TextButton(
                  onPressed: () => context.go("/device/setWifi"),
                  child: Text("OK", style: FlexiFont.regular16.copyWith(color: FlexiColor.primary)),
                )
              ],
            ),
            SizedBox(height: screenHeight * .03),
            FlexiSearchBar(
              hintText: "Search timezone",
              onChanged: (value) {
                ref.watch(searchText.notifier).state = value;
                print(ref.watch(searchText));
              },
            ),
            SizedBox(height: screenHeight * .02),
            Container(
              width: screenWidth * .89,
              height: screenHeight * .7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: timezoneList.length,
                itemBuilder:(context, index) {
                  if(ref.watch(searchText).isEmpty || (ref.watch(searchText).isNotEmpty && timezoneList[index]["label"].toString().contains(ref.watch(searchText)))) {
                    return InkWell(
                      onTap: () => ref.watch(selectedIndex.notifier).state = index,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: FlexiColor.grey[400]!))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: screenWidth * .7,
                              child: Text(
                                timezoneList[index]["label"].toString(),
                                style: ref.watch(selectedIndex) == index ? FlexiFont.regular16.copyWith(color: FlexiColor.primary) : FlexiFont.regular16, 
                                maxLines: 2
                              ),
                            ),
                            ref.watch(selectedIndex) == index ? Icon(Icons.check, color: FlexiColor.primary, size: screenHeight * .025) : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }
              )
            )
          ],
        ),
      ),
    );
  }

}