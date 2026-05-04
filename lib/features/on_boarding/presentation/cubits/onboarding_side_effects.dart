sealed class OnBoardingSideEffects {}

class ShowErrorSideEffect extends OnBoardingSideEffects {
  final String message;
  ShowErrorSideEffect({required this.message});
}

class NavigateToLoginSideEffect extends OnBoardingSideEffects {}
