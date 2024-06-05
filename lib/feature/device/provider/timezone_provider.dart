// 모든 Timezone을 List로 가져오기
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timezone_provider.g.dart';



// 선택한 타임존
final selectTimezoneProvider= StateProvider<Map<String, String>>((ref) => {});

// 전 세계 타임존 가져오기
@riverpod
List<Map<String, String>> timezones(TimezonesRef ref) {
  ref.onDispose(() {
    print('<<<<< timezonesProvider Dispose <<<<<');
  });
  print('<<<<< timezonesProvider Build <<<<<');
  try {
    initializeTimeZones();
    RegExp alphabetsRegex = RegExp(r'[a-zA-Z]');
    List<Map<String, String>> timezoneList = [];
    for(var item in timeZoneDatabase.locations.values.toList()) {
      TimeZone itemTimezone = item.timeZone(DateTime.now().millisecondsSinceEpoch);
      Duration duration = Duration(milliseconds: itemTimezone.offset);
      String itemAbbreviation = alphabetsRegex.hasMatch(itemTimezone.abbreviation) ? itemTimezone.abbreviation : 'UTC';
      String timezone = '${duration.inHours >= 0 ? '+' : ''}${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes.remainder(60)).toString().padLeft(2, '0')}';

      timezoneList.add({
        'label': '${item.name} ($itemAbbreviation $timezone)',
        'locationName': item.name
      });
    }

    return timezoneList; 
  } catch (error) {
    print('error at timezonesProvider >>> $error');
  }
  return List.empty();
}