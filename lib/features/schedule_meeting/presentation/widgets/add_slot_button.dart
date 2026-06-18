import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddSlotButton extends StatelessWidget {
  const AddSlotButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.add, size: 18, color: AppColors.primary),
        label: const Text(
          'Add time slot',
          style: TextStyle(color: AppColors.primary),
        ),
        style: OutlinedButton.styleFrom(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          side: const BorderSide(color: AppColors.primary, width: 0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
