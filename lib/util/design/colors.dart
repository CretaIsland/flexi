import 'package:flutter/material.dart';



class FlexiColor {

  static Color primary = const Color(0xff495DDD);
  static Color secondary = const Color(0xffF77F59);
  static MaterialColor grey = const MaterialColor(
    0xffF2F2F6, 
    <int, Color> {
      100: Color(0xffF7F7F7),
      200: Color(0xffF2F2F6),
      300: Color(0xffEAEAEA),
      400: Color(0xffE3E3E8),
      500: Color(0xffD9D9D9),
      600: Color(0xffAEAEAE),
      700: Color(0xff7F7F85),
    }
  );
  static Color backgroundColor = grey[200]!;
  
}