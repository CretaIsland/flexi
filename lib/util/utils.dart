import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';



class FlexiUtils {

  static bool checkDevice(String deviceId, String enterprise) {
    RegExp regExp = RegExp(RegExp.escape(enterprise) + r'-\d{6}');
    if (regExp.hasMatch(deviceId)) return true;
    return false;
  }

  static Map<String, String>? getWifiCredential(String code) {
    Map<String, String> result = {};
    if(!code.contains('WIFI')) return null;

    List<String> parts = code.split(';');
    for(var part in parts) {
      List<String> value = part.split(':');
      if(value.contains('S')) {
        result['ssid'] = value.last;
      } else if(value.contains('T')) {
        result['security'] = value.last;
      } else if(value.contains('P')) {
        result['password'] = value.last;
      }
    }
    return result;
  }

  static void showMsg(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.black.withOpacity(.8),
      textColor: Colors.white,
      fontSize: .02375.sh
    );
  }

}