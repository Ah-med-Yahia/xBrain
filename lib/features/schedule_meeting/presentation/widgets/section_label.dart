import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel({super.key, required this.label, this.note});

  final String label;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: AppColors.textHint,
          ),
        ),
        const SizedBox(width: 4),
        if (note != null) ...[
          Text(
            '($note)',
            style: textTheme.bodyMedium?.copyWith(color: AppColors.textHint),
          ),
        ],
      ],
    );
  }
}
