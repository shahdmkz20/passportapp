import 'package:flutter/material.dart';

class Clip3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, 0);

    path0.quadraticBezierTo(size.width, size.height * 0.6000000, size.width,
        size.height * 0.8000000);
    path0.cubicTo(
        size.width * 0.5000000,
        size.height * 0.9975000,
        size.width * 0.5000000,
        size.height * 0.4985000,
        0,
        size.height * 0.7980000);
    path0.quadraticBezierTo(0, size.height * 0.5985000, 0, 0);
    path0.lineTo(0, 0);

    path0.close();
    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}