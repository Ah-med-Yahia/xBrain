sealed class RegisterSideEffect {}

class ShowLoading extends RegisterSideEffect {}

class HideLoading extends RegisterSideEffect {}

class ShowError extends RegisterSideEffect {
  final String message;
  ShowError(this.message);
}

class ShowMessage extends RegisterSideEffect {
  final String message;
  ShowMessage(this.message);
}

class NavigateToNextPage extends RegisterSideEffect {
  final String? successMessage;
  NavigateToNextPage({this.successMessage});
}

class NavigateToMainScreen extends RegisterSideEffect {}
