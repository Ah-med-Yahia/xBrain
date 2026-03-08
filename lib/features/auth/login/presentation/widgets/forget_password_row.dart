import 'package:explaino/core/constants/app_routes_constant.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordRow extends StatelessWidget {
  const ForgetPasswordRow({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: InkWell(
            onTap: () {
              context.go(AppRoutesConstants.forgetPassword);
            },
            child: Text(
              AppTextConstants.forgotPassword,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
