sealed class ForgotPasswordSideEffects {}

class ShowError extends ForgotPasswordSideEffects {
  final String message;
  ShowError(this.message, {required});
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

class ShowSuccessSendOtp extends ForgotPasswordSideEffects {
  final String message;
  ShowSuccessSendOtp(this.message);
}

class HideLoading extends ForgotPasswordSideEffects {}
