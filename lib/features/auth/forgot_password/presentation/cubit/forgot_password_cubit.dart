import 'dart:async';
import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/verify_otp_request_entity.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/request/forgot_password_request_entity.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:explaino/features/auth/forgot_password/domain/use_case/reset_password_use_case.dart';
import 'package:explaino/features/auth/forgot_password/domain/use_case/send_reset_code_usecase.dart';
import 'package:explaino/features/auth/forgot_password/domain/use_case/verify_otp_usecase.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_intents.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_side_effects.dart';
import 'package:explaino/features/auth/forgot_password/presentation/cubit/forgot_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final _sideEffectController =
      StreamController<ForgotPasswordSideEffects>.broadcast();
  Stream<ForgotPasswordSideEffects> get sideEffects =>
      _sideEffectController.stream;

  final SendResetCodeUseCase _sendResetCodeUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgotPasswordCubit(
    this._sendResetCodeUseCase,
    this._verifyOtpUseCase,
    this._resetPasswordUseCase,
  ) : super(const ForgotPasswordState());

  void doIntent(ForgotPasswordIntent intent) {
    switch (intent) {
      case SendResetCodeIntent(
        forgotPasswordRequestModel: final forgotPasswordRequestModel,
      ):
        _sendResetCode(forgotPasswordRequestModel);
      case VerifyOtpCodeIntent(
        verifyOtpRequestModel: final verifyOtpRequestModel,
      ):
        _verifyOtpCode(verifyOtpRequestModel);
      case ResetPasswordIntent(
        resetPasswordRequestModel: final resetPasswordRequestModel,
      ):
        _resetPassword(resetPasswordRequestModel);
      case ResendOtpCodeIntent(
        forgotPasswordRequestModel: final forgotPasswordRequestModel,
      ):
        _resendOtpCode(forgotPasswordRequestModel);
      case TogglePasswordVisibilityIntent():
        _togglePasswordVisibility();
      case ToggleConfirmPasswordVisibilityIntent():
        _toggleConfirmPasswordVisibility();
    }
  }

  Future<void> _sendResetCode(
    ForgotPasswordRequestEntity forgotPasswordRequestEntity,
  ) async {
    _sideEffectController.add(ShowLoading());
    final result = await _sendResetCodeUseCase(forgotPasswordRequestEntity);
    result.when(
      success: (data) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(
          NavigateToOtpVerificationScreen(email: data.email),
        );
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  Future<void> _verifyOtpCode(
    VerifyOtpRequestEntity verifyOtpRequestEntity,
  ) async {
    _sideEffectController.add(ShowLoading());
    final result = await _verifyOtpUseCase(verifyOtpRequestEntity);
    result.when(
      success: (data) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(
          NavigateToResetPasswordScreen(
            email: data.email,
            resetToken: data.resetToken,
          ),
        );
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  Future<void> _resetPassword(
    ResetPasswordRequestEntity resetPasswordRequestEntity,
  ) async {
    _sideEffectController.add(ShowLoading());
    final result = await _resetPasswordUseCase(resetPasswordRequestEntity);
    result.when(
      success: (data) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(NavigateToLoginScreen());
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  Future<void> _resendOtpCode(
    ForgotPasswordRequestEntity forgotPasswordRequestEntity,
  ) async {
    _sideEffectController.add(ShowLoading());
    final result = await _sendResetCodeUseCase(forgotPasswordRequestEntity);
    result.when(
      success: (data) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(
          ShowSuccessSendOtp(AppTextConstants.codeSentSuccessfully),
        );
      },
      failure: (failure) {
        _sideEffectController.add(HideLoading());
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  void _togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _toggleConfirmPasswordVisibility() {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  @override
  Future<void> close() {
    _sideEffectController.close();
    return super.close();
  }
}
