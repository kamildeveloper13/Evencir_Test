// Cubit
import 'package:evencir_task/features/mood/presentation/cubit/mood_state.dart';
import 'package:evencir_task/features/mood/presentation/widgets/mood_circle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoodCubit extends Cubit<MoodState> {
  MoodCubit() : super(MoodLoaded.initial()); // Direct initial state

  // Select mood method
  void selectMood(int index) {
    if (state is MoodLoaded) {
      final currentState = state as MoodLoaded;
      if (currentState.selectedMoodIndex != index) {
        emit(
          currentState.copyWith(
            selectedMoodIndex: index,
            moodData: MoodData.all[index],
          ),
        );
      }
    }
  }

  // Reset to default mood
  void resetMood() {
    emit(MoodLoaded.initial());
  }

  // Load moods (if needed from API)
  Future<void> loadMoods() async {
    try {
      emit(MoodLoading());
      await Future.delayed(const Duration(milliseconds: 300));
      emit(MoodLoaded.initial());
    } catch (e) {
      emit(MoodError('Failed to load moods: $e'));
    }
  }

  // Get current mood data
  MoodData get currentMood {
    if (state is MoodLoaded) {
      return (state as MoodLoaded).moodData;
    }
    return MoodData.all[0];
  }

  // Get current mood index
  int get currentMoodIndex {
    if (state is MoodLoaded) {
      return (state as MoodLoaded).selectedMoodIndex;
    }
    return 0;
  }
}
