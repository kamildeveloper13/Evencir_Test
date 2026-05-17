// lib/features/mood/presentation/pages/mood_screen.dart
import 'package:evencir_task/core/constants/app_colors.dart';
import 'package:evencir_task/features/mood/presentation/cubit/mood_cubit.dart';
import 'package:evencir_task/features/mood/presentation/cubit/mood_state.dart';
import 'package:evencir_task/features/mood/presentation/widgets/mood_circle.dart';
import 'package:evencir_task/features/mood/presentation/widgets/mood_selector.dart';
// import 'package:evencir_task/features/mood/presentation/widgets/mood_picker.dart';
import 'package:evencir_task/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoodCubit(),
      child: BlocBuilder<MoodCubit, MoodState>(
        builder: (context, state) {
          // Loading state
          if (state is MoodLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.accentGreen),
            );
          }

          // Error state
          if (state is MoodError) {
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
                      context.read<MoodCubit>().loadMoods();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentGreen,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Loaded state - Main UI
          if (state is MoodLoaded) {
            return _buildContent(context, state);
          }

          // Default fallback
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, MoodLoaded state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25.h),
          // Title
          Text(
            'Mood',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 34.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Start your day',
            style: TextStyle(color: AppColors.mutedText, fontSize: 15.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            'How are you feeling at the Moment?',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Center(
              child: MoodPicker(
                initialIndex: state.selectedMoodIndex,
                onChanged: (index) {
                  context.read<MoodCubit>().selectMood(index);
                },
              ),
            ),
          ),

          // Continue Button
          PrimaryButton(
            label: 'Continue',
            onPressed: () {
              final selectedMood = state.moodData;
              print(
                'Selected mood: ${selectedMood.label} - ${selectedMood.expression}',
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('You selected: ${selectedMood.label}'),
                  backgroundColor: AppColors.accentGreen,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
