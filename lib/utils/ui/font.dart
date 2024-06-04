import 'package:flutter/material.dart';

import '../../main.dart';



class FlexiFont {

  static const String fontFamily = 'Roboto';


  // thin
  static TextStyle thin = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w100,
    color: Colors.black
  );

  // light
  static TextStyle light = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w300,
    color: Colors.black
  );

  // regular
  static TextStyle regular = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: Colors.black
  );
  static TextStyle regular9 = regular.copyWith(fontSize: textScaler.scale(9));
  static TextStyle regular11 = regular.copyWith(fontSize: textScaler.scale(11));
  static TextStyle regular12 = regular.copyWith(fontSize: textScaler.scale(12));
  static TextStyle regular13 = regular.copyWith(fontSize: textScaler.scale(13));
  static TextStyle regular14= regular.copyWith(fontSize: textScaler.scale(14));
  static TextStyle regular16 = regular.copyWith(fontSize: textScaler.scale(16));
  static TextStyle regular20= regular.copyWith(fontSize: textScaler.scale(20));
  static TextStyle regular24 = regular.copyWith(fontSize: textScaler.scale(24));

  // medium
  static TextStyle medium = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    color: Colors.black
  );
  static TextStyle medium12 = medium.copyWith(fontSize: textScaler.scale(12));

  // semiBold
  static TextStyle semiBold = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    color: Colors.black
  );
  static TextStyle semiBold11 = semiBold.copyWith(fontSize: textScaler.scale(11));
  static TextStyle semiBold14 = semiBold.copyWith(fontSize: textScaler.scale(14));
  static TextStyle semiBold16 = semiBold.copyWith(fontSize: textScaler.scale(16));
  static TextStyle semiBold20 = semiBold.copyWith(fontSize: textScaler.scale(20));
  static TextStyle semiBold24 = semiBold.copyWith(fontSize: textScaler.scale(24));
  static TextStyle semiBold30 = semiBold.copyWith(fontSize: textScaler.scale(30));

  // bold
  static TextStyle bold = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    color: Colors.black
  );

  // black
  static TextStyle black = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w900,
    color: Colors.black
  );

}