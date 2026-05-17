// lib/features/home/presentation/cubit/nutrition_cubit.dart
import 'package:evencir_task/core/constants/app_colors.dart';
import 'package:evencir_task/features/calendar/presentation/widgets/work_out_event_tile.dart';
import 'package:evencir_task/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NutritionCubit extends Cubit<NutritionState> {
  NutritionCubit() : super(NutritionInitial());

  Future<void> loadData() async {
    try {
      emit(NutritionLoading());

      // Simulate API call or database fetch
      await Future.delayed(const Duration(milliseconds: 500));

      // Load your actual data here
      final weekDays = [
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

      emit(
        NutritionLoaded(
          weekDays: weekDays,
          selectedDate: 'Today, 22 Dec 2024',
          temperature: '9°',
          workoutTitle: 'Upper Body',
          workoutSubtitle: 'December 22 - 25m - 30m',
          calories: 1850,
          weight: 68.5,
          hydration: 6,
        ),
      );
    } catch (e) {
      emit(NutritionError('Failed to load data: $e'));
    }
  }
}
