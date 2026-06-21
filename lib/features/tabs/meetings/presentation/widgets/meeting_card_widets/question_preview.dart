import 'package:explaino/core/helpers/text_direction_helper.dart';
import 'package:flutter/material.dart';
import 'package:explaino/core/theme/app_colors.dart';

class QuestionPreview extends StatelessWidget {
  final String question;
  const QuestionPreview({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.08),
          width: 0.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.help_outline_rounded,
            size: 16,
            color: AppColors.primary.withValues(alpha: 0.6),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              question,
              textDirection: getTextDirection(question),
              style: textTheme.titleSmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
