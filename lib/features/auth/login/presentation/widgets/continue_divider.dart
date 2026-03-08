import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ContinueDivider extends StatelessWidget {
  const ContinueDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(child: Divider(color: AppColors.divider)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Text(
            AppTextConstants.orContinueWith,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const Expanded(child: Divider(color: AppColors.divider)),
      ],
    );
  }
}
