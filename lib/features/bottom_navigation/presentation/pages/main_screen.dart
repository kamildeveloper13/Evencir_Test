import 'package:evencir_task/features/bottom_navigation/presentation/cubit/navigation_cubit.dart';
import 'package:evencir_task/features/bottom_navigation/presentation/widgets/bottom_nav_items.dart';
import 'package:evencir_task/features/calendar/presentation/pages/calendar_screen.dart';
import 'package:evencir_task/features/profile/presentation/pages/profile_screen.dart';
import 'package:evencir_task/features/calendar/presentation/widgets/monthly_calendar.dart';
import 'package:evencir_task/features/home/presentation/pages/home_screen.dart';
import 'package:evencir_task/features/mood/presentation/pages/mood_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  void _showCalendar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black54,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(ctx).size.height * 0.32),
        child: const MonthCalendarSheet(monthLabel: 'Sep 2024'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, BottomNavItem>(
        builder: (context, currentTab) {
          return Scaffold(
            backgroundColor: const Color(0xFF0A0E1A),
            body: IndexedStack(
              index: currentTab.index,
              children: [
                NutritionScreen(onCalendarTap: () => _showCalendar(context)),
                const TrainingCalendarScreen(),
                const MoodScreen(),
                const ProfileScreen(),
              ],
            ),
            bottomNavigationBar: const CustomBottomNavBar(),
          );
        },
      ),
    );
  }
}
