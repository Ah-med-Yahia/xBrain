import 'package:explaino/core/gen/assets.gen.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ContinueWithGoogle extends StatelessWidget {
  const ContinueWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      children: [
        _SocialIconContainer(
          iconWidget: Assets.images.googleLogo.svg(),
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
      child: CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.offWhite,
        child: Padding(padding: const EdgeInsets.all(12), child: iconWidget),
      ),
    );
  }
}
