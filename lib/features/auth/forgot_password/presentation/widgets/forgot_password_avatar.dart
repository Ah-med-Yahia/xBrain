import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ForgotPasswordAvatar extends StatelessWidget {
  const ForgotPasswordAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final avatarRadius = width * 0.25;
    final iconSize = (width * 0.115).clamp(32.0, 64.0);
    final dotRadius = avatarRadius * 0.15;
    final dotOffset = avatarRadius * 0.72;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: avatarRadius,
              backgroundColor: AppColors.lightPeriwinkle.withValues(alpha: 0.5),
            ),
            CircleAvatar(
              radius: avatarRadius * 0.9,
              backgroundColor: AppColors.lightPeriwinkle,
            ),
            Positioned(
              top: avatarRadius - dotOffset,
              right: avatarRadius - dotOffset,
              child: CircleAvatar(
                radius: dotRadius,
                backgroundColor: AppColors.primary,
              ),
            ),
            Assets.forgetPasswordLogo.svg(width: iconSize, height: iconSize),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          AppTextConstants.forgotPassword,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
