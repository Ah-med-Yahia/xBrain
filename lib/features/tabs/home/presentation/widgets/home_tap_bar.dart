import 'package:explaino/core/constants/home_tap_bar_list.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/home/presentation/cubit/home_cubit.dart';
import 'package:explaino/features/tabs/home/presentation/cubit/home_intents.dart';
import 'package:explaino/features/tabs/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, next) =>
          prev.questionTapActive != next.questionTapActive ||
          prev.postsTapActive != next.postsTapActive,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TabItem(
              label: tabs[0],
              isSelected: state.questionTapActive,
              onTap: () {
                context.read<HomeCubit>().doIntent(ToQuestionsTapIntent());
              },
              margin: const EdgeInsets.only(right: 10),
            ),
            _TabItem(
              label: tabs[1],
              isSelected: state.postsTapActive,
              onTap: () {
                context.read<HomeCubit>().doIntent(ToPostsTapIntent());
              },
              margin: const EdgeInsets.only(left: 10),
            ),
          ],
        );
      },
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final EdgeInsets margin;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: margin,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.lightInputFill,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? AppColors.white : AppColors.lightTextSecondary,
          ),
        ),
      ),
    );
  }
}
