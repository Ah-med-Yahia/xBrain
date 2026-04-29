import 'dart:io';

import 'package:explaino/config/base_state/base_state.dart';
import 'package:explaino/features/auth/register/domain/entities/response/get_tracks_response_entity.dart';
import 'package:explaino/features/auth/register/presentation/ui_models/setup_profile_ui_model.dart';

class RegisterState {
  final String email;
  final SetupProfileUIModel setupProfileUIModel;
  final String otpCode;
  final File? imageFile;
  final bool enabledNextButton;
  final bool enabledCreateAccountButton;
  final bool enabledVerifyButton;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final int currentPage;
  final BaseState<GetTracksResponseEntity>? tracks;

  RegisterState({
    this.email = '',
    this.setupProfileUIModel = const SetupProfileUIModel(),
    this.otpCode = '',
    this.imageFile,
    this.enabledNextButton = false,
    this.enabledCreateAccountButton = false,
    this.enabledVerifyButton = false,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.currentPage = 0,
    this.tracks,
  });

  RegisterState copyWith({
    String? email,
    SetupProfileUIModel? setupProfileUIModel,
    String? otpCode,
    File? imageFile,
    bool? enabledNextButton,
    bool? enabledCreateAccountButton,
    bool? enabledVerifyButton,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    int? currentPage,
    BaseState<GetTracksResponseEntity>? tracks,
  }) {
    return RegisterState(
      email: email ?? this.email,
      setupProfileUIModel: setupProfileUIModel ?? this.setupProfileUIModel,
      otpCode: otpCode ?? this.otpCode,
      imageFile: imageFile ?? this.imageFile,
      enabledNextButton: enabledNextButton ?? this.enabledNextButton,
      enabledCreateAccountButton:
          enabledCreateAccountButton ?? this.enabledCreateAccountButton,
      enabledVerifyButton: enabledVerifyButton ?? this.enabledVerifyButton,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      currentPage: currentPage ?? this.currentPage,
      tracks: tracks ?? this.tracks,
    );
  }
}
