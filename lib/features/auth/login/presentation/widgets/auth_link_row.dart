import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class AuthLinkRow extends StatelessWidget {
  const AuthLinkRow({
    super.key,
    required this.promptText,
    required this.linkText,
    required this.onLinkTap,
  });

  final String promptText;
  final String linkText;
  final VoidCallback onLinkTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(promptText, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(width: width * 0.01),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            linkText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
