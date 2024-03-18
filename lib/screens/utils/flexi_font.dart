import 'package:flutter/material.dart';

class FlexiFont {

  static const fontFamily = 'Roboto';

  static const FontWeight thin = FontWeight.w100;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight black = FontWeight.w900;

  static TextStyle buttonExtraSmall = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: thin,
    fontSize: 12,
    color: Colors.black
  );
  static TextStyle buttonSmall = buttonExtraSmall.copyWith(fontWeight: light, fontSize: 14);

  

}