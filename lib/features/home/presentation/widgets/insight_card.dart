import 'package:evencir_task/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InsightCard extends StatelessWidget {
  const InsightCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: child,
    );
  }
}

class CaloriesCard extends StatelessWidget {
  final int calories;
  const CaloriesCard({super.key, required this.calories});

  @override
  Widget build(BuildContext context) {
    return InsightCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '550 ',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'Calories',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '1950 Remaining',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 12.sp),
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: 550 / 2500,
              minHeight: 6.h,
              backgroundColor: AppColors.cardElevated,
              valueColor: const AlwaysStoppedAnimation(AppColors.accentTeal),
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 10.sp,
                ),
              ),
              Text(
                '2500',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeightCard extends StatelessWidget {
  final double weight;
  const WeightCard({super.key, required this.weight});

  @override
  Widget build(BuildContext context) {
    return InsightCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '75 ',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'kg',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                decoration: const BoxDecoration(
                  color: AppColors.accentGreen,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_upward,
                  size: 12.w,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                '+1.6kg',
                style: TextStyle(color: AppColors.accentGreen, fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Text(
            'Weight',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}

class HydrationCard extends StatelessWidget {
  final int hydration;
  const HydrationCard({super.key, required this.hydration});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '0%',
                        style: TextStyle(
                          color: AppColors.accentTeal,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Hydration',
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        'Log Now',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '2 L',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10.sp,
                        ),
                      ),
                      Container(
                        width: 40.w,
                        height: 1,
                        color: AppColors.secondaryText.withValues(alpha: 0.3),
                      ),
                      Text(
                        '0 L',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
            color: const Color(0xFF1A3A3A),
            child: Text(
              '500 ml added to water log',
              style: TextStyle(color: AppColors.accentTeal, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}
