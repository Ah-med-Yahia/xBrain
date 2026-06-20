import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/helpers/text_direction_helper.dart';
import 'package:explaino/core/shared/data/models/posts/response/get_posts_response_model/post_model.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_cubit.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_intents.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_state.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/action_button.dart';
import 'package:explaino/core/shared/presentation/widgets/attachment_preview.dart';
import 'package:explaino/features/tabs/home/presentation/widgets/user_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCard extends StatelessWidget {
  final ShortPostModel shortPost;
  const PostCard({super.key, required this.shortPost});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textDirection = getTextDirection(shortPost.contentPreview);

    return BlocProvider(
      create: (context) => getIt<PostActionCubit>(),
      child: Container(
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
                fullname:
                    '${shortPost.author.firstName} ${shortPost.author.lastName}',
                profileImageUrl: shortPost.author.profileImageUrl,
                role: 'Software Engineer',
                createdAt: shortPost.createdAt,
              ),
              const SizedBox(height: 10),
              Text(
                shortPost.contentPreview,
                textDirection: textDirection,
                textAlign: textDirection == TextDirection.rtl
                    ? TextAlign.right
                    : TextAlign.left,
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.lightTextPrimary,
                ),
              ),
              if (shortPost.attachments!.isNotEmpty) ...[
                const SizedBox(height: 10),
                AttachmentPreview(attachments: shortPost.attachments!),
              ],
              const SizedBox(height: 12),
              BlocBuilder<PostActionCubit, PostActionState>(
                buildWhen: (previous, current) => previous.post != current.post,
                builder: (context, state) {
                  String myReaction;
                  int likesCount;
                  int dislikesCount;
                  int commentsCount;
                  if (state.post == null) {
                    myReaction = shortPost.myReaction ?? '';
                    likesCount = shortPost.likesCount;
                    dislikesCount = shortPost.dislikesCount;
                    commentsCount = shortPost.commentsCount;
                  } else {
                    myReaction = state.post!.myReaction ?? '';
                    likesCount = state.post!.likesCount;
                    dislikesCount = state.post!.dislikesCount;
                    commentsCount = state.post!.commentsCount;
                  }
                  return PostActions(
                    myReaction: myReaction,
                    likesCount: likesCount,
                    dislikesCount: dislikesCount,
                    commentsCount: commentsCount,
                    onLike: () {
                      context.read<PostActionCubit>().doIntent(
                        LikePostIntent(postId: shortPost.id),
                      );
                    },
                    onDislike: () {
                      context.read<PostActionCubit>().doIntent(
                        DislikePostIntent(postId: shortPost.id),
                      );
                    },
                    onComment: () {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
