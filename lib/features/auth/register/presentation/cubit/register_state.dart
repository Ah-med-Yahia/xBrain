class RegisterState {
  final bool enabledNextButton;
  final bool enabledCreateAccountButton;
  final bool enabledVerifyButton;
  final bool obscurePassword;
  final bool obscureConfirmPassword;

  RegisterState({
    this.enabledNextButton = false,
    this.enabledCreateAccountButton = false,
    this.enabledVerifyButton = false,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
  });

  RegisterState copyWith({
    bool? enabledNextButton,
    bool? enabledCreateAccountButton,
    bool? enabledVerifyButton,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
  }) {
    return RegisterState(
      enabledNextButton: enabledNextButton ?? this.enabledNextButton,
      enabledCreateAccountButton:
          enabledCreateAccountButton ?? this.enabledCreateAccountButton,
      enabledVerifyButton: enabledVerifyButton ?? this.enabledVerifyButton,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
    );
  }
}
