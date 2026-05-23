import 'package:cached_network_image/cached_network_image.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ImageAttachment extends StatelessWidget {
  final String url;
  const ImageAttachment({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (_, _) => Container(
            color: AppColors.offWhite,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (_, _, _) => Container(
            color: AppColors.offWhite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.broken_image_outlined,
                  color: AppColors.grey500,
                  size: 32,
                ),
                const SizedBox(height: 6),
                Text(
                  AppTextConstants.imageNotAvailable,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
