import 'package:flutter/material.dart';

class BackgroundCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(10, size.height-40, 50, size.height-40);
    path.lineTo(size.width - 50, size.height - 40);
    path.quadraticBezierTo(size.width, size.height - 40, size.width, size.height - 90);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}