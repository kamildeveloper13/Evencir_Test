import 'package:evencir_task/features/bottom_navigation/presentation/cubit/navigation_cubit.dart';
import 'package:evencir_task/features/bottom_navigation/presentation/pages/main_screen.dart';
import 'package:evencir_task/features/home/presentation/cubit/home_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/calendar/presentation/cubit/calendar_cubit.dart';
import 'features/mood/presentation/cubit/mood_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MoodCubit()),
        BlocProvider(create: (_) => NutritionCubit()),
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => TrainingCalendarCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Evencir Task',
            theme: ThemeData.dark(),
            home: const MainShell(),
          );
        },
      ),
    );
  }
}
