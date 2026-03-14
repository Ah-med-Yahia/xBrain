import 'package:explaino/core/constants/app_routes_constant.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordRow extends StatelessWidget {
  const ForgetPasswordRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => context.go(AppRoutesConstants.forgetPassword),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          AppTextConstants.forgotPassword,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
