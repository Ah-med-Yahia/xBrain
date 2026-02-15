import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SocialIconRow extends StatelessWidget {
  const SocialIconRow({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIconContainer(iconWidget: Assets.googleLogo.svg()),
        SizedBox(width: size.width * 0.04),
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
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Container(
        width: size.width * 0.15,
        height: size.width * 0.15,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black, width: 1.5),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.025),
          child: iconWidget,
        ),
      ),
    );
  }
}
