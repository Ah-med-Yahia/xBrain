import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(promptText, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(width: 4),
        TextButton(
          onPressed: onLinkTap,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
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
