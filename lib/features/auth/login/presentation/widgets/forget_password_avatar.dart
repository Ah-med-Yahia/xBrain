import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ForgetPasswordAvatar extends StatelessWidget {
  const ForgetPasswordAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: size.width * 0.25,
          backgroundColor: AppColors.lightPeriwinkle.withValues(alpha: 0.5),
        ),
        CircleAvatar(
          radius: size.width * 0.225,
          backgroundColor: AppColors.lightPeriwinkle,
        ),
        Positioned(
          top: size.height * 0.015,
          right: size.width * 0.075,
          child: CircleAvatar(
            radius: size.width * 0.0375,
            backgroundColor: AppColors.primary,
          ),
        ),
        Assets.forgetPasswordLogo.svg(
          width: size.width * 0.115,
          height: size.width * 0.115,
        ),
      ],
    );
  }
}
