import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EmptySlotsHint extends StatelessWidget {
  const EmptySlotsHint({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayishPurple, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        AppTextConstants.noSlotsAddedYet,
        style: textTheme.bodySmall?.copyWith(color: AppColors.grayishPurple),
      ),
    );
  }
}
