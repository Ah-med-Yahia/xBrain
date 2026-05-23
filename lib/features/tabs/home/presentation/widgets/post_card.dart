import 'package:cached_network_image/cached_network_image.dart';
import 'package:explaino/core/helpers/time_ago.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_posts_response_model/post_model.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final ShortPostModel post;
  const PostCard({super.key, required this.post});

  Widget _buildAvatar(TextTheme textTheme) {
    final initial = post.author.username[0].toUpperCase();
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

    if (post.author.profileImageUrl.isEmpty) return fallback;

    return ClipOval(
      child: CachedNetworkImage(
        width: 40,
        height: 40,
        imageUrl: post.author.profileImageUrl,
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

  Widget _buildAttachment() {
    final imageAttachment = post.attachments!
        .where((a) => a.kind == 'image')
        .firstOrNull;

    if (imageAttachment != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: CachedNetworkImage(
            imageUrl: imageAttachment.url,
            fit: BoxFit.cover,
            placeholder: (_, _) => Container(
              color: AppColors.offWhite,
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            errorWidget: (_, _, _) => Container(
              color: AppColors.offWhite,
              child: const Icon(Icons.broken_image_outlined, size: 32),
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildAvatar(textTheme),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author.username,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Software Engineer • ${timeAgo(post.createdAt)}',
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.lightGrey,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.more_horiz,
                  color: AppColors.lightGrey,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              post.contentPreview,
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.lightTextPrimary,
              ),
            ),
            if (post.attachments!.isNotEmpty) ...[
              const SizedBox(height: 10),
              _buildAttachment(),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                _ActionButton(
                  icon: post.myReaction == 'like'
                      ? Icons.thumb_up
                      : Icons.thumb_up_outlined,
                  label: '${post.likesCount}',
                  isActive: post.myReaction == 'like',
                  onTap: () {},
                ),
                const SizedBox(width: 16),
                _ActionButton(
                  icon: post.myReaction == 'dislike'
                      ? Icons.thumb_down
                      : Icons.thumb_down_outlined,
                  label: '${post.dislikesCount}',
                  isActive: post.myReaction == 'dislike',
                  onTap: () {},
                ),
                const SizedBox(width: 16),
                _ActionButton(
                  icon: Icons.comment_outlined,
                  label: '${post.commentsCount}',
                  isActive: false,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isActive ? AppColors.primary : AppColors.lightGrey,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isActive ? AppColors.primary : AppColors.lightGrey,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
