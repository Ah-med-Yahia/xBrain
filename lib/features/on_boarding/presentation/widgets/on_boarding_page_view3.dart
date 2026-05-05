import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OnBoardingPageView3 extends StatelessWidget {
  const OnBoardingPageView3({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(flex: 1),
        Image.asset(
          Assets.images.onBoarding3.path,
          width: double.infinity,
          height: screenSize.height * .4,
          fit: BoxFit.cover,
        ),
        const Spacer(flex: 2),
        Image.asset(
          Assets.images.earnPoints.path,
          width: screenSize.width * 0.4,
        ),
        const SizedBox(height: 18),
        Text(
          AppTextConstants.onBoardingText3,
          style: textTheme.bodyLarge?.copyWith(
            fontSize: 18,
            color: AppColors.lightGrey,
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
