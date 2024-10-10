import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';
import '../controller/device_register_controller.dart';

part 'timezone_provider.g.dart';



@riverpod
Future<List<Map<String, String>>> timezones(TimezonesRef ref) async {
  initializeTimeZones();
  RegExp utcRegExp = RegExp(r'[a-zA-Z]');

  var myTimezone = await FlutterTimezone.getLocalTimezone();
  var timezones = timeZoneDatabase.locations.values.toList();

  int index = timezones.indexWhere((timezone) => timezone.name == myTimezone);
  if(index != -1) {
    timezones.insert(0, timezones[index]);
    timezones.removeAt(index + 1);
    if(ref.read(registerDataProvider)['timeZone']!.isEmpty) {
      var newRegisterData = ref.read(registerDataProvider);
      newRegisterData['timeZone'] = myTimezone;
      ref.watch(registerDataProvider.notifier).state = newRegisterData;
    }
  }

  return timezones.map((item) {
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