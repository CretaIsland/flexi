import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



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
  static TextStyle regular9 = regular.copyWith(fontSize: .015.sh);
  static TextStyle regular11 = regular.copyWith(fontSize: .0175.sh);
  static TextStyle regular12 = regular.copyWith(fontSize: .01875.sh);
  static TextStyle regular13 = regular.copyWith(fontSize: .02.sh);
  static TextStyle regular14= regular.copyWith(fontSize: .02125.sh);
  static TextStyle regular16 = regular.copyWith(fontSize: .02375.sh);
  static TextStyle regular20= regular.copyWith(fontSize: .02875.sh);
  static TextStyle regular24 = regular.copyWith(fontSize: .03375.sh);

  // medium
  static TextStyle medium = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    color: Colors.black
  );
  static TextStyle medium12 = medium.copyWith(fontSize: .01875.sh);

  // semiBold
  static TextStyle semiBold = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    color: Colors.black
  );
  static TextStyle semiBold11 = semiBold.copyWith(fontSize: .0175.sh);
  static TextStyle semiBold14 = semiBold.copyWith(fontSize: .02125.sh);
  static TextStyle semiBold16 = semiBold.copyWith(fontSize: .02375.sh);
  static TextStyle semiBold20 = semiBold.copyWith(fontSize: .02875.sh);
  static TextStyle semiBold24 = semiBold.copyWith(fontSize: .03375.sh);
  static TextStyle semiBold30 = semiBold.copyWith(fontSize: .04125.sh);

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