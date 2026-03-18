sealed class ForgotPasswordSideEffects {}

class ShowError extends ForgotPasswordSideEffects {
  final String message;

  ShowError(this.message);
}

class NavigateToOtpVerificationScreen extends ForgotPasswordSideEffects {}

class ShowLoading extends ForgotPasswordSideEffects {}
