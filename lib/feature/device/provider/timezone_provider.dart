import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

part 'timezone_provider.g.dart';



@riverpod
List<Map<String, String>> timezones(TimezonesRef ref) {
  initializeTimeZones();
  RegExp utcRegExp = RegExp(r'[a-zA-Z]');

  return timeZoneDatabase.locations.values.map((item) {
    TimeZone timezone = item.timeZone(DateTime.now().millisecondsSinceEpoch);
    Duration duration = Duration(milliseconds: timezone.offset);
    String abbreviation = utcRegExp.hasMatch(timezone.abbreviation) ? timezone.abbreviation : 'UTC';
    String timeDifference = '${duration.inHours >= 0 ? '+' : ''}${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}';

    return {
      'name': '${item.name} ($abbreviation $timeDifference)',
      'timezone': item.name
    };
  }).toList();
}