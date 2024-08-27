import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class FlexiFont {

  static const String fontFamily = 'Roboto';

  // regular
  static TextStyle regular = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: Colors.black
  );

  // medium
  static TextStyle medium = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    color: Colors.black
  );

  // semiBold
  static TextStyle semiBold = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    color: Colors.black
  );

  
  static TextTheme android = TextTheme(
    displayLarge: semiBold.copyWith(fontSize: .04125.sh, fontWeight: FontWeight.w500),   // semiBold30
    displayMedium: semiBold.copyWith(fontSize: .03375.sh, fontWeight: FontWeight.w500),  // semiBold24
    displaySmall: semiBold.copyWith(fontSize: .02875.sh, fontWeight: FontWeight.w500),   // semiBold20
    bodyLarge: regular.copyWith(fontSize: .02875.sh, fontWeight: FontWeight.w300),       // regular20
    bodyMedium: regular.copyWith(fontSize: .02375.sh, fontWeight: FontWeight.w300),       // regular16
    bodySmall: regular.copyWith(fontSize: .02125.sh, fontWeight: FontWeight.w300),      // regular14
    labelLarge: semiBold.copyWith(fontSize: .02375.sh, fontWeight: FontWeight.w500),     // semiBold16
    labelMedium: medium.copyWith(fontSize: .01875.sh, fontWeight: FontWeight.w400),      // medium12
    labelSmall: regular.copyWith(fontSize: .01875.sh, fontWeight: FontWeight.w300)       // regular12
  );

  static TextTheme ios = TextTheme(
    displayLarge: semiBold.copyWith(fontSize: .04125.sh), // semiBold30
    displayMedium: semiBold.copyWith(fontSize: .03375.sh), // semiBold24
    displaySmall: semiBold.copyWith(fontSize: .02875.sh), // semiBold20
    bodyLarge: regular.copyWith(fontSize: .02875.sh), // regular20
    bodyMedium: regular.copyWith(fontSize: .02375.sh), // regular16
    bodySmall: regular.copyWith(fontSize: .02125.sh), // regular14
    labelLarge: semiBold.copyWith(fontSize: .02375.sh), // semiBold16
    labelMedium: medium.copyWith(fontSize: .01875.sh), // medium12
    labelSmall: regular.copyWith(fontSize: .01875.sh) // regular12
  );

}