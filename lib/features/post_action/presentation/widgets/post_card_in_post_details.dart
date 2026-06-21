import 'package:explaino/core/helpers/format_date.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/post_action/domain/entities/response/post_entity.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_cubit.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_intents.dart';
import 'package:explaino/features/post_action/presentation/widgets/post_media_grid.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/action_button.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCardInPostDetails extends StatelessWidget {
  const PostCardInPostDetails({super.key, required this.post});
  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
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
                  UserAvatar(
                    userName: post.author.username,
                    profileImageUrl: post.author.profileImageUrl.isNotEmpty
                        ? post.author.profileImageUrl
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${post.author.firstName} ${post.author.lastName}',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.lightTextPrimary,
                          ),
                        ),
                        Text(
                          '@${post.author.username}',
                          style: textTheme.bodySmall?.copyWith(
                            color: AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    formatDate(post.createdAt),
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
              if (post.specializations.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: post.specializations
                      .map(
                        (s) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.brightSkyBlue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            s.name,
                            style: textTheme.labelSmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
              // ==  Content =====================
              const SizedBox(height: 14),
              Text(
                post.content,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.lightTextPrimary,
                  height: 1.55,
                ),
              ),
              // == Attachments Grid =====================
              if (post.attachments.isNotEmpty) ...[
                const SizedBox(height: 14),
                PostMediaGrid(attachments: post.attachments),
              ],
              // ── Like / Dislike Row ────────────────────────
              const SizedBox(height: 16),
              const Divider(height: 1, thickness: 2, color: AppColors.kLight),
              const SizedBox(height: 12),
              PostActions(
                myReaction: post.myReaction ?? '',
                likesCount: post.likesCount,
                dislikesCount: post.dislikesCount,
                commentsCount: post.commentsCount,
                onLike: () {
                  context.read<PostActionCubit>().doIntent(
                    LikePostIntent(postId: post.id),
                  );
                },
                onDislike: () {
                  context.read<PostActionCubit>().doIntent(
                    DislikePostIntent(postId: post.id),
                  );
                },
                onComment: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
