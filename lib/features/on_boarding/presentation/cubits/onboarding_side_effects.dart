sealed class OnBoardingSideEffects {}

class ShowErrorSideEffect extends OnBoardingSideEffects {
  final String message;
  ShowErrorSideEffect({required this.message});
}

class ShowLoadingSideEffect extends OnBoardingSideEffects {}

class HideLoadingSideEffect extends OnBoardingSideEffects {}

class NavigateToLoginSideEffect extends OnBoardingSideEffects {}
