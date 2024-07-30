import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';



class FlexiUtils {

  // String to color
  static stringToColor(String colorStr) {
    String extract = extractColorString(colorStr);
    if (extract.length == 8) {
      return Color(int.parse(extract, radix: 16));
    }
    return null;
  }

  static String extractColorString(String input) {
    final RegExp colorRegex = RegExp(r'Color\(0x(.{8})\)');
    final Match? match = colorRegex.firstMatch(input);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    }
    return '';
  }

  static String stringToSha1(String str) {
    return sha1.convert(utf8.encode(str)).toString();
  }
  
}