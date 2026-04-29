import 'dart:io';

import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/core/helpers/to_multi_part_helper.dart';
import 'package:explaino/core/shared/data/models/auth/auth_response_model/auth_response_model.dart';
import 'package:explaino/core/shared/data/models/auth/otp/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/data/models/auth/user_model/user_model.dart';
import 'package:explaino/features/auth/register/api/api_clients/register_api_client.dart';
import 'package:explaino/features/auth/register/data/datasources/remote/register_remote_data_source.dart';
import 'package:explaino/features/auth/register/data/models/request/register_request_model/register_request_model.dart';
import 'package:explaino/core/shared/data/models/auth/otp/verify_otp_request_model/verify_otp_request_model.dart';
import 'package:explaino/features/auth/register/data/models/response/get_specializations_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRemoteDataSource)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final RegisterApiClient _registerApiClient;

  RegisterRemoteDataSourceImpl(this._registerApiClient);

  @override
  Future<BaseResponse<OtpResponseModel>> sendOtp(RegisterRequestModel request) {
    return safeApiCall(() => _registerApiClient.sendOtp(request));
  }

  @override
  Future<BaseResponse<AuthResponseModel>> verifyEmailAndRegister(
    VerifyOtpRequestModel request,
  ) {
    return safeApiCall(
      () => _registerApiClient.verifyEmailAndRegister(request),
    );
  }

  @override
  Future<BaseResponse<UserModel>> updateProfile({required File image}) async {
    final imageFile = await toMultipartFile(image);
    return safeApiCall(
      () => _registerApiClient.updateProfile(image: imageFile),
    );
  }

  @override
  Future<BaseResponse<GetSpecializationsResponseModel>> getSpecializations() {
    return safeApiCall(() => _registerApiClient.getSpecializations());
  }
}
