import 'dart:ui';

import 'package:flutter/material.dart';

class DrawCircle extends CustomPainter {

  DrawCircle({
    required this.radius,
    required this.offset,
    required this.color,
    this.elevation = 8,
    this.transparentOccluder = true,
    this.shadowColor,
    this.hasShadow = false,
    this.shadowOffset = 1,
  }) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  final double radius;
  final Offset offset;
  final Color color;
  var elevation;
  var transparentOccluder;
  var hasShadow;
  var shadowColor;
  var shadowOffset;
  late Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    if (hasShadow) {
      Path oval = Path()
        ..addOval(
            Rect.fromCircle(center: offset, radius: radius + shadowOffset));

      canvas.drawShadow(
        oval,
        shadowColor ?? Colors.black.withOpacity(0.7),
        elevation,
        transparentOccluder,
      );
    }

    canvas.drawCircle(offset, radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
