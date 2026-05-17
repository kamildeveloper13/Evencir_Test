import 'package:evencir_task/core/constants/app_colors.dart';
import 'package:evencir_task/features/calendar/presentation/cubit/calendar_cubit.dart';
import 'package:evencir_task/features/calendar/presentation/cubit/calendar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/work_out_card.dart';

class TrainingCalendarScreen extends StatelessWidget {
  const TrainingCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrainingCalendarCubit()..loadCalendarData(),
      child: BlocBuilder<TrainingCalendarCubit, TrainingCalendarState>(
        builder: (context, state) {
          if (state is TrainingCalendarLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TrainingCalendarError) {
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
                      context.read<TrainingCalendarCubit>().loadCalendarData();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is TrainingCalendarLoaded) {
            return _buildContent(context, state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, TrainingCalendarLoaded state) {
    final weeks = state.weeks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 0),
          child: Row(
            children: [
              Text(
                'Training Calendar',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.read<TrainingCalendarCubit>().saveCalendar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Calendar saved!')),
                  );
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 12.h),
          height: 1,
          color: AppColors.dividerBlue,
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: weeks.length,
            itemBuilder: (context, index) {
              final week = weeks[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index > 0) ...[
                    SizedBox(height: 20.h),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.h),
                      height: 1,
                      color: AppColors.accentTeal.withValues(alpha: 0.5),
                    ),
                  ],
                  SizedBox(height: 20.h),
                  _WeekHeader(
                    title: week.title,
                    range: week.range,
                    total: week.total,
                  ),
                  SizedBox(height: 16.h),
                  ...week.days.map(
                    (day) => _DayRow(
                      day: day.day,
                      date: day.date,
                      child: day.workout != null
                          ? WorkoutCard(
                              showDragHandle: true,
                              subtitle: day.workout!.subtitle,
                              title: day.workout!.title,
                              accentColor: Colors.white,
                              badge: WorkoutBadge(
                                label: day.workout!.badgeLabel,
                                color: day.workout!.badgeColor,
                                icon: day.workout!.badgeIcon,
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _WeekHeader extends StatelessWidget {
  const _WeekHeader({
    required this.title,
    required this.range,
    required this.total,
  });

  final String title;
  final String range;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                range,
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
        if (total.isNotEmpty)
          Text(
            total,
            style: TextStyle(color: AppColors.secondaryText, fontSize: 13.sp),
          ),
      ],
    );
  }
}

class _DayRow extends StatelessWidget {
  const _DayRow({required this.day, required this.date, this.child});

  final String day;
  final int date;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 44.w,
            child: Column(
              children: [
                Text(
                  day,
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  '$date',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          if (child != null) Expanded(child: child!),
        ],
      ),
    );
  }
}
