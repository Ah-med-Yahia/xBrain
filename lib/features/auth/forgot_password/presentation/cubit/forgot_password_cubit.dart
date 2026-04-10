import 'dart:async';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/otp/verify_otp_request_model/verify_otp_request_model.dart';
import 'package:explaino/core/shared/domain/entities/otp/resend_otp_request_entity.dart';
import 'package:explaino/core/shared/domain/use_cases/resend_otp_use_case.dart';
import 'package:explaino/features/auth/forgot_password/data/models/reset_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';
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
  final ResendOtpUseCase _resendOtpUseCase;

  ForgotPasswordCubit(
    this._sendResetCodeUseCase,
    this._verifyOtpUseCase,
    this._resetPasswordUseCase,
    this._resendOtpUseCase,
  ) : super(const ForgotPasswordState());

  void doIntent(ForgotPasswordIntent intent) {
    switch (intent) {
      case SendResetCodeIntent(
        forgotPasswordRequestModel: final forgotPasswordRequestModel,
      ):
        sendResetCode(forgotPasswordRequestModel);
      case VerifyOtpCodeIntent(
        verifyOtpRequestModel: final verifyOtpRequestModel,
      ):
        verifyOtpCode(verifyOtpRequestModel);
      case ResetPasswordIntent(
        resetPasswordRequestModel: final resetPasswordRequestModel,
      ):
        resetPassword(resetPasswordRequestModel);
      case ResendOtpCodeIntent(
        resendOtpRequestEntity: final resendOtpRequestEntity,
      ):
        resendOtpCode(resendOtpRequestEntity);
    }
  }

  Future<void> sendResetCode(
    ForgotPasswordRequestModel forgotPasswordRequestModel,
  ) async {
    _sideEffectController.add(ShowLoading());
    final result = await _sendResetCodeUseCase(forgotPasswordRequestModel);
    result.when(
      success: (data) {
        _sideEffectController.add(
          NavigateToOtpVerificationScreen(email: data.email),
        );
      },
      failure: (failure) {
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  Future<void> verifyOtpCode(
    VerifyOtpRequestModel verifyOtpRequestModel,
  ) async {
    _sideEffectController.add(ShowLoading());
    final result = await _verifyOtpUseCase(verifyOtpRequestModel);
    result.when(
      success: (data) {
        _sideEffectController.add(
          NavigateToResetPasswordScreen(
            email: data.email,
            resetToken: data.resetToken,
          ),
        );
      },
      failure: (failure) {
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  Future<void> resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  ) async {
    _sideEffectController.add(ShowLoading());
    final result = await _resetPasswordUseCase(resetPasswordRequestModel);
    result.when(
      success: (data) {
        _sideEffectController.add(NavigateToLoginScreen());
      },
      failure: (failure) {
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  Future<void> resendOtpCode(
    ResendOtpRequestEntity resendOtpRequestEntity,
  ) async {
    _sideEffectController.add(ShowLoading());
    final result = await _resendOtpUseCase(resendOtpRequestEntity);
    result.when(
      success: (data) {
        _sideEffectController.add(ShowMessage(data));
      },
      failure: (failure) {
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }

  @override
  Future<void> close() {
    _sideEffectController.close();
    return super.close();
  }
}
