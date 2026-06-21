class PostActionSideEffects {}

class ErrorWhenLikeOrDislikePost extends PostActionSideEffects {
  final String message;
  ErrorWhenLikeOrDislikePost({required this.message});
}

class LoadingSideEffects extends PostActionSideEffects {}

class HideLoadingSideEffects extends PostActionSideEffects {}

class ErrorWhenGetSinglePost extends PostActionSideEffects {
  final String message;
  ErrorWhenGetSinglePost({required this.message});
}

class ErrorWhenGetComments extends PostActionSideEffects {
  final String message;
  ErrorWhenGetComments({required this.message});
}
