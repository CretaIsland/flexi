import 'package:flutter/material.dart';



class ContentClipper extends CustomClipper<Rect> {
  ContentClipper({required this.dx, required this.width, required this.height});
  
  final double dx;
  final double width;
  final double height;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(dx, 0.0, width, height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }

}