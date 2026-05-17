import 'package:evencir_task/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonthCalendarSheet extends StatelessWidget {
  const MonthCalendarSheet({
    super.key,
    required this.monthLabel,
    this.selectedDay = 2,
    this.onClose,
  });

  final String monthLabel;
  final int selectedDay;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    const weekdays = ['MON', 'TU', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    final days = List.generate(30, (i) => i + 1);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.secondaryText.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chevron_left,
                color: AppColors.secondaryText,
                size: 20.w,
              ),
              SizedBox(width: 16.w),
              Text(
                monthLabel,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 16.w),
              Icon(
                Icons.chevron_right,
                color: AppColors.secondaryText,
                size: 20.w,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: weekdays
                .map(
                  (d) => Expanded(
                    child: Text(
                      d,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 12.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 4,
            ),
            itemCount: days.length,
            itemBuilder: (context, i) {
              final day = days[i];
              final selected = day == selectedDay;
              return Center(
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: selected
                        ? Border.all(color: AppColors.accentGreen, width: 1.5)
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$day',
                    style: TextStyle(
                      color: selected
                          ? AppColors.primaryText
                          : AppColors.secondaryText,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
