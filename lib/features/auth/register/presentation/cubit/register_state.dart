import 'dart:io';
import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/features/auth/register/presentation/ui_models/get_specializations_response_model_ui.dart';
import 'package:explaino/features/auth/register/presentation/ui_models/setup_profile_ui_model.dart';

class RegisterState {
  final String email;
  final SetupProfileUIModel setupProfileUIModel;
  final String otpCode;
  final File? imageFile;
  final bool enabledNextButton;
  final bool validFirstName;
  final bool validLastName;
  final bool validUserName;
  final bool validPhone;
  final bool validPassword;
  final bool validConfirmPassword;
  final bool enabledCreateAccountButton;
  final bool enabledVerifyButton;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final int currentPage;
  final BaseState<GetSpecializationsResponseModelUi>? specializations;
  final List<String> selectedSpecializations;

  RegisterState({
    this.email = '',
    this.setupProfileUIModel = const SetupProfileUIModel(),
    this.otpCode = '',
    this.imageFile,
    this.enabledNextButton = false,
    this.validFirstName = false,
    this.validLastName = false,
    this.validUserName = false,
    this.validPhone = false,
    this.validPassword = false,
    this.validConfirmPassword = false,
    this.enabledCreateAccountButton = false,
    this.enabledVerifyButton = false,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.currentPage = 0,
    this.specializations,
    this.selectedSpecializations = const [],
  });

  RegisterState copyWith({
    String? email,
    SetupProfileUIModel? setupProfileUIModel,
    String? otpCode,
    File? imageFile,
    bool? enabledNextButton,
    bool? validFirstName,
    bool? validLastName,
    bool? validUserName,
    bool? validPhone,
    bool? validPassword,
    bool? validConfirmPassword,
    bool? enabledCreateAccountButton,
    bool? enabledVerifyButton,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    int? currentPage,
    BaseState<GetSpecializationsResponseModelUi>? specializations,
    List<String>? selectedSpecializations,
  }) {
    return RegisterState(
      email: email ?? this.email,
      setupProfileUIModel: setupProfileUIModel ?? this.setupProfileUIModel,
      otpCode: otpCode ?? this.otpCode,
      imageFile: imageFile ?? this.imageFile,
      enabledNextButton: enabledNextButton ?? this.enabledNextButton,
      validFirstName: validFirstName ?? this.validFirstName,
      validLastName: validLastName ?? this.validLastName,
      validUserName: validUserName ?? this.validUserName,
      validPhone: validPhone ?? this.validPhone,
      validPassword: validPassword ?? this.validPassword,
      validConfirmPassword: validConfirmPassword ?? this.validConfirmPassword,
      enabledCreateAccountButton:
          enabledCreateAccountButton ?? this.enabledCreateAccountButton,
      enabledVerifyButton: enabledVerifyButton ?? this.enabledVerifyButton,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      currentPage: currentPage ?? this.currentPage,
      specializations: specializations ?? this.specializations,
      selectedSpecializations:
          selectedSpecializations ?? this.selectedSpecializations,
    );
  }
}
