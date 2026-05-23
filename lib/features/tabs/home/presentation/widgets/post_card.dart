import 'package:explaino/core/helpers/text_direction_helper.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_posts_response_model/post_model.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/action_button.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/attachment_preview.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/user_header.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final ShortPostModel post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textDirection = getTextDirection(post.contentPreview);

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserHeader(
              username: post.author.username,
              profileImageUrl: post.author.profileImageUrl,
              role: 'Software Engineer',
              createdAt: post.createdAt,
            ),
            const SizedBox(height: 10),
            Text(
              post.contentPreview,
              textDirection: textDirection,
              textAlign: textDirection == TextDirection.rtl
                  ? TextAlign.right
                  : TextAlign.left,
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.lightTextPrimary,
              ),
            ),
            if (post.attachments!.isNotEmpty) ...[
              const SizedBox(height: 10),
              AttachmentPreview(attachments: post.attachments!),
            ],
            const SizedBox(height: 12),
            PostActions(
              myReaction: post.myReaction ?? '',
              likesCount: post.likesCount,
              dislikesCount: post.dislikesCount,
              commentsCount: post.commentsCount,
              onLike: () {},
              onDislike: () {},
              onComment: () {},
            ),
          ],
        ),
      ),
    );
  }
}
