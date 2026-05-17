import 'package:evencir_task/features/calendar/presentation/model/calendar_day_model.dart';

abstract class TrainingCalendarState {}

class TrainingCalendarInitial extends TrainingCalendarState {}

class TrainingCalendarLoading extends TrainingCalendarState {}

class TrainingCalendarLoaded extends TrainingCalendarState {
  final List<WeekData> weeks;
  final int selectedWeekIndex;

  TrainingCalendarLoaded({required this.weeks, this.selectedWeekIndex = 0});

  factory TrainingCalendarLoaded.initial() {
    return TrainingCalendarLoaded(weeks: []);
  }

  TrainingCalendarLoaded copyWith({
    List<WeekData>? weeks,
    int? selectedWeekIndex,
  }) {
    return TrainingCalendarLoaded(
      weeks: weeks ?? this.weeks,
      selectedWeekIndex: selectedWeekIndex ?? this.selectedWeekIndex,
    );
  }
}

class TrainingCalendarError extends TrainingCalendarState {
  final String message;
  TrainingCalendarError(this.message);
}
