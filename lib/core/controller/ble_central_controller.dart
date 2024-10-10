import 'dart:convert';
import 'dart:typed_data';
import 'package:bluetooth_low_energy/bluetooth_low_energy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ble_central_controller.g.dart';



@riverpod
class BleCentralController extends _$BleCentralController {

  late CentralManager _manager;
  GATTCharacteristic? _canWrite;

  @override
  void build() {
    ref.onDispose(() {
      print('BLECentralController Dispose');
    });
    print('BLECentralController Build');
    _manager = CentralManager();
  }

  Future<bool> sendData(Peripheral peripheral, Map<String, String> data) async {
    try {
      await _manager.connect(peripheral);
      await discoverGATT(peripheral);
      if(_canWrite != null) {
        await write(peripheral, utf8.encode(jsonEncode(data)), _canWrite!);
      }
      await _manager.disconnect(peripheral);
      return true;
    } catch (error) {
      print('Error at BLECentralManager.sendData >>> $error');
      return false;
    }
  }

  Future<void> discoverGATT(Peripheral peripheral) async {
    final services = await _manager.discoverGATT(peripheral);
    final lastService = services.last;

    for(int i = 0; i < lastService.characteristics.length; i++) {
      final characteristic = lastService.characteristics[i];
      if(characteristic.properties.contains(GATTCharacteristicProperty.write)) {
        _canWrite = characteristic;
      }
    }
  }

  Future<void> write(Peripheral peripheral, Uint8List data, GATTCharacteristic characteristic) async {
    const writeType = GATTCharacteristicWriteType.withResponse;
    final fragmentSize = await _manager.getMaximumWriteLength(peripheral, type: writeType);

    var start = 0;
    while(start < data.length) {
      final end = start + fragmentSize;
      final fragmentData = end < data.length ? data.sublist(start, end) : data.sublist(start);
      await _manager.writeCharacteristic(peripheral, characteristic, value: fragmentData, type: writeType);
      start = end;
    }
  }

}