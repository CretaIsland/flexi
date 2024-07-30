import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

part 'timezone_provider.g.dart';



@riverpod
List<Map<String, String>> timezones(TimezonesRef ref) {
  try {
    initializeTimeZones();
    RegExp alphabetsRegex = RegExp(r'[a-zA-Z]');
    
    return timeZoneDatabase.locations.values.toList().map((item) {
      TimeZone itemTimezone = item.timeZone(DateTime.now().millisecondsSinceEpoch);
      Duration duration = Duration(milliseconds: itemTimezone.offset);
      String itemAbbreviation = alphabetsRegex.hasMatch(itemTimezone.abbreviation) ? itemTimezone.abbreviation : 'UTC';
      String timezone = '${duration.inHours >= 0 ? '+' : ''}${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes.remainder(60)).toString().padLeft(2, '0')}';
      return {
        'label': '${item.name} ($itemAbbreviation $timezone)',
        'locationName': item.name
      };
    }).toList();
  } catch (error) {
    print('error at timezones >>> $error');
  }
  return List.empty();
}