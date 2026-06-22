import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/helpers/format_date.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/post_action/domain/entities/response/comment_entity.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  final VoidCallback onReply;
  const CommentItem({super.key, required this.comment, required this.onReply});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bubbleColor = isDark ? AppColors.darkInputFill : AppColors.white;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(
            radius: 20,
            userName: comment.author.username,
            profileImageUrl: comment.author.profileImageUrl.isNotEmpty
                ? comment.author.profileImageUrl
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${comment.author.firstName} ${comment.author.lastName}',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        comment.content,
                        style: textTheme.bodyMedium?.copyWith(
                          height: 1.45,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4),
                  child: Row(
                    children: [
                      Text(
                        formatTime(comment.createdAt),
                        style: textTheme.labelSmall?.copyWith(
                          color: AppColors.lightTextSecondary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: onReply,
                        child: Text(
                          AppTextConstants.reply,
                          style: textTheme.labelSmall?.copyWith(
                            color: AppColors.lightTextSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
