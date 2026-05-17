import 'package:evencir_task/features/calendar/presentation/widgets/work_out_event_tile.dart';

abstract class NutritionState {}

class NutritionInitial extends NutritionState {}

class NutritionLoading extends NutritionState {}

class NutritionLoaded extends NutritionState {
  final List<WeekDayData> weekDays;
  final String selectedDate;
  final String temperature;
  final String workoutTitle;
  final String workoutSubtitle;
  final int calories;
  final double weight;
  final int hydration;

  NutritionLoaded({
    required this.weekDays,
    required this.selectedDate,
    required this.temperature,
    required this.workoutTitle,
    required this.workoutSubtitle,
    required this.calories,
    required this.weight,
    required this.hydration,
  });

  // Initial data (default values)
  factory NutritionLoaded.initial() {
    return NutritionLoaded(
      weekDays: [],
      selectedDate: 'Today, 22 Dec 2024',
      temperature: '9°',
      workoutTitle: 'Upper Body',
      workoutSubtitle: 'December 22 - 25m - 30m',
      calories: 0,
      weight: 0.0,
      hydration: 0,
    );
  }
}

class NutritionError extends NutritionState {
  final String message;
  NutritionError(this.message);
}
