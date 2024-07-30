import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wifi_scan/wifi_scan.dart';

part 'accessible_devices_provider.g.dart';


@riverpod
Future<Stream<List<String>>> accessibleHotspots(AccessibleHotspotsRef ref) async {
  try {
    if(await WiFiScan.instance.canStartScan(askPermissions: true) == CanStartScan.yes) {
      await WiFiScan.instance.startScan();
      return WiFiScan.instance.onScannedResultsAvailable.map((event) {
        return event.where((element) => element.ssid.isNotEmpty).map((e) {
          return e.ssid;
        }).toList();
      });
    }
  } catch (error) {
    print('error at AccessibleHotspotsProvider >>> $error');
  }
  return const Stream.empty();
}