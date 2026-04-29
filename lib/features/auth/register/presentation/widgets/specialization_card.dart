import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/auth/register/presentation/ui_models/specialization_model_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SpecializationCard extends StatelessWidget {
  const SpecializationCard({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.specialization,
  });
  final bool isSelected;
  final VoidCallback onTap;
  final SpecializationModelUI specialization;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? null : AppColors.lightPeriwinkle,
          borderRadius: BorderRadius.circular(14),
          gradient: isSelected
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.7, 1.0],
                  colors: [AppColors.skyBlue, AppColors.blue],
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: .1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  specialization.icon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppColors.white : AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  specialization.name,
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (isSelected)
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
