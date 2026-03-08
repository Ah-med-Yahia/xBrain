sealed class LoginSideEffect {}

class ShowError extends LoginSideEffect {
  final String message;

  ShowError(this.message);
}

class NavigateToMainScreen extends LoginSideEffect {}

class ShowLoading extends LoginSideEffect {}
