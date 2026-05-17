import 'dart:math' as math;

import 'package:evencir_task/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

enum MoodExpression {
  happy,
  calm,
  content,
  peaceful,
  joyful,
  excited,
  energetic,
  focused,
  relaxed,
  grateful,
  loved,
  blissful,
}

class MoodData {
  const MoodData(this.label, this.expression, this.faceColor);

  final String label;
  final MoodExpression expression;
  final Color faceColor;

  static const List<MoodData> all = [
    MoodData('Happy', MoodExpression.happy, AppColors.facePeach),
    MoodData('Calm', MoodExpression.calm, AppColors.faceTan),
    MoodData('Content', MoodExpression.content, AppColors.faceYellow),
    MoodData('Peaceful', MoodExpression.peaceful, AppColors.facePeach),
    MoodData('Joyful', MoodExpression.joyful, AppColors.faceYellow),
    MoodData('Excited', MoodExpression.excited, AppColors.facePeach),
    MoodData('Energetic', MoodExpression.energetic, AppColors.faceYellow),
    MoodData('Focused', MoodExpression.focused, AppColors.faceTan),
    MoodData('Relaxed', MoodExpression.relaxed, AppColors.facePeach),
    MoodData('Grateful', MoodExpression.grateful, AppColors.faceTan),
    MoodData('Loved', MoodExpression.loved, AppColors.faceTan),
    MoodData('Blissful', MoodExpression.blissful, AppColors.faceYellow),
  ];
}

class MoodFace extends StatelessWidget {
  const MoodFace({
    super.key,
    required this.expression,
    required this.color,
    required this.size,
  });

  final MoodExpression expression;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _MoodFacePainter(expression, color),
    );
  }
}

class _MoodFacePainter extends CustomPainter {
  _MoodFacePainter(this.expression, this.color);

  final MoodExpression expression;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final radius = s * 0.28;
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(s / 2, s / 2),
        width: s * 0.72,
        height: s * 0.72,
      ),
      Radius.circular(radius),
    );
    canvas.drawRRect(rect, Paint()..color = color);

    final feature = Paint()
      ..color = AppColors.faceFeature
      ..style = PaintingStyle.stroke
      ..strokeWidth = s * 0.04
      ..strokeCap = StrokeCap.round;

    switch (expression) {
      case MoodExpression.happy:
      case MoodExpression.peaceful:
      case MoodExpression.relaxed:
        _happyEyes(canvas, feature, s);
        _smile(canvas, feature, s, wide: true);
      case MoodExpression.calm:
        _closedEyes(canvas, feature, s);
        _blush(canvas, s);
        _kissMouth(canvas, s);
      case MoodExpression.content:
        _laughEyes(canvas, feature, s);
        _openSmile(canvas, feature, s);
      case MoodExpression.joyful:
      case MoodExpression.blissful:
        _laughEyes(canvas, feature, s);
        _openSmile(canvas, feature, s);
      case MoodExpression.excited:
      case MoodExpression.energetic:
        _ovalEyes(canvas, s);
        _smile(canvas, feature, s, wide: true);
      case MoodExpression.focused:
        _ovalEyes(canvas, s);
        _smile(canvas, feature, s, wide: false);
      case MoodExpression.grateful:
      case MoodExpression.loved:
        _closedEyes(canvas, feature, s);
        _blush(canvas, s);
        _smile(canvas, feature, s, wide: true);
    }
  }

  void _happyEyes(Canvas canvas, Paint paint, double s) {
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(s * 0.35, s * 0.4),
        width: s * 0.14,
        height: s * 0.08,
      ),
      math.pi * 0.15,
      math.pi * 0.7,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(s * 0.65, s * 0.4),
        width: s * 0.14,
        height: s * 0.08,
      ),
      math.pi * 0.15,
      math.pi * 0.7,
      false,
      paint,
    );
  }

  void _closedEyes(Canvas canvas, Paint paint, double s) {
    _happyEyes(canvas, paint, s);
  }

  void _laughEyes(Canvas canvas, Paint paint, double s) {
    for (final x in [0.32, 0.68]) {
      final path = Path()
        ..moveTo(s * (x - 0.06), s * 0.42)
        ..lineTo(s * x, s * 0.36)
        ..lineTo(s * (x + 0.06), s * 0.42);
      canvas.drawPath(path, paint..strokeWidth = s * 0.045);
    }
  }

  void _ovalEyes(Canvas canvas, double s) {
    final paint = Paint()..color = AppColors.faceFeature;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(s * 0.35, s * 0.4),
        width: s * 0.06,
        height: s * 0.1,
      ),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(s * 0.65, s * 0.4),
        width: s * 0.06,
        height: s * 0.1,
      ),
      paint,
    );
  }

  void _smile(Canvas canvas, Paint paint, double s, {required bool wide}) {
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(s / 2, s * 0.56),
        width: wide ? s * 0.32 : s * 0.22,
        height: s * 0.16,
      ),
      0.15,
      math.pi * 0.7,
      false,
      paint,
    );
  }

  void _openSmile(Canvas canvas, Paint paint, double s) {
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(s / 2, s * 0.58),
        width: s * 0.28,
        height: s * 0.2,
      ),
      0,
      math.pi,
      false,
      paint..style = PaintingStyle.stroke,
    );
  }

  void _blush(Canvas canvas, double s) {
    final paint = Paint()..color = AppColors.blush;
    canvas.drawCircle(Offset(s * 0.26, s * 0.5), s * 0.05, paint);
    canvas.drawCircle(Offset(s * 0.74, s * 0.5), s * 0.05, paint);
  }

  void _kissMouth(Canvas canvas, double s) {
    final paint = Paint()..color = AppColors.blush;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(s / 2, s * 0.58),
        width: s * 0.08,
        height: s * 0.06,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _MoodFacePainter old) =>
      old.expression != expression || old.color != color;
}
