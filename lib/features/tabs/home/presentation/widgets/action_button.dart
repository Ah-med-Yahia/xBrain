import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PostActions extends StatelessWidget {
  final String myReaction;
  final int likesCount;
  final int dislikesCount;
  final int commentsCount;
  final VoidCallback onLike;
  final VoidCallback onDislike;
  final VoidCallback onComment;

  const PostActions({
    super.key,
    required this.myReaction,
    required this.likesCount,
    required this.dislikesCount,
    required this.commentsCount,
    required this.onLike,
    required this.onDislike,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionButton(
            icon: myReaction == 'like'
                ? Icons.thumb_up
                : Icons.thumb_up_outlined,
            label: '$likesCount',
            isActive: myReaction == 'like',
            onTap: onLike,
          ),
          const SizedBox(width: 16),
          _ActionButton(
            icon: myReaction == 'dislike'
                ? Icons.thumb_down
                : Icons.thumb_down_outlined,
            label: '$dislikesCount',
            isActive: myReaction == 'dislike',
            onTap: onDislike,
          ),
          const SizedBox(width: 16),
          _ActionButton(
            icon: Icons.comment_outlined,
            label: '$commentsCount',
            isActive: false,
            onTap: onComment,
          ),
        ],
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
        mainAxisSize: MainAxisSize.min,
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
