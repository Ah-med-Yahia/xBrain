import 'dart:io';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/verify_otp_request_entity.dart';
import 'package:explaino/features/auth/register/domain/entities/request/register_request_entity.dart';
import 'package:explaino/features/auth/register/domain/entities/response/get_specializations_response_entity.dart';

abstract interface class RegisterRepository {
  Future<BaseResponse<String>> sendOtp(RegisterRequestEntity request);
  Future<BaseResponse<String>> verifyEmailAndRegister(
    VerifyOtpRequestEntity verifyOtpRequestEntity,
  );
  Future<BaseResponse<void>> updateProfile({required File image});
  Future<BaseResponse<GetSpecializationsResponseEntity>> getSpecializations();
}
