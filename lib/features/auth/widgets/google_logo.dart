import 'dart:math' as math;

import 'package:flutter/material.dart';

//* Google "G" logo drawn with its brand colors, no asset needed
class GoogleLogo extends StatelessWidget {
  final double size;
  const GoogleLogo({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  static const _blue = Color(0xFF4285F4);
  static const _green = Color(0xFF34A853);
  static const _yellow = Color(0xFFFBBC05);
  static const _red = Color(0xFFEA4335);

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width * 0.2;
    final center = size.center(Offset.zero);
    final radius = (size.width - stroke) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    Paint paintFor(Color color) => Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    double rad(double degrees) => degrees * math.pi / 180;

    //* Ring segments, clockwise from the right edge, leaving the upper right open
    canvas.drawArc(rect, rad(0), rad(50), false, paintFor(_blue));
    canvas.drawArc(rect, rad(50), rad(90), false, paintFor(_green));
    canvas.drawArc(rect, rad(140), rad(80), false, paintFor(_yellow));
    canvas.drawArc(rect, rad(220), rad(100), false, paintFor(_red));

    //* Horizontal bar of the G
    canvas.drawRect(
      Rect.fromLTRB(center.dx, center.dy - stroke / 2, center.dx + radius + stroke / 2, center.dy + stroke / 2),
      Paint()..color = _blue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
