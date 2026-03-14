import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SocialIconRow extends StatelessWidget {
  const SocialIconRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      children: [
        _SocialIconContainer(iconWidget: Assets.googleLogo.svg(), onTap: () {}),
        _SocialIconContainer(
          iconWidget: Assets.facebookLogo.svg(),
          onTap: () {},
        ),
      ],
    );
  }
}

class _SocialIconContainer extends StatelessWidget {
  const _SocialIconContainer({required this.iconWidget, required this.onTap});

  final Widget iconWidget;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black, width: 1.5),
          shape: BoxShape.circle,
        ),
        child: Padding(padding: const EdgeInsets.all(12), child: iconWidget),
      ),
    );
  }
}
