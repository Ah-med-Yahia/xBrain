import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/core/shared/data/mappers/auth/otp/verify_otp_request_mapper.dart';
import 'package:explaino/core/shared/domain/entities/auth/otp/verify_otp_request_entity.dart';
import 'package:explaino/features/auth/register/data/datasources/local/register_local_data_sources.dart';
import 'package:explaino/features/auth/register/data/datasources/remote/register_remote_data_source.dart';
import 'package:explaino/features/auth/register/data/mappers/register_request_mapper.dart';
import 'package:explaino/features/auth/register/domain/entities/request/register_request_entity.dart';
import 'package:explaino/features/auth/register/domain/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource _registerRemoteDataSource;
  final RegisterLocalDataSource _registerLocalDataSource;

  const RegisterRepositoryImpl(
    this._registerRemoteDataSource,
    this._registerLocalDataSource,
  );

  @override
  Future<BaseResponse<String>> sendOtp(RegisterRequestEntity request) async {
    final response = await _registerRemoteDataSource.sendOtp(request.toModel());
    return response.when(
      success: (data) => BaseResponse.success(data.message),
      failure: (error) => BaseResponse.failure(error),
    );
  }

  @override
  Future<BaseResponse<String>> verifyEmailAndRegister(
    VerifyOtpRequestEntity verifyOtpRequestEntity,
  ) async {
    final remoteResponse = await _registerRemoteDataSource
        .verifyEmailAndRegister(verifyOtpRequestEntity.toModel());
    return remoteResponse.when(
      success: (data) async {
        final localResponse = await _registerLocalDataSource.saveTokens(
          data.accessToken,
          data.refreshToken,
        );
        return localResponse.when(
          success: (_) => BaseResponse.success(data.message),
          failure: (error) => BaseResponse.failure(error),
        );
      },
      failure: (error) => BaseResponse.failure(error),
    );
  }
}
