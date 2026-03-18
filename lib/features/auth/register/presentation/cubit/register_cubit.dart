import 'package:explaino/core/shared/domain/entities/otp/resend_otp_request_entity.dart';
import 'package:explaino/core/shared/domain/entities/otp/verify_otp_request_entity.dart';
import 'package:explaino/core/shared/domain/use_cases/resend_otp_use_case.dart';
import 'package:explaino/features/auth/register/domain/entities/request/register_request_entity.dart';
import 'package:explaino/features/auth/register/domain/usecases/send_opt_use_case.dart';
import 'package:explaino/features/auth/register/domain/usecases/verify_email_and_register.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_intents.dart';
import 'package:explaino/features/auth/register/presentation/cubit/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final SendOptUseCase _sendOtpUseCase;
  final ResendOtpUseCase _resendOtpUseCase;
  final VerifyEmailAndRegisterUseCase _verifyEmailAndRegisterUseCase;
  RegisterCubit(
    this._sendOtpUseCase,
    this._resendOtpUseCase,
    this._verifyEmailAndRegisterUseCase,
  ) : super(RegisterState());

  void doIntent(RegisterIntent intent) {
    switch (intent) {
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
    }
  }

  void _sendOtp(RegisterRequestEntity request) async {
    await _sendOtpUseCase(request);
  }

  void _resendOtp(ResendOtpRequestEntity request) async {
    await _resendOtpUseCase(request);
  }

  void _verifyEmailAndRegister(VerifyOtpRequestEntity request) async {
    await _verifyEmailAndRegisterUseCase(request);
  }
}
