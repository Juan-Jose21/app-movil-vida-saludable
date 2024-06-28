import 'dart:math' as math;
import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  final double percentage;
  final Color backgroundColor;
  final Color foregroundColor;
  final double strokeWidth;
  final double radius;

  CircularProgressBar({
    required this.percentage,
    this.backgroundColor = Colors.black54,
    this.foregroundColor = Colors.indigo,
    this.strokeWidth = 3.0,
    this.radius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(radius * 2, radius * 2),
          painter: _CircularProgressBarPainter(
            percentage: percentage,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            strokeWidth: strokeWidth,
          ),
        ),
        Center(
          child: Text(
            '${percentage.toStringAsFixed(0)}%',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _CircularProgressBarPainter extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Color foregroundColor;
  final double strokeWidth;

  _CircularProgressBarPainter({
    required this.percentage,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double halfWidth = size.width / 2;
    final double halfHeight = size.height / 2;
    final double startAngle = -math.pi / 2;
    final double sweepAngle = 2 * math.pi * (percentage / 100);

    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Paint foregroundPaint = Paint()
      ..color = foregroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(Offset(halfWidth, halfHeight), halfWidth - strokeWidth / 2, backgroundPaint);
    canvas.drawArc(Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2, size.width - strokeWidth, size.height - strokeWidth), startAngle, sweepAngle, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(_CircularProgressBarPainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.foregroundColor != foregroundColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
