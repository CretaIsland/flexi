
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


  // regular
  static TextStyle regular12 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: regular,
    fontSize: screenHeight * .0175,
    color: Colors.black
  );
  
  static TextStyle regular16 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: regular,
    fontSize: screenHeight * .02375,
    color: Colors.black
  );

  static TextStyle regular20 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: regular,
    fontSize: screenHeight * .0575,
    color: Colors.black
  );


  // medium
  static TextStyle medium12 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: medium,
    fontSize: screenHeight * .015,
    color: Colors.black
  );


  // semiBold
  static TextStyle semiBold16 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: semiBold,
    fontSize: screenHeight * .02375,
    color: Colors.black
  );

  static TextStyle semiBold20 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: semiBold,
    fontSize: screenHeight * .02875,
    color: Colors.black
  );

  static TextStyle semiBold24 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: semiBold,
    fontSize: screenHeight * .035,
    color: Colors.black
  );

  static TextStyle semiBold30 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: semiBold,
    fontSize: screenHeight * .04375,
    color: Colors.black
  );





}
