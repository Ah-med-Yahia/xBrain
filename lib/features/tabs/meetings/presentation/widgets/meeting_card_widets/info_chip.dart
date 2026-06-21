import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const InfoChip({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 14, color: iconColor),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: textTheme.bodyLarge?.copyWith(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: AppColors.darkGray,
          ),
        ),
      ],
    );
  }
}
