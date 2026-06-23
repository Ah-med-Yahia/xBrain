import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/post_action/domain/entities/response/comment_entity.dart';
import 'package:explaino/features/post_action/presentation/widgets/comment_item.dart';
import 'package:flutter/material.dart';

class RepliesSection extends StatelessWidget {
  const RepliesSection({
    super.key,
    required this.replies,
    required this.comment,
    required this.isLoadingReplies,
    required this.hasLoadedReplies,
    this.onViewReplies,
    required this.onReply,
  });

  final List<CommentEntity>? replies;
  final CommentEntity comment;
  final bool isLoadingReplies;
  final bool hasLoadedReplies;
  final VoidCallback? onViewReplies;
  final VoidCallback onReply;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!hasLoadedReplies && !isLoadingReplies)
            InkWell(
              onTap: onViewReplies,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  '${AppTextConstants.view} ${comment.repliesCount} ${AppTextConstants.replies}',
                  style: textTheme.labelMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          if (isLoadingReplies)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  backgroundColor: AppColors.primary,
                  color: AppColors.primary,
                ),
              ),
            ),
          if (hasLoadedReplies)
            ...replies!.map(
              (reply) => Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CommentItem(comment: reply, onReply: onReply),
              ),
            ),
        ],
      ),
    );
  }
}
