import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/models/auth/otp/otp_response_model/otp_response_model.dart';
import 'package:explaino/core/shared/data/models/auth/otp/verify_otp_request_model/verify_otp_request_model.dart';
import 'package:explaino/core/shared/domain/entities/auth/message_entity.dart';
import 'package:explaino/features/auth/forgot_password/data/data_sources/remote/remote_forgot_password_data_source.dart';
import 'package:explaino/features/auth/forgot_password/data/mappers/verify_email_mapper.dart';
import 'package:explaino/features/auth/forgot_password/data/models/reset_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/data/models/send_otp_code_models/forgot_password_request_model.dart';
import 'package:explaino/features/auth/forgot_password/domain/entities/verify_email_entitt.dart';
import 'package:explaino/features/auth/forgot_password/domain/repositories/forgot_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgotPasswordRepo)
class ForgotPasswordRepoImpl implements ForgotPasswordRepo {
  final RemoteForgotPasswordDataSource _remoteDataSource;

  ForgotPasswordRepoImpl(this._remoteDataSource);
  @override
  Future<BaseResponse<OtpResponseModel>> forgetPassword(
    ForgotPasswordRequestModel request,
  ) async {
    final response = await _remoteDataSource.forgetPassword(request);
    return response.when(
      success: (data) => BaseResponse<OtpResponseModel>.success(data),
      failure: (error) => BaseResponse<OtpResponseModel>.failure(error),
    );
  }

  @override
  Future<BaseResponse<MessageEntity>> resetPassword(
    ResetPasswordRequestModel request,
  ) async {
    final response = await _remoteDataSource.resetPassword(request);
    return response.when(
      success: (data) => BaseResponse<MessageEntity>.success(
        MessageEntity(message: data.message),
      ),
      failure: (error) => BaseResponse<MessageEntity>.failure(error),
    );
  }

  @override
  Future<BaseResponse<VerifyEmailEntity>> verifyEmailOtp(
    VerifyOtpRequestModel request,
  ) async {
    final response = await _remoteDataSource.verifyEmailOtp(request);
    return response.when(
      success: (data) =>
          BaseResponse<VerifyEmailEntity>.success(data.toEntity()),
      failure: (error) => BaseResponse<VerifyEmailEntity>.failure(error),
    );
  }
}
