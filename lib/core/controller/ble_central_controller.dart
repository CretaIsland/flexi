import 'dart:convert';
import 'dart:typed_data';

import 'package:bluetooth_low_energy/bluetooth_low_energy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ble_central_controller.g.dart';



@riverpod
class BleCentralController extends _$BleCentralController {

  late CentralManager _centralManager;
  GATTCharacteristic? _canWrite;

  @override
  void build() {
    ref.onDispose(() {
      print('BleCentralController Dispose');
    });
    print('bleCentralController Build');
    _centralManager = CentralManager();
  }

  Future<void> discoverGATT(Peripheral peripheral) async {
    final services = await _centralManager.discoverGATT(peripheral);
    final lastService = services.last;
    for(int i=0; i<lastService.characteristics.length; i++) {
      final characteristic = lastService.characteristics[i];
      if(characteristic.properties.contains(GATTCharacteristicProperty.write)) {
        _canWrite = characteristic;
      }
    }
  }

  Future<void> write(Peripheral peripheral, Uint8List data, GATTCharacteristic characteristic) async {
    const writeType = GATTCharacteristicWriteType.withResponse;
    final fragmentSize = await _centralManager.getMaximumWriteLength(peripheral, type: writeType);

    var start = 0;
    while(start < data.length) {
      final end = start + fragmentSize;
      final fragmentedData = end < data.length ? data.sublist(start, end) : data.sublist(start);
      await _centralManager.writeCharacteristic(
        peripheral, 
        characteristic, 
        value: fragmentedData, 
        type: writeType
      );
      start = end;
    }
  }

  Future<bool> sendData(Peripheral peripheral, Map<String, String> data) async {
    try {
      await _centralManager.connect(peripheral);
      await discoverGATT(peripheral);
      if(_canWrite != null) {
        await write(peripheral, utf8.encode(jsonEncode(data)), _canWrite!);
      }
      await _centralManager.disconnect(peripheral);
      return true;
    } catch (error) {
      print('Error at BleCentralController.sendData >>> $error');
    }
    return false;
  }

}