import 'dart:async';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/post_action/domain/entities/request/comment_request_entity.dart';
import 'package:explaino/features/post_action/domain/entities/response/comment_entity.dart';
import 'package:explaino/features/post_action/data/mappers/comment_mapper.dart';
import 'package:explaino/features/post_action/domain/usecase/add_comment_use_case.dart';
import 'package:explaino/features/post_action/domain/usecase/get_comments_use_case.dart';
import 'package:explaino/features/post_action/domain/usecase/get_single_post_use_case.dart';
import 'package:explaino/features/post_action/domain/usecase/like_post_use_case.dart';
import 'package:explaino/features/post_action/domain/usecase/unlike_post_use_case.dart';
import 'package:explaino/features/post_action/domain/usecase/add_reply_on_comment_use_case.dart';
import 'package:explaino/features/post_action/domain/usecase/get_replies_on_comment_use_case.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_intents.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_side_effects.dart';
import 'package:explaino/features/post_action/presentation/cubit/post_action_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PostActionCubit extends Cubit<PostActionState> {
  PostActionCubit({
    required this.getSinglePostUseCase,
    required this.likePostUseCase,
    required this.dislikePostUseCase,
    required this.getCommentsUseCase,
    required this.addCommentUseCase,
    required this.addReplyOnCommentUseCase,
    required this.getRepliesOnCommentUseCase,
  }) : super(const PostActionState());

  final GetSinglePostUseCase getSinglePostUseCase;
  final LikePostUseCase likePostUseCase;
  final UnlikePostUseCase dislikePostUseCase;
  final GetCommentsUseCase getCommentsUseCase;
  final AddCommentUseCase addCommentUseCase;
  final AddReplyOnCommentUseCase addReplyOnCommentUseCase;
  final GetRepliesOnCommentUseCase getRepliesOnCommentUseCase;

  final StreamController<PostActionSideEffects> _sideEffectsController =
      StreamController<PostActionSideEffects>();
  Stream<PostActionSideEffects> get sideEffects =>
      _sideEffectsController.stream;

  void doIntent(PostActionIntents intent) {
    switch (intent) {
      case GetSinglePostIntent(postId: final postId):
        _getSinglePost(postId);
      case LikePostIntent(postId: final postId):
        _likePost(postId);
      case DislikePostIntent(postId: final postId):
        _dislikePost(postId);
      case AddCommentIntent(id: final id, request: final request):
        _addComment(id: id, request: request);
      case AddReplyIntent(commentId: final commentId, request: final request):
        _addReply(commentId: commentId, request: request);
      case SetReplyingToCommentIntent(comment: final comment):
        emit(
          state.copyWith(
            replyingToComment: comment,
            clearReplyingToComment: comment == null,
          ),
        );
      case DeleteCommentOrReplyIntent():
        throw UnimplementedError();
      case GetCommentsIntent(postId: final postId, page: final page):
        _getComments(postId: postId, page: page);
      case GetRepliesIntent(id: final id, page: final page):
        _getReplies(id: id, page: page);
      case GetSingleCommentOrReplyIntent():
      case UpdateCommentOrReplyIntent():
        throw UnimplementedError();
    }
  }

  //================== Post ==================

  void _getSinglePost(String postId, {bool showLoading = true}) async {
    if (showLoading) _sideEffectsController.add(LoadingSideEffects());
    final result = await getSinglePostUseCase(postId);
    if (showLoading) _sideEffectsController.add(HideLoadingSideEffects());
    result.when(
      success: (post) => emit(state.copyWith(post: post)),
      failure: (failure) =>
          _sideEffectsController.add(ErrorSideEffect(message: failure.message)),
    );
  }

  void _likePost(String postId) async {
    final result = await likePostUseCase(postId);
    result.when(
      success: (post) {
        emit(state.copyWith(post: post));
      },
      failure: (failure) {
        _sideEffectsController.add(
          ErrorWhenLikeOrDislikePost(message: failure.message),
        );
      },
    );
  }

  void _dislikePost(String postId) async {
    final result = await dislikePostUseCase(postId);
    result.when(
      success: (post) {
        emit(state.copyWith(post: post));
      },
      failure: (failure) {
        _sideEffectsController.add(
          ErrorWhenLikeOrDislikePost(message: failure.message),
        );
      },
    );
  }

  void _getComments({required String postId, int page = 1}) async {
    final result = await getCommentsUseCase(id: postId, page: page);
    result.when(
      success: (response) {
        if (state.post != null) {
          final currentComments = List.of(state.post!.comments);
          if (page == 1) {
            currentComments
              ..clear()
              ..addAll(response.comments.map((e) => e.toModel()));
          } else {
            currentComments.addAll(response.comments.map((e) => e.toModel()));
          }
          final updatedPost = state.post!.copyWith(
            comments: currentComments,
            commentsCount: response.count,
          );
          emit(state.copyWith(post: updatedPost));
        }
      },
      failure: (failure) {
        _sideEffectsController.add(ErrorSideEffect(message: failure.message));
      },
    );
  }

  //================== Comment ==================

  void _addComment({
    required String id,
    required CommentRequestEntity request,
  }) async {
    _sideEffectsController.add(LoadingSideEffects());
    final result = await addCommentUseCase(id: id, request: request);
    _sideEffectsController.add(HideLoadingSideEffects());

    result.when(
      success: (_) {
        emit(state.copyWith(clearReplyingToComment: true));
        _sideEffectsController.add(CommentAddedSuccessfully());
        if (state.post != null) {
          _getComments(postId: state.post!.id, page: 1);
        }
      },
      failure: (failure) {
        _sideEffectsController.add(ErrorSideEffect(message: failure.message));
      },
    );
  }

  void _addReply({
    required String commentId,
    required CommentRequestEntity request,
  }) async {
    _sideEffectsController.add(LoadingSideEffects());
    final result = await addReplyOnCommentUseCase(
      id: commentId,
      request: request,
    );
    _sideEffectsController.add(HideLoadingSideEffects());
    result.when(
      success: (_) {
        emit(state.copyWith(clearReplyingToComment: true));
        _sideEffectsController.add(ReplyAddedSuccessfully());
        if (state.post != null) {
          _getReplies(id: commentId, page: 1);
        }
      },
      failure: (failure) {
        _sideEffectsController.add(ErrorSideEffect(message: failure.message));
      },
    );
  }

  void _getReplies({required String id, int page = 1}) async {
    final loadingSet = Set<String>.from(state.loadingReplies)..add(id);
    emit(state.copyWith(loadingReplies: loadingSet));

    final result = await getRepliesOnCommentUseCase(id: id, page: page);

    final newLoadingSet = Set<String>.from(state.loadingReplies)..remove(id);
    result.when(
      success: (response) {
        final currentReplies = Map<String, List<CommentEntity>>.from(
          state.commentReplies,
        );
        if (page == 1) {
          currentReplies[id] = response.comments;
        } else {
          final existing = currentReplies[id] ?? [];
          currentReplies[id] = [...existing, ...response.comments];
        }
        emit(
          state.copyWith(
            commentReplies: currentReplies,
            loadingReplies: newLoadingSet,
          ),
        );
      },
      failure: (failure) {
        emit(state.copyWith(loadingReplies: newLoadingSet));
        _sideEffectsController.add(ErrorSideEffect(message: failure.message));
      },
    );
  }

  @override
  Future<void> close() {
    _sideEffectsController.close();
    return super.close();
  }
}
