import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  final radius = 10.0;
  final arcHeight = 50.0;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..cubicTo(
        size.width - 45,
        size.height - 30,
        size.width - 25,
        0,
        size.width - 60,
        0,
      )
      ..lineTo(size.width - 60, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
