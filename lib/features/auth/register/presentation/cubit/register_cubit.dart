import 'dart:async';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/resend_otp_request_entity.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/verify_otp_request_entity.dart';
import 'package:explaino/core/shared/domain/use_cases/auth/resend_otp_use_case.dart';
import 'package:explaino/features/auth/register/domain/entities/request/register_request_entity.dart';
import 'package:explaino/features/auth/register/domain/usecases/send_opt_use_case.dart';
import 'package:explaino/features/auth/register/domain/usecases/verify_email_and_register.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_side_effects.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_state.dart';
import 'package:explaino/features/auth/register/presentation/ui_models/setup_profile_ui_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final SendOptUseCase _sendOtpUseCase;
  final ResendOtpUseCase _resendOtpUseCase;
  final VerifyEmailAndRegisterUseCase _verifyEmailAndRegisterUseCase;

  final StreamController<RegisterSideEffect> _sideEffectsController =
      StreamController<RegisterSideEffect>.broadcast();
  Stream<RegisterSideEffect> get sideEffects => _sideEffectsController.stream;

  RegisterCubit(
    this._sendOtpUseCase,
    this._resendOtpUseCase,
    this._verifyEmailAndRegisterUseCase,
  ) : super(RegisterState());

  void doIntent(RegisterIntent intent) {
    switch (intent) {
      case UpdateEmailIntent(email: final email):
        _updateEmail(email);
      case UpdateSetupProfileIntent(
        setupProfileUIModel: final setupProfileUIModel,
      ):
        _updateSetupProfile(setupProfileUIModel);
      case UpdateOtpCodeIntent(otpCode: final otpCode):
        _updateOtpCode(otpCode);
      case SendOtpIntent(registerRequestEntity: final registerRequestEntity):
        _sendOtp(registerRequestEntity);
      case ResendOtpIntent(
        resendOtpRequestEntity: final resendOtpRequestEntity,
      ):
        _resendOtp(resendOtpRequestEntity);
      case VerifyEmailAndRegisterIntent(
        verifyOtpRequestEntity: final verifyOtpRequestEntity,
      ):
        _verifyEmailAndRegister(verifyOtpRequestEntity);
      case ValidateNextButtonIntent(enabled: final enabled):
        _validateNextButton(enabled: enabled);
      case ValidateCreateAccountButtonIntent(enabled: final enabled):
        _validateCreateAccountButton(enabled: enabled);
      case ValidateVerifyButtonIntent(enabled: final enabled):
        _validateVerifyButton(enabled: enabled);
      case ValidateOtpCodeIntent(enabled: final enabled):
        _validateOtpCode(enabled: enabled);
      case TogglePasswordVisibilityIntent():
        _togglePasswordVisibility();
      case ToggleConfirmPasswordVisibilityIntent():
        _toggleConfirmPasswordVisibility();
      case NavigateToPageIntent(currentPage: final currentPage):
        _navigateToPage(currentPage: currentPage);
    }
  }

  void _updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void _updateSetupProfile(SetupProfileUIModel setupProfileUIModel) {
    emit(state.copyWith(setupProfileUIModel: setupProfileUIModel));
  }

  void _sendOtp(RegisterRequestEntity request) async {
    _sideEffectsController.add(ShowLoading());
    final response = await _sendOtpUseCase(request);
    _sideEffectsController.add(HideLoading());
    response.when(
      success: (data) {
        _sideEffectsController.add(NavigateToVerifyEmail(data));
      },
      failure: (failure) {
        _sideEffectsController.add(ShowError(failure.message));
      },
    );
  }

  void _resendOtp(ResendOtpRequestEntity request) async {
    _sideEffectsController.add(ShowLoading());
    final response = await _resendOtpUseCase(request);
    _sideEffectsController.add(HideLoading());
    response.when(
      success: (data) {
        _sideEffectsController.add(ShowMessage(data));
      },
      failure: (failure) {
        _sideEffectsController.add(ShowError(failure.message));
      },
    );
  }

  void _verifyEmailAndRegister(VerifyOtpRequestEntity request) async {
    _sideEffectsController.add(ShowLoading());
    final response = await _verifyEmailAndRegisterUseCase(request);
    _sideEffectsController.add(HideLoading());
    response.when(
      success: (data) {
        _sideEffectsController.add(NavigateToProfilePicture(data));
      },
      failure: (failure) {
        _sideEffectsController.add(ShowError(failure.message));
      },
    );
  }

  void _updateOtpCode(String otpCode) {
    emit(state.copyWith(otpCode: otpCode));
  }

  void _validateNextButton({required bool enabled}) {
    emit(state.copyWith(enabledNextButton: enabled));
  }

  void _validateCreateAccountButton({required bool enabled}) {
    emit(state.copyWith(enabledCreateAccountButton: enabled));
  }

  void _validateVerifyButton({required bool enabled}) {
    emit(state.copyWith(enabledVerifyButton: enabled));
  }

  void _validateOtpCode({required bool enabled}) {
    emit(state.copyWith(enabledVerifyButton: enabled));
  }

  void _togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _toggleConfirmPasswordVisibility() {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  void _navigateToPage({required int currentPage}) {
    emit(state.copyWith(currentPage: currentPage));
  }

  @override
  Future<void> close() {
    _sideEffectsController.close();
    return super.close();
  }
}
