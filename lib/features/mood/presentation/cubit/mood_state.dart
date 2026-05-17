// lib/features/mood/presentation/cubit/mood_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evencir_task/features/mood/presentation/widgets/mood_circle.dart';

// States
abstract class MoodState {}

class MoodInitial extends MoodState {}

class MoodLoading extends MoodState {}

class MoodLoaded extends MoodState {
  final int selectedMoodIndex;
  final MoodData moodData;

  MoodLoaded({required this.selectedMoodIndex, required this.moodData});

  // Initial state with default values
  factory MoodLoaded.initial() {
    return MoodLoaded(selectedMoodIndex: 0, moodData: MoodData.all[0]);
  }

  MoodLoaded copyWith({int? selectedMoodIndex, MoodData? moodData}) {
    return MoodLoaded(
      selectedMoodIndex: selectedMoodIndex ?? this.selectedMoodIndex,
      moodData: moodData ?? this.moodData,
    );
  }
}

class MoodError extends MoodState {
  final String message;
  MoodError(this.message);
}

//
