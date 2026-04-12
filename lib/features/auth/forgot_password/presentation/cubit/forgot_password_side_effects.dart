sealed class ForgotPasswordSideEffects {}

class ShowError extends ForgotPasswordSideEffects {
  final String message;
  ShowError(this.message);
}

class NavigateToOtpVerificationScreen extends ForgotPasswordSideEffects {
  final String email;
  NavigateToOtpVerificationScreen({required this.email});
}

class NavigateToResetPasswordScreen extends ForgotPasswordSideEffects {
  final String email;
  final String resetToken;
  NavigateToResetPasswordScreen({
    required this.email,
    required this.resetToken,
  });
}

class ShowLoading extends ForgotPasswordSideEffects {}

class NavigateToLoginScreen extends ForgotPasswordSideEffects {}

class ShowMessage extends ForgotPasswordSideEffects {
  final String message;
  ShowMessage(this.message);
}

class HideLoading extends ForgotPasswordSideEffects {}
