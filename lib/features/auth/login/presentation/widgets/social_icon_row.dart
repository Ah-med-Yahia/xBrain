import 'package:flutter/material.dart';

import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/theme/app_colors.dart';

class SocialIconRow extends StatelessWidget {
  const SocialIconRow({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIconContainer(iconWidget: Assets.googleLogo.svg()),
        SizedBox(width: width * 0.04),
        _SocialIconContainer(iconWidget: Assets.facebookLogo.svg()),
      ],
    );
  }
}

class _SocialIconContainer extends StatelessWidget {
  const _SocialIconContainer({required this.iconWidget});

  final Widget iconWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(56 / 2),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: AppColors.black),
        ),
        child: Padding(padding: EdgeInsets.all(10), child: iconWidget),
      ),
    );
  }
}
