import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/mappers/otp/resend_otp_request_mapper.dart';
import 'package:explaino/core/shared/domain/entities/otp/resend_otp_request_entity.dart';
import 'package:explaino/core/shared/domain/entities/otp/verify_otp_request_entity.dart';
import 'package:explaino/features/auth/register/data/datasources/remote/register_remote_data_source.dart';
import 'package:explaino/features/auth/register/data/mappers/register_request_mapper.dart';
import 'package:explaino/features/auth/register/domain/entities/request/register_request_entity.dart';
import 'package:explaino/features/auth/register/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource _registerRemoteDataSource;

  const RegisterRepositoryImpl(this._registerRemoteDataSource);

  @override
  Future<BaseResponse<String>> sendOtp(RegisterRequestEntity request) async {
    final response = await _registerRemoteDataSource.sendOtp(request.toModel());
    return response.when(
      success: (data) => BaseResponse.success(data.message),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<String>> resendOtp(ResendOtpRequestEntity request) async {
    final response = await _registerRemoteDataSource.resendOtp(
      request.toModel(),
    );
    return response.when(
      success: (data) => BaseResponse.success(data.message),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<String>> verifyEmailAndRegister(
    VerifyOtpRequestEntity verifyOtpRequestEntity,
  ) {
    throw UnimplementedError();
  }
}
