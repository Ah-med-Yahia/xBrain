class PostActionSideEffects {}

class ErrorWhenLikeOrDislikePost extends PostActionSideEffects {
  final String message;
  ErrorWhenLikeOrDislikePost({required this.message});
}

class LoadingSideEffects extends PostActionSideEffects {}

class HideLoadingSideEffects extends PostActionSideEffects {}

class ErrorSideEffect extends PostActionSideEffects {
  final String message;
  ErrorSideEffect({required this.message});
}

class CommentAddedSuccessfully extends PostActionSideEffects {}

class ReplyAddedSuccessfully extends PostActionSideEffects {}
