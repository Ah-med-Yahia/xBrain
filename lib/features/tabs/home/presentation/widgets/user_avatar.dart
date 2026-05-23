import 'package:cached_network_image/cached_network_image.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String username;
  final String profileImageUrl;

  const UserAvatar({
    super.key,
    required this.username,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final initial = username[0].toUpperCase();

    final fallback = CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
      child: Text(
        initial,
        style: textTheme.bodyLarge?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
      ),
    );

    if (profileImageUrl.isEmpty) return fallback;

    return ClipOval(
      child: CachedNetworkImage(
        width: 40,
        height: 40,
        imageUrl: profileImageUrl,
        fit: BoxFit.cover,
        placeholder: (_, _) => Container(
          width: 40,
          height: 40,
          color: AppColors.primary.withValues(alpha: 0.15),
          child: Center(
            child: Text(
              initial,
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ),
        ),
        errorWidget: (_, _, _) => fallback,
      ),
    );
  }
}
