import 'dart:math' as math;

import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.icon,
    this.size = 24,
    this.color = Colors.white,
    this.strokeWidth = 1.8,
  });

  final AppIconType icon;
  final double size;
  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _AppIconPainter(icon, color, strokeWidth),
    );
  }
}

enum AppIconType {
  nutrition,
  plan,
  mood,
  profile,
  bell,
  clock,
  chevronRight,
  chevronDown,
  sun,
  moon,
}

class _AppIconPainter extends CustomPainter {
  _AppIconPainter(this.type, this.color, this.stroke);

  final AppIconType type;
  final Color color;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke * size.width / 24
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final s = size.width;
    final c = Offset(s / 2, s / 2);

    switch (type) {
      case AppIconType.nutrition:
        _nutrition(canvas, paint, s);
      case AppIconType.plan:
        _plan(canvas, paint, s);
      case AppIconType.mood:
        _mood(canvas, paint, s);
      case AppIconType.profile:
        _profile(canvas, paint, s);
      case AppIconType.bell:
        _bell(canvas, paint, s);
      case AppIconType.clock:
        _clock(canvas, paint, s, c);
      case AppIconType.chevronRight:
        _chevron(canvas, paint, s, right: true);
      case AppIconType.chevronDown:
        _chevron(canvas, paint, s, right: false);
      case AppIconType.sun:
        _sun(canvas, paint, s, c);
      case AppIconType.moon:
        _moon(canvas, paint, s);
    }
  }

  void _nutrition(Canvas canvas, Paint paint, double s) {
    final bowl = Path()
      ..moveTo(s * 0.22, s * 0.62)
      ..quadraticBezierTo(s * 0.5, s * 0.88, s * 0.78, s * 0.62);
    canvas.drawPath(bowl, paint);
    canvas.drawLine(
      Offset(s * 0.18, s * 0.62),
      Offset(s * 0.82, s * 0.62),
      paint,
    );
    canvas.drawLine(
      Offset(s * 0.28, s * 0.28),
      Offset(s * 0.58, s * 0.52),
      paint,
    );
    final leaf = Path()
      ..moveTo(s * 0.48, s * 0.36)
      ..quadraticBezierTo(s * 0.62, s * 0.28, s * 0.58, s * 0.48)
      ..quadraticBezierTo(s * 0.48, s * 0.52, s * 0.48, s * 0.36);
    canvas.drawPath(leaf, paint);
  }

  void _plan(Canvas canvas, Paint paint, double s) {
    final r = RRect.fromRectAndRadius(
      Rect.fromLTWH(s * 0.18, s * 0.22, s * 0.64, s * 0.62),
      Radius.circular(s * 0.12),
    );
    canvas.drawRRect(r, paint);
    canvas.drawLine(
      Offset(s * 0.18, s * 0.38),
      Offset(s * 0.82, s * 0.38),
      paint,
    );
    canvas.drawLine(
      Offset(s * 0.32, s * 0.22),
      Offset(s * 0.32, s * 0.16),
      paint,
    );
    canvas.drawLine(
      Offset(s * 0.68, s * 0.22),
      Offset(s * 0.68, s * 0.16),
      paint,
    );
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    for (var row = 0; row < 2; row++) {
      final count = row == 0 ? 4 : 3;
      for (var col = 0; col < count; col++) {
        canvas.drawCircle(
          Offset(s * (0.3 + col * 0.14), s * (0.5 + row * 0.14)),
          s * 0.028,
          dotPaint,
        );
      }
    }
  }

  void _mood(Canvas canvas, Paint paint, double s) {
    canvas.drawCircle(Offset(s / 2, s / 2), s * 0.38, paint);
    final starPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    _star(canvas, starPaint, Offset(s * 0.36, s * 0.4), s * 0.1);
    _star(canvas, starPaint, Offset(s * 0.64, s * 0.4), s * 0.1);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(s / 2, s * 0.58),
        width: s * 0.3,
        height: s * 0.16,
      ),
      0.1,
      3.0,
      false,
      paint..strokeWidth = paint.strokeWidth * 1.1,
    );
  }

  void _star(Canvas canvas, Paint paint, Offset center, double r) {
    final path = Path();
    for (var i = 0; i < 5; i++) {
      final angle = -math.pi / 2 + i * 4 * math.pi / 5;
      final point =
          center + Offset(r * 0.9 * math.cos(angle), r * 0.9 * math.sin(angle));
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
      final inner =
          center +
          Offset(
            r * 0.38 * math.cos(angle + math.pi / 5),
            r * 0.38 * math.sin(angle + math.pi / 5),
          );
      path.lineTo(inner.dx, inner.dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _profile(Canvas canvas, Paint paint, double s) {
    canvas.drawCircle(Offset(s / 2, s * 0.36), s * 0.14, paint);
    final shoulders = Path()
      ..moveTo(s * 0.22, s * 0.78)
      ..quadraticBezierTo(s * 0.22, s * 0.58, s * 0.5, s * 0.58)
      ..quadraticBezierTo(s * 0.78, s * 0.58, s * 0.78, s * 0.78);
    canvas.drawPath(shoulders, paint);
  }

  void _bell(Canvas canvas, Paint paint, double s) {
    final body = Path()
      ..moveTo(s * 0.5, s * 0.18)
      ..quadraticBezierTo(s * 0.78, s * 0.42, s * 0.72, s * 0.62)
      ..lineTo(s * 0.28, s * 0.62)
      ..quadraticBezierTo(s * 0.22, s * 0.42, s * 0.5, s * 0.18);
    canvas.drawPath(body, paint);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(s / 2, s * 0.72),
        width: s * 0.2,
        height: s * 0.1,
      ),
      0,
      math.pi,
      false,
      paint,
    );
  }

  void _clock(Canvas canvas, Paint paint, double s, Offset c) {
    canvas.drawCircle(c, s * 0.38, paint);
    canvas.drawLine(c, Offset(c.dx, c.dy - s * 0.22), paint);
    canvas.drawLine(c, Offset(c.dx + s * 0.18, c.dy), paint);
  }

  void _chevron(Canvas canvas, Paint paint, double s, {required bool right}) {
    final path = Path();
    if (right) {
      path
        ..moveTo(s * 0.36, s * 0.28)
        ..lineTo(s * 0.62, s * 0.5)
        ..lineTo(s * 0.36, s * 0.72);
    } else {
      path
        ..moveTo(s * 0.28, s * 0.36)
        ..lineTo(s * 0.5, s * 0.62)
        ..lineTo(s * 0.72, s * 0.36);
    }
    canvas.drawPath(path, paint);
  }

  void _sun(Canvas canvas, Paint paint, double s, Offset c) {
    canvas.drawCircle(c, s * 0.18, paint);
    for (var i = 0; i < 8; i++) {
      final a = i * math.pi / 4;
      final inner = c + Offset(s * 0.26 * math.cos(a), s * 0.26 * math.sin(a));
      final outer = c + Offset(s * 0.36 * math.cos(a), s * 0.36 * math.sin(a));
      canvas.drawLine(inner, outer, paint);
    }
  }

  void _moon(Canvas canvas, Paint paint, double s) {
    canvas.drawArc(
      Rect.fromCircle(center: Offset(s * 0.5, s * 0.5), radius: s * 0.28),
      0.5,
      4.5,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
