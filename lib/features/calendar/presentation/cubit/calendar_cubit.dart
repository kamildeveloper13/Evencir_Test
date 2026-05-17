// Cubit
import 'package:evencir_task/core/constants/app_colors.dart';
import 'package:evencir_task/features/calendar/presentation/cubit/calendar_state.dart';
import 'package:evencir_task/features/calendar/presentation/model/calendar_day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingCalendarCubit extends Cubit<TrainingCalendarState> {
  TrainingCalendarCubit() : super(TrainingCalendarInitial());

  Future<void> loadCalendarData() async {
    try {
      emit(TrainingCalendarLoading());
      await Future.delayed(const Duration(milliseconds: 300));

      final weeks = [
        WeekData(
          title: 'Week 2/8',
          range: 'December 8-14',
          total: 'Total: 60min',
          days: [
            DayData(
              day: 'Mon',
              date: 8,
              workout: WorkoutData(
                title: 'Arm Blaster',
                subtitle: '',
                badgeLabel: 'Arms Workout',
                badgeColor: AppColors.accentGreen,
                badgeIcon: Icons.fitness_center,
              ),
            ),
            DayData(day: 'Tue', date: 9),
            DayData(day: 'Wed', date: 10),
            DayData(
              day: 'Thu',
              date: 11,
              workout: WorkoutData(
                title: 'Leg Day Blitz',
                subtitle: '',
                badgeLabel: 'Leg Workout',
                badgeColor: AppColors.accentBlue,
                badgeIcon: Icons.directions_run,
              ),
            ),
            DayData(day: 'Fri', date: 12),
            DayData(day: 'Sat', date: 13),
            DayData(day: 'Sun', date: 14),
          ],
        ),
        WeekData(
          title: 'Week 3',
          range: 'December 15-21',
          total: '',
          days: [
            DayData(day: 'Mon', date: 15),
            DayData(day: 'Tue', date: 16),
            DayData(day: 'Wed', date: 17),
            DayData(day: 'Thu', date: 18),
            DayData(day: 'Fri', date: 19),
            DayData(day: 'Sat', date: 20),
            DayData(day: 'Sun', date: 21),
          ],
        ),
        WeekData(
          title: 'Week 4',
          range: 'December 22-28',
          total: '',
          days: [
            DayData(day: 'Mon', date: 22),
            DayData(day: 'Tue', date: 23),
            DayData(day: 'Wed', date: 24),
            DayData(day: 'Thu', date: 25),
            DayData(day: 'Fri', date: 26),
            DayData(day: 'Sat', date: 27),
            DayData(day: 'Sun', date: 28),
          ],
        ),
      ];

      emit(TrainingCalendarLoaded(weeks: weeks));
    } catch (e) {
      emit(TrainingCalendarError('Failed to load calendar: $e'));
    }
  }

  void saveCalendar() {
    // Save logic here
    print('Calendar saved');
  }
}
