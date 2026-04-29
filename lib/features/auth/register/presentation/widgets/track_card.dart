import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/auth/register/presentation/model_ui/track_model_ui.dart';
import 'package:flutter/material.dart';

class TrackCard extends StatelessWidget {
  const TrackCard({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.track,
  });
  final bool isSelected;
  final VoidCallback onTap;
  final TrackModelUI track;

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon(track.icon, color: textColor, size: 26),
                const SizedBox(height: 10),
                Text(
                  track.name,
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
