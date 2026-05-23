import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddContentEditor extends StatelessWidget {
  const AddContentEditor({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: null,
      expands: true,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: AppTextConstants.addContentHint,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textHint.withValues(alpha: .75),
          fontWeight: FontWeight.w600,
        ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
