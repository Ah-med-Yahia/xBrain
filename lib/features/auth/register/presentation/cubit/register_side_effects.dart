sealed class RegisterSideEffect {}

class ShowLoading extends RegisterSideEffect {}

class HideLoading extends RegisterSideEffect {}

class ShowError extends RegisterSideEffect {
  final String message;
  ShowError(this.message);
}

class NavigateToVerifyEmail extends RegisterSideEffect {
  final String successMessage;
  NavigateToVerifyEmail(this.successMessage);
}

class NavigateToHome extends RegisterSideEffect {
  final String successMessage;
  NavigateToHome(this.successMessage);
}
