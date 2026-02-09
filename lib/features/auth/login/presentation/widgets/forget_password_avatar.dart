import 'package:flutter/material.dart';

import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/theme/app_colors.dart';

class ForgetPasswordAvatar extends StatelessWidget {
  const ForgetPasswordAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: width * 0.25,
          backgroundColor: AppColors.circleAvatarBackground.withOpacity(.5),
        ),
        CircleAvatar(
          radius: width * 0.225,
          backgroundColor: AppColors.circleAvatarBackground,
        ),
        Positioned(
          top: height * 0.015,
          right: width * 0.075,
          child: CircleAvatar(
            radius: width * 0.0375,
            backgroundColor: AppColors.primary,
          ),
        ),
        Assets.forgetPasswordLogo.svg(
          width: width * 0.115,
          height: width * 0.115,
        ),
      ],
    );
  }
}
