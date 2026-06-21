import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/features/post_action/data/mappers/comment_mapper.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_cubit.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_intents.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_side_effects.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_state.dart';
import 'package:explaino/features/post_action/presentation/widgets/comment_item.dart';
import 'package:explaino/features/post_action/presentation/widgets/post_card_in_post_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PostDetailsScreen extends StatefulWidget {
  final String postId;
  const PostDetailsScreen({super.key, required this.postId});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  late final PostActionCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<PostActionCubit>();
    _cubit.sideEffects.listen((event) {
      switch (event) {
        case LoadingSideEffects():
          _handleLoading();
        case HideLoadingSideEffects():
          _handleHideLoading();
        case ErrorWhenGetSinglePost(message: final message):
          _handleError(message);
        case ErrorWhenGetComments(message: final message):
          _handleError(message);
      }
    });
    _cubit.doIntent(GetSinglePostIntent(postId: widget.postId));
  }

  void _handleLoading() {
    UIUtils.showEasyLoading();
  }

  void _handleHideLoading() {
    UIUtils.hideEasyLoading();
  }

  void _handleError(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.red,
      textColor: AppColors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<PostActionCubit, PostActionState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.kLight,
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                color: AppColors.lightTextPrimary,
                onPressed: () => context.pop(),
              ),
            ),
            body: state.post == null
                ? const SizedBox.shrink()
                : _buildContent(context, state),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, PostActionState state) {
    final post = state.post!;
    final comments = post.comments;
    final textTheme = Theme.of(context).textTheme;
    return CustomScrollView(
      slivers: [
        PostCardInPostDetails(post: post),
        if (comments.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Row(
                children: [
                  Text(
                    AppTextConstants.comments,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.brightSkyBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${post.commentsCount}',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (comments.isNotEmpty)
          SliverList.separated(
            itemCount: comments.length,
            separatorBuilder: (context, index) => const SizedBox.shrink(),
            itemBuilder: (context, index) =>
                CommentItem(comment: comments[index].toEntity()),
          ),
        if (comments.isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  Icon(
                    Icons.mode_comment_outlined,
                    size: 48,
                    color: AppColors.lightTextSecondary.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppTextConstants.noCommentsYet,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }
}
