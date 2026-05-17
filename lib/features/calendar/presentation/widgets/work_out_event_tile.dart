import 'package:evencir_task/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeekDayData {
  const WeekDayData({
    required this.label,
    required this.date,
    this.selected = false,
    this.dotColor,
  });

  final String label;
  final int date;
  final bool selected;
  final Color? dotColor;
}

class WeekCalendarStrip extends StatelessWidget {
  const WeekCalendarStrip({super.key, required this.days, this.onDayTap});

  final List<WeekDayData> days;
  final ValueChanged<int>? onDayTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, i) {
          final day = days[i];
          return GestureDetector(
            onTap: () => onDayTap?.call(i),
            child: _DayCell(day: day),
          );
        },
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({required this.day});

  final WeekDayData day;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            day.label,
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10.sp),
          ),
          SizedBox(height: 6.h),
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: day.selected
                  ? Border.all(color: AppColors.accentGreen, width: 1.5)
                  : null,
              color: day.selected ? AppColors.card : Colors.transparent,
            ),
            alignment: Alignment.center,
            child: Text(
              '${day.date}',
              style: TextStyle(
                color: day.selected
                    ? AppColors.primaryText
                    : AppColors.secondaryText,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: 5.w,
            height: 5.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: day.dotColor ?? Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
