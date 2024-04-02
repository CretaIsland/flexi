
import 'package:flexi/main.dart';
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


  // display text style
  static TextStyle displayRegular12 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: regular,
    fontSize: screenHeight * .0175,
    color: Colors.black
  );
  
  static TextStyle displayRegular16 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: regular,
    fontSize: screenHeight * .02375,
    color: Colors.black
  );

  static TextStyle displaySemiBold24 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: regular,
    fontSize: screenHeight * .035,
    color: Colors.black
  );


  // button text style
  static TextStyle buttonMedium12 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: medium,
    fontSize: screenHeight * .015,
    color: Colors.black
  );

  static TextStyle buttonSemiBold16 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: semiBold,
    fontSize: screenHeight * .02375,
    color: Colors.black
  );





}
