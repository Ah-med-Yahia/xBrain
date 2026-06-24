import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/core/utils/ui_utils.dart';
import 'package:explaino/features/post_action/data/mappers/comment_mapper.dart';
import 'package:explaino/features/post_action/domain/entities/request/comment_request_entity.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_cubit.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_intents.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_side_effects.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_state.dart';
import 'package:explaino/features/post_action/presentation/widgets/add_comment_bar.dart';
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
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

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
        case ErrorSideEffect(message: final message):
          _handleError(message);
        case CommentAddedSuccessfully():
        case ReplyAddedSuccessfully():
          _commentController.clear();
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

  void _submitComment(PostActionState state) {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    if (state.replyingToComment != null) {
      _cubit.doIntent(
        AddReplyIntent(
          commentId: state.replyingToComment!.id,
          request: CommentRequestEntity(content: text),
        ),
      );
    } else {
      _cubit.doIntent(
        AddCommentIntent(
          id: widget.postId,
          request: CommentRequestEntity(content: text),
        ),
      );
    }
    _commentFocusNode.unfocus();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
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
            bottomNavigationBar: AddCommentBar(
              commentController: _commentController,
              commentFocusNode: _commentFocusNode,
              submitComment: () => _submitComment(state),
              replyingToUser: state.replyingToComment != null
                  ? '${state.replyingToComment!.author.firstName} ${state.replyingToComment!.author.lastName}'
                  : null,
              onCancelReply: () {
                _cubit.doIntent(SetReplyingToCommentIntent(comment: null));
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildViewMoreCommentsButton(
    BuildContext context,
    int remaining,
    int loadedCount,
  ) {
    final textTheme = Theme.of(context).textTheme;
    // Each page has 10 comments, so next page = loadedCount ~/ 10 + 1
    final nextPage = loadedCount ~/ 10 + 1;
    return InkWell(
      onTap: () {
        _cubit.doIntent(
          GetCommentsIntent(postId: widget.postId, page: nextPage),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            const Icon(
              Icons.expand_more_rounded,
              size: 18,
              color: AppColors.primary,
            ),
            const SizedBox(width: 6),
            Text(
              'View $remaining more comment${remaining > 1 ? 's' : ''}',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PostActionState state) {
    final post = state.post!;
    final comments = post.comments;
    final textTheme = Theme.of(context).textTheme;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        PostCardInPostDetails(
          post: post,
          onComment: () {
            _commentFocusNode.requestFocus();
          },
        ),
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
            itemBuilder: (context, index) {
              final comment = comments[index].toEntity();
              final repliesForComment = state.commentReplies[comment.id];
              final isLoadingReplies = state.loadingReplies.contains(
                comment.id,
              );
              return CommentItem(
                comment: comment,
                replies: repliesForComment,
                isLoadingReplies: isLoadingReplies,
                onViewReplies: () {
                  _cubit.doIntent(GetRepliesIntent(id: comment.id, page: 1));
                },
                onReply: () {
                  _cubit.doIntent(SetReplyingToCommentIntent(comment: comment));
                  _commentFocusNode.requestFocus();
                },
              );
            },
          ),
        if (comments.isNotEmpty && post.commentsCount > comments.length)
          SliverToBoxAdapter(
            child: _buildViewMoreCommentsButton(
              context,
              post.commentsCount - comments.length,
              comments.length,
            ),
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
