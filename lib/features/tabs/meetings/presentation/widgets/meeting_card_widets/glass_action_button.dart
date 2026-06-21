import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/meetings/presentation/widgets/meeting_card.dart';
import 'package:flutter/material.dart';

class GlassActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final ButtonVariant variant;
  final VoidCallback onTap;

  const GlassActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.variant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isOutline = variant == ButtonVariant.outline;
    final isGradient = variant == ButtonVariant.gradient;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        splashColor: isOutline
            ? AppColors.primary.withValues(alpha: 0.08)
            : AppColors.white.withValues(alpha: 0.15),
        highlightColor: isOutline
            ? AppColors.primary.withValues(alpha: 0.04)
            : AppColors.white.withValues(alpha: 0.08),
        child: Ink(
          height: 40,
          decoration: BoxDecoration(
            gradient: isGradient
                ? const LinearGradient(
                    colors: [AppColors.primary, AppColors.azureBlue],
                  )
                : null,
            color: isOutline
                ? Colors.transparent
                : isGradient
                ? null
                : AppColors.primary,
            borderRadius: BorderRadius.circular(14),
            border: isOutline
                ? Border.all(color: AppColors.lightBlueGray, width: 1.5)
                : null,
            boxShadow: isOutline
                ? null
                : [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isOutline ? AppColors.darkGray : AppColors.white,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: textTheme.bodyLarge?.copyWith(
                  color: isOutline ? AppColors.darkGray : AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
