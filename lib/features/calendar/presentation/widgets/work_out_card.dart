import 'package:evencir_task/Icons/app_icons.dart';
import 'package:evencir_task/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    super.key,
    required this.subtitle,
    required this.title,
    this.accentColor = AppColors.accentTeal,
    this.onTap,
    this.showDragHandle = false,
    this.badge,
  });

  final String subtitle;
  final String title;
  final Color accentColor;
  final VoidCallback? onTap;
  final bool showDragHandle;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Container(
              width: 4.w,
              height: 72.h,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(14.r),
                ),
              ),
            ),
            if (showDragHandle) ...[SizedBox(width: 8.w), _DragHandle()],
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (badge != null) ...[badge!, SizedBox(height: 6.h)],
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (!showDragHandle)
                          AppIcon(
                            icon: AppIconType.chevronRight,
                            size: 18.w,
                            color: AppColors.secondaryText,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (showDragHandle)
              Padding(
                padding: EdgeInsets.only(right: 14.w),
                child: Text(
                  '25m - 30m',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12.sp,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (_) => Row(
          children: List.generate(
            2,
            (_) => Container(
              width: 3.w,
              height: 3.w,
              margin: EdgeInsets.all(1.5.w),
              decoration: const BoxDecoration(
                color: AppColors.secondaryText,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WorkoutBadge extends StatelessWidget {
  const WorkoutBadge({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.w, color: color),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
