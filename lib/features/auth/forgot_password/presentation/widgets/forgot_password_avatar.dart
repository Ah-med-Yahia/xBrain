import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ForgotPasswordAvatar extends StatelessWidget {
  final bool isForgotPassword;
  const ForgotPasswordAvatar({super.key, required this.isForgotPassword});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final avatarRadius = size.width * 0.25;
    final iconSize = (size.width * 0.115).clamp(32.0, 64.0);
    final dotRadius = avatarRadius * 0.1;
    final dotOffset = avatarRadius * 0.7;
    final TextTheme textTheme = Theme.of(context).textTheme;

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
            Assets.images.forgetPasswordLogo.svg(
              width: iconSize,
              height: iconSize,
            ),
          ],
        ),
        const SizedBox(height: 24),
        isForgotPassword
            ? Text(
                AppTextConstants.forgotPassword,
                style: textTheme.headlineLarge,
              )
            : Text(
                AppTextConstants.resetPassword,
                style: textTheme.headlineLarge,
              ),
        const SizedBox(height: 16),
      ],
    );
  }
}
