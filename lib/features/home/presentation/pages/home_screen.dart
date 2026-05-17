import 'package:evencir_task/Icons/app_icons.dart';
import 'package:evencir_task/core/constants/app_colors.dart';
import 'package:evencir_task/features/calendar/presentation/widgets/work_out_card.dart';
import 'package:evencir_task/features/calendar/presentation/widgets/work_out_event_tile.dart';
import 'package:evencir_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:evencir_task/features/home/presentation/cubit/home_state.dart';
import 'package:evencir_task/features/home/presentation/widgets/insight_card.dart';
import 'package:evencir_task/features/home/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key, this.onCalendarTap});

  final VoidCallback? onCalendarTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NutritionCubit()..loadData(),
      child: BlocBuilder<NutritionCubit, NutritionState>(
        builder: (context, state) {
          if (state is NutritionLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NutritionError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: TextStyle(color: Colors.red, fontSize: 16.sp),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NutritionCubit>().loadData();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is NutritionLoaded) {
            return _buildContent(context, state);
          }

          return _buildContent(context, NutritionLoaded.initial());
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, NutritionLoaded state) {
    final weekDays = state.weekDays.isNotEmpty
        ? state.weekDays
        : [
            WeekDayData(label: 'M', date: 21),
            WeekDayData(
              label: 'TU',
              date: 22,
              selected: true,
              dotColor: AppColors.accentGreen,
            ),
            WeekDayData(label: 'W', date: 23, dotColor: AppColors.primaryText),
            WeekDayData(label: 'TH', date: 24, dotColor: AppColors.accentTeal),
            WeekDayData(label: 'F', date: 25),
            WeekDayData(label: 'SA', date: 26, dotColor: Colors.redAccent),
            WeekDayData(label: 'SU', date: 27),
          ];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          _TopBar(onCalendarTap: onCalendarTap),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: onCalendarTap,
            child: Text(
              state.selectedDate,
              style: TextStyle(color: AppColors.primaryText, fontSize: 15.sp),
            ),
          ),
          SizedBox(height: 16.h),
          WeekCalendarStrip(days: weekDays),
          SizedBox(height: 8.h),
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.secondaryText.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          SectionHeader(
            title: 'Workouts',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(
                  icon: AppIconType.sun,
                  size: 20.w,
                  color: AppColors.primaryText,
                ),
                SizedBox(width: 4.w),
                Text(
                  state.temperature,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          WorkoutCard(
            subtitle: state.workoutSubtitle,
            title: state.workoutTitle,
          ),
          SizedBox(height: 28.h),
          const SectionHeader(title: 'My Insights'),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: CaloriesCard(calories: state.calories)),
              SizedBox(width: 12.w),
              Expanded(child: WeightCard(weight: state.weight)),
            ],
          ),
          SizedBox(height: 12.h),
          HydrationCard(hydration: state.hydration),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({this.onCalendarTap});

  final VoidCallback? onCalendarTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Image.asset(
            "assets/icons/notification.png",
            width: 22.w,
            height: 22.w,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIcon(
                  icon: AppIconType.moon,
                  size: 16.w,
                  color: AppColors.secondaryText,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Week 1/4',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4.w),
                AppIcon(
                  icon: AppIconType.clock,
                  size: 14.w,
                  color: AppColors.secondaryText,
                ),
                SizedBox(width: 2.w),
                AppIcon(
                  icon: AppIconType.chevronDown,
                  size: 14.w,
                  color: AppColors.secondaryText,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onCalendarTap,
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: AppColors.accentBlue,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                'K',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
