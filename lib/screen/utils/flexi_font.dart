import 'package:flexi/main.dart';
import 'package:flexi/screen/utils/flexi_color.dart';
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

  
  static TextStyle textFieldRegular = TextStyle(
    fontFamily: fontFamily,
    fontWeight: regular,
    fontSize: screenHeight * .02,
    color: Colors.black
  );

  static TextStyle appBarTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: semiBold,
    fontSize: screenHeight * .025,
    color: Colors.black
  );

  static TextStyle bottomBarButton = TextStyle(
    fontFamily: fontFamily,
    fontWeight: medium,
    fontSize: screenHeight * .0175,
    color: FlexiColor.grey[500]
  );

  static TextStyle textButtonRegular = TextStyle(
    fontFamily: fontFamily,
    fontWeight: regular,
    fontSize: screenHeight * .02,
    color: Colors.black
  );

  // button text style
  static TextStyle textButtonSemibold16 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: semiBold,
    fontSize: screenHeight * .0237,
    color: Colors.black
  );


  // display text style
  static TextStyle displaySemibold20 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: semiBold,
    fontSize: screenHeight * .0437,
    color: Colors.black
  );

  static TextStyle displayRegular14 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: regular,
    fontSize: screenHeight * .02,
    color: Colors.black
  );


  

}