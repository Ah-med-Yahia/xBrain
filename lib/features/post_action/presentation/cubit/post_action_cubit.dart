import 'dart:async';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/post_action/domain/entities/request/comment_request_entity.dart';
import 'package:explaino/features/post_action/domain/usecase/add_comment_use_case.dart';
import 'package:explaino/features/post_action/domain/usecase/get_comments_use_case.dart';
import 'package:explaino/features/post_action/domain/usecase/get_single_post_use_case.dart';
import 'package:explaino/features/post_action/domain/usecase/like_post_use_case.dart';
import 'package:explaino/features/post_action/domain/usecase/unlike_post_use_case.dart';
import 'package:explaino/features/post_action/domain/usecase/add_reply_on_comment_use_case.dart';
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
  }) : super(const PostActionState());

  final GetSinglePostUseCase getSinglePostUseCase;
  final LikePostUseCase likePostUseCase;
  final UnlikePostUseCase dislikePostUseCase;
  final GetCommentsUseCase getCommentsUseCase;
  final AddCommentUseCase addCommentUseCase;
  final AddReplyOnCommentUseCase addReplyOnCommentUseCase;

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
      case GetRepliesIntent():
      case GetSingleCommentOrReplyIntent():
      case UpdateCommentOrReplyIntent():
        throw UnimplementedError();
    }
  }

  //================== Post ==================

  void _getSinglePost(String postId) async {
    _sideEffectsController.add(LoadingSideEffects());
    final result = await getSinglePostUseCase(postId);
    _sideEffectsController.add(HideLoadingSideEffects());
    result.when(
      success: (post) {
        emit(state.copyWith(post: post));
      },
      failure: (failure) {
        _sideEffectsController.add(
          ErrorWhenGetSinglePost(message: failure.message),
        );
      },
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
        _getSinglePost(state.post!.id);
      },
      failure: (failure) {
        _sideEffectsController.add(
          ErrorWhenAddComment(message: failure.message),
        );
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
          _getSinglePost(state.post!.id);
        }
      },
      failure: (failure) {
        _sideEffectsController.add(ErrorWhenAddReply(message: failure.message));
      },
    );
  }

  @override
  Future<void> close() {
    _sideEffectsController.close();
    return super.close();
  }
}
