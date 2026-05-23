import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PickImagePlaceholder extends StatelessWidget {
  const PickImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.add_photo_alternate_outlined,
          color: AppColors.primary,
          size: 34,
        ),
        const SizedBox(height: 10),
        Text(
          AppTextConstants.addCertificateImage,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
