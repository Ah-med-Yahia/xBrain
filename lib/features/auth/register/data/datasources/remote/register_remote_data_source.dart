import 'dart:io';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/auth/auth_response_model/auth_response_model.dart';
import 'package:explaino/core/shared/data/models/auth/otp/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';
import 'package:explaino/features/auth/register/data/models/request/register_request_model/register_request_model.dart';
import 'package:explaino/core/shared/data/models/auth/otp/verify_otp_request_model/verify_otp_request_model.dart';
import 'package:explaino/features/auth/register/data/models/request/select_specialization_request_model/select_specialization_request_model.dart';
import 'package:explaino/features/auth/register/data/models/response/get_specializations_response_model.dart';
import 'package:explaino/features/auth/register/data/models/response/select_specialization_response_model.dart';

abstract interface class RegisterRemoteDataSource {
  Future<BaseResponse<OtpResponseModel>> sendOtp(RegisterRequestModel request);
  Future<BaseResponse<AuthResponseModel>> verifyEmailAndRegister(
    VerifyOtpRequestModel request,
  );
  Future<BaseResponse<UserModel>> updateProfile({required File image});
  Future<BaseResponse<GetSpecializationsResponseModel>> getSpecializations();
  Future<BaseResponse<SelectSpecializationResponseModel>> selectSpecializations(
    SelectSpecializationRequestModel request,
  );
}
