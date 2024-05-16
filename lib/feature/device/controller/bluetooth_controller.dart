import 'dart:async';
import 'dart:io';

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
    if(Platform.isIOS) {
      FlutterBluePlus.adapterState.listen((event) {
        if(event == BluetoothAdapterState.on) {
          state = true;
        } else {
          state = false;
        }
      });
    } else {
       FlutterBluePlus.adapterState.first.then((value) {
        if(value == BluetoothAdapterState.on) state = true;
      });
    }
    return false;
  }
  
  Future<void> turnOn() async {
    if(!state) {
      if(Platform.isAndroid) await FlutterBluePlus.turnOn();
      state = true;
    }
  }

  Future<void> turnOff() async {
    if(state) {
      state = false;
    }
  }

  
}