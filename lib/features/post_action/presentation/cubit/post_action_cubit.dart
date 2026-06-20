import 'dart:async';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/post_action/domain/usecase/get_single_post_use_case.dart';
import 'package:explaino/features/post_action/domain/usecase/like_post_use_case.dart';
import 'package:explaino/features/post_action/domain/usecase/unlike_post_use_case.dart';
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
  }) : super(const PostActionState());

  final GetSinglePostUseCase getSinglePostUseCase;
  final LikePostUseCase likePostUseCase;
  final UnlikePostUseCase dislikePostUseCase;

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
      case AddCommentIntent():
      case AddReplyIntent():
        throw UnimplementedError();
      case DeleteCommentOrReplyIntent():
        throw UnimplementedError();
      case GetCommentsIntent():
        throw UnimplementedError();
      case GetRepliesIntent():
        throw UnimplementedError();
      case GetSingleCommentOrReplyIntent():
        throw UnimplementedError();
      case UpdateCommentOrReplyIntent():
        throw UnimplementedError();
    }
  }

  //================== Post ==================

  void _getSinglePost(String postId) {}

  void _likePost(String postId) async {
    final result = await likePostUseCase(postId);
    result.when(
      success: (post) {
        emit(state.copyWith(post: post));
      },
      failure: (failure) {
        _sideEffectsController.add(ErrorWhenLikeOrDislikePost());
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
        _sideEffectsController.add(ErrorWhenLikeOrDislikePost());
      },
    );
  }

  @override
  Future<void> close() {
    _sideEffectsController.close();
    return super.close();
  }
}
