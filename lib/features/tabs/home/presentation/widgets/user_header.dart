import 'package:explaino/core/helpers/time_ago_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class UserHeader extends StatelessWidget {
  final String username;
  final String profileImageUrl;
  final String role;
  final DateTime createdAt;

  const UserHeader({
    super.key,
    required this.username,
    required this.profileImageUrl,
    required this.role,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        UserAvatar(username: username, profileImageUrl: profileImageUrl),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                role,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.lightGrey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${timeAgo(createdAt)} • ',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.lightGrey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
