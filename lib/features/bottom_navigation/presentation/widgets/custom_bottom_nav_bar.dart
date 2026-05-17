// lib/features/core/presentation/widgets/custom_bottom_nav_bar.dart
import 'package:evencir_task/core/constants/app_colors.dart';
import 'package:evencir_task/features/bottom_navigation/presentation/widgets/bottom_nav_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/navigation_cubit.dart';
// import 'package:evencir_task/features/home/presentation/cubit/navigation_cubit.dart';

class CustomBottomNavBar extends StatelessWidget {
  final AnimationController? animationController;

  const CustomBottomNavBar({super.key, this.animationController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, top: 5).r,
            child: Container(
              height: 1.h,
              width: double.infinity,
              color: AppColors.navInactive,
            ),
          ),
          SafeArea(
            child: BlocBuilder<NavigationCubit, BottomNavItem>(
              builder: (context, selectedItem) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: BottomNavItem.values.map((item) {
                    final isSelected = selectedItem == item;
                    return _buildNavItem(
                      context: context,
                      item: item,
                      isSelected: isSelected,
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required BottomNavItem item,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => context.read<NavigationCubit>().selectItem(item),
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isSelected ? item.activeIconPath : item.iconPath,
              width: isSelected ? 26 : 24,
              height: isSelected ? 26 : 24,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            const SizedBox(height: 6),
            Text(
              item.label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
