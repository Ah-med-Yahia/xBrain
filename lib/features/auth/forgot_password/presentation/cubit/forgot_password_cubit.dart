import 'dart:async';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/domain/use_case/send_reset_code_usecase.dart';
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
  ForgotPasswordCubit(this._sendResetCodeUseCase)
    : super(const ForgotPasswordState());

  void doIntent(ForgotPasswordIntent intent) {
    switch (intent) {
      case SendResetCodeIntent(
        forgotPasswordRequestModel: final forgotPasswordRequestModel,
      ):
        sendResetCode(forgotPasswordRequestModel);
    }
  }

  Future<void> sendResetCode(
    ForgotPasswordRequestModel forgotPasswordRequestModel,
  ) async {
    _sideEffectController.add(ShowLoading());
    final result = await _sendResetCodeUseCase(forgotPasswordRequestModel);
    result.when(
      success: (data) {
        _sideEffectController.add(NavigateToOtpVerificationScreen());
      },
      failure: (failure) {
        _sideEffectController.add(ShowError(failure.message));
      },
    );
  }
}
