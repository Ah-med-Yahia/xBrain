import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.title, required this.number});

  final String number;
  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          number,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.greyScale,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: textTheme.labelMedium?.copyWith(
            color: AppColors.greyScale,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
