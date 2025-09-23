import 'dart:ui';

import 'package:flutter/material.dart';

class DottedRectanglePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  DottedRectanglePainter({
    this.color = Colors.black,
    this.strokeWidth = 2.0,
    this.dashLength = 5.0,
    this.gapLength = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final dashPath = Path();
    for (PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0;
      while (distance < pathMetric.length) {
        final double next = distance + dashLength;
        dashPath.addPath(
          pathMetric.extractPath(distance, next.clamp(0, pathMetric.length)),
          Offset.zero,
        );
        distance = next + gapLength;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
