// lib/features/mood/presentation/widgets/mood_picker.dart
import 'dart:math' as math;
import 'package:evencir_task/core/constants/app_colors.dart';
import 'package:evencir_task/features/mood/presentation/cubit/mood_state.dart';
import 'package:evencir_task/features/mood/presentation/widgets/mood_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/mood_cubit.dart';

class MoodPicker extends StatefulWidget {
  const MoodPicker({super.key, this.initialIndex = 0, this.onChanged});

  final int initialIndex;
  final ValueChanged<int>? onChanged;

  @override
  State<MoodPicker> createState() => _MoodPickerState();
}

class _MoodPickerState extends State<MoodPicker> {
  static const _segments = 12;
  double _angle = 0.0;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex.clamp(0, _segments - 1);
    _angle = _indexToAngle(_index);
  }

  @override
  void didUpdateWidget(MoodPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIndex != widget.initialIndex) {
      _index = widget.initialIndex.clamp(0, _segments - 1);
      _angle = _indexToAngle(_index);
      setState(() {});
    }
  }

  double _indexToAngle(int i) => -math.pi / 2 + (i / _segments) * 2 * math.pi;

  int _angleToIndex(double angle) {
    var normalized = (angle + math.pi / 2) % (2 * math.pi);
    if (normalized < 0) normalized += 2 * math.pi;
    return ((normalized / (2 * math.pi)) * _segments).round() % _segments;
  }

  void _updateFromAngle(double angle) {
    final snapped = _angleToIndex(angle);
    final snappedAngle = _indexToAngle(snapped);
    setState(() {
      _angle = snappedAngle;
      _index = snapped;
    });
    widget.onChanged?.call(_index);
  }

  void _onPan(Offset local, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final delta = local - center;
    _updateFromAngle(math.atan2(delta.dy, delta.dx));
  }

  @override
  Widget build(BuildContext context) {
    final moodState = context.watch<MoodCubit>().state;
    final moodData = moodState is MoodLoaded
        ? moodState.moodData
        : MoodData.all[_index];

    if (moodState is MoodLoaded && _index != moodState.selectedMoodIndex) {
      _index = moodState.selectedMoodIndex;
      _angle = _indexToAngle(_index);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final side = math.min(constraints.maxWidth, 320.w);
        final size = Size.square(side);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onPanUpdate: (d) => _onPan(d.localPosition, size),
              onTapDown: (d) => _onPan(d.localPosition, size),
              child: SizedBox(
                width: side,
                height: side,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(size: size, painter: _MoodRingPainter()),
                    MoodFace(
                      expression: moodData.expression,
                      color: moodData.faceColor,
                      size: side * 0.38,
                    ),
                    _Handle(angle: _angle, size: side),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              moodData.label,
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Handle extends StatelessWidget {
  const _Handle({required this.angle, required this.size});

  final double angle;
  final double size;

  @override
  Widget build(BuildContext context) {
    final radius = size * 0.42;
    final center = size / 2;
    final handleSize = size * 0.11;
    final x = center + radius * math.cos(angle) - handleSize / 2;
    final y = center + radius * math.sin(angle) - handleSize / 2;

    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: handleSize,
        height: handleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFE8F7F5),
          boxShadow: [
            BoxShadow(
              color: AppColors.handleShadow,
              blurRadius: handleSize * 0.35,
              offset: Offset(0, handleSize * 0.12),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outer = size.width * 0.48;
    final inner = size.width * 0.36;
    final rect = Rect.fromCircle(center: center, radius: outer);

    final ringPaint = Paint()
      ..shader = const SweepGradient(
        startAngle: -math.pi / 2,
        colors: [
          AppColors.moodOrange,
          AppColors.moodTeal,
          AppColors.moodPurple,
          AppColors.moodPink,
          AppColors.moodOrange,
        ],
        stops: [0.0, 0.25, 0.5, 0.75, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = outer - inner
      ..strokeCap = StrokeCap.butt;

    canvas.drawCircle(center, (outer + inner) / 2, ringPaint);

    final divider = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..strokeWidth = 1;

    for (var i = 0; i < 12; i++) {
      final a = -math.pi / 2 + i * math.pi / 6;
      final p1 = center + Offset(inner * math.cos(a), inner * math.sin(a));
      final p2 = center + Offset(outer * math.cos(a), outer * math.sin(a));
      canvas.drawLine(p1, p2, divider);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
