import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:explaino/core/constants/app_text_constants.dart';

class AnswerButton extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final bool hasAttachments;

  const AnswerButton({
    super.key,
    required this.controller,
    required this.onTap,
    required this.hasAttachments,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final canSend = value.text.isNotEmpty || hasAttachments;
        return GestureDetector(
          onTap: canSend ? onTap : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: canSend ? AppColors.primary : AppColors.shimmerBaseColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppTextConstants.answer,
                  style: textTheme.labelLarge?.copyWith(
                    color: canSend ? AppColors.white : AppColors.silverGray,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.send_rounded,
                  color: canSend ? AppColors.white : AppColors.silverGray,
                  size: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
