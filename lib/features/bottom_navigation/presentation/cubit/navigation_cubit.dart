// lib/features/home/presentation/cubit/navigation_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottom_nav_items.dart';
// import 'package:evencir_task/features/core/presentation/widgets/bottom_nav_item.dart';

class NavigationCubit extends Cubit<BottomNavItem> {
  NavigationCubit() : super(BottomNavItem.home);

  void selectItem(BottomNavItem item) {
    if (state != item) {
      emit(item);
    }
  }
}
