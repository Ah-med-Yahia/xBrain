import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final VoidCallback pickImage;

  const TopBar({super.key, required this.pickImage});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context, true),
            child: const Icon(Icons.close, color: Colors.white, size: 22),
          ),
          Text(
            AppTextConstants.profilePicture,
            style: textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
          GestureDetector(
            onTap: pickImage,
            child: const Icon(Icons.edit, color: AppColors.white, size: 22),
          ),
        ],
      ),
    );
  }
}
