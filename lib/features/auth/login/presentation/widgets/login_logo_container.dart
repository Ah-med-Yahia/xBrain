import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoginLogoContainer extends StatelessWidget {
  const LoginLogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width * 0.2,
          height: size.width * 0.2,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.darkBlue],
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.brightSkyBlue,
                offset: Offset(0, 4),
                blurRadius: 6,
                spreadRadius: -4,
              ),
              BoxShadow(
                color: AppColors.brightSkyBlue,
                offset: Offset(0, 10),
                blurRadius: 15,
                spreadRadius: -3,
              ),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Assets.images.loginLogo.svg(
              width: size.width * 0.06,
              height: size.height * 0.05,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.03),
        Text(
          AppTextConstants.welcomeBack,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(height: size.height * 0.01),
        Text(
          AppTextConstants.signInToAccount,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
