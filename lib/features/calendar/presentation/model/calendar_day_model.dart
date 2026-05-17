import 'package:flutter/material.dart';

class WeekData {
  final String title;
  final String range;
  final String total;
  final List<DayData> days;

  WeekData({
    required this.title,
    required this.range,
    required this.total,
    required this.days,
  });
}

class DayData {
  final String day;
  final int date;
  final WorkoutData? workout;

  DayData({required this.day, required this.date, this.workout});
}

class WorkoutData {
  final String title;
  final String subtitle;
  final String badgeLabel;
  final Color badgeColor;
  final IconData badgeIcon;

  WorkoutData({
    required this.title,
    required this.subtitle,
    required this.badgeLabel,
    required this.badgeColor,
    required this.badgeIcon,
  });
}
