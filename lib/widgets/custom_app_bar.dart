import 'package:evencir_task/Icons/app_icons.dart';
import 'package:evencir_task/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum NavTab { nutrition, plan, mood, profile }

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.current,
    required this.onChanged,
  });

  final NavTab current;
  final ValueChanged<NavTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: Color(0xFF2C2C2E), width: 0.5)),
      ),
      padding: EdgeInsets.only(top: 8.h, bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(NavTab.nutrition, 'Nutrition', AppIconType.nutrition),
          _item(NavTab.plan, 'Plan', AppIconType.plan),
          _item(NavTab.mood, 'Mood', AppIconType.mood),
          _item(NavTab.profile, 'Profile', AppIconType.profile),
        ],
      ),
    );
  }

  Widget _item(NavTab tab, String label, AppIconType icon) {
    final active = current == tab;
    final color = active ? AppColors.primaryText : AppColors.navInactive;

    return GestureDetector(
      onTap: () => onChanged(tab),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(icon: icon, size: 24.w, color: color),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11.sp,
                fontWeight: active ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
            SizedBox(height: 6.h),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: active ? 24.w : 0,
              height: 2.h,
              decoration: BoxDecoration(
                color: active ? AppColors.moodPink : Colors.transparent,
                borderRadius: BorderRadius.circular(1.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
