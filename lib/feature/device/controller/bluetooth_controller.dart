import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bluetooth_controller.g.dart';



@riverpod
class BluetoothController extends _$BluetoothController {

  late StreamController _streamController;

  @override
  bool build() {
    ref.onDispose(() {
      print("<<<<<<< BluetoothController dispose <<<<<<<");
      FlutterBluePlus.stopScan();
      _streamController.close();
    });
    print(">>>>>>> BluetoothController build >>>>>>");
    _streamController = StreamController();
    FlutterBluePlus.adapterState.first.then((value) {
      if(value == BluetoothAdapterState.on) state = true;
    });
    return false;
  }
  
  Future<void> turnOn() async {
    if(!state) {
      await FlutterBluePlus.turnOn();
      state = true;
    }
  }

  Future<void> turnOff() async {
    if(state) {
      state = false;
    }
  }

  
}