import 'package:explaino/config/base_response/base_response.dart';
import 'package:explaino/config/network/safe_api_call.dart';
import 'package:explaino/core/shared/domain/entities/verify_email_request_entity.dart';
import 'package:explaino/features/auth/forgot_password/api/api_clients/forgot_password_api_client.dart';
import 'package:explaino/features/auth/forgot_password/data/data_sources/remote/remote_verify_otp_data_source.dart';
import 'package:explaino/features/auth/forgot_password/data/models/verify_email_models/verify_email_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteVerifyOtpDataSource)
class RemoteVerifyOtpDataSourceImpl implements RemoteVerifyOtpDataSource {
  final ForgotPasswordApiClient _apiClient;

  RemoteVerifyOtpDataSourceImpl(this._apiClient);
  @override
  Future<BaseResponse<VerifyEmailResponseModel>> verifyEmailOtp(
    VerifyEmailRequestEntity request,
  ) async {
    return safeApiCall(() => _apiClient.verifyResetOtpCode(request));
  }
}
