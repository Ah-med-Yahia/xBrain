import 'package:explaino/features/auth/register/presentation/ui_models/setup_profile_ui_model.dart';

class RegisterState {
  final String email;
  final SetupProfileUIModel setupProfileUIModel;
  final bool enabledNextButton;
  final bool enabledCreateAccountButton;
  final bool enabledVerifyButton;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final int currentPage;

  RegisterState({
    this.email = '',
    this.setupProfileUIModel = const SetupProfileUIModel(),
    this.enabledNextButton = false,
    this.enabledCreateAccountButton = false,
    this.enabledVerifyButton = false,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.currentPage = 0,
  });

  RegisterState copyWith({
    String? email,
    SetupProfileUIModel? setupProfileUIModel,
    bool? enabledNextButton,
    bool? enabledCreateAccountButton,
    bool? enabledVerifyButton,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    int? currentPage,
  }) {
    return RegisterState(
      email: email ?? this.email,
      setupProfileUIModel: setupProfileUIModel ?? this.setupProfileUIModel,
      enabledNextButton: enabledNextButton ?? this.enabledNextButton,
      enabledCreateAccountButton:
          enabledCreateAccountButton ?? this.enabledCreateAccountButton,
      enabledVerifyButton: enabledVerifyButton ?? this.enabledVerifyButton,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
