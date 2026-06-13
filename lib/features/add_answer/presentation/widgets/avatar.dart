import 'package:cached_network_image/cached_network_image.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Avatar extends StatelessWidget {
  final String username;
  final String? profileImageUrl;

  const Avatar({super.key, required this.username, this.profileImageUrl});
  Widget _shimmerPlaceholder(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: const CircleAvatar(
        radius: 23,
        backgroundColor: AppColors.shimmerBaseColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final initial = username[0].toUpperCase();

    final fallback = CircleAvatar(
      radius: 23,
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

    return ClipOval(
      child: profileImageUrl != null && profileImageUrl!.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: profileImageUrl!,
              imageBuilder: (context, imageProvider) =>
                  CircleAvatar(radius: 23, backgroundImage: imageProvider),
              placeholder: (context, url) => _shimmerPlaceholder(context),
              errorWidget: (context, url, error) => fallback,
            )
          : fallback,
    );
  }
}
